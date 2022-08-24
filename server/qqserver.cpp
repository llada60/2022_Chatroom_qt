#include "qqserver.h"
#include "ui_qqserver.h"
#include "onlinelist.h"

QQServer::QQServer(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::QQServer)
{
    ui->setupUi(this);
    //监听端口设置
    quint16 listenPort=9990;
    this->setWindowTitle(QString("服务端监听%1").arg(listenPort));
    //创建套接字
    udpSocket=new QUdpSocket(this);
    //监听
    udpSocket->bind(QHostAddress::Any,listenPort);
    //readyRead响应
    connect(udpSocket,&QUdpSocket::readyRead,
            this,&QQServer::onUdpSocketReadyRead);
    //建立数据库连接，初始化数据模型
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("Info.db");
    db.open();
    atModel = new SqlAccountModel(this, db);
    fdModel = new SqlFriendModel(this, db);
    gpModel = new SqlGroupModel(this, db);
    //测试代码
    test(atModel,fdModel,gpModel);

}

QQServer::~QQServer()
{
    delete ui;
    delete fdModel;
    delete atModel;
    delete gpModel;
}

//收
void QQServer::onUdpSocketReadyRead()
{
    //收到UDP包，提取信息：对方IP，端口，报文
    //准备空间
    char buf[4096]={0};
    QHostAddress ip;
    quint16 port;
    //提取
    qint64 len = udpSocket->readDatagram(buf,sizeof(buf),&ip,&port);
    //显示+处理
    if(len>0)
    {
        //这里不做解析，基本不做处理，解析交给parseCommand
        QString content=QString("[%1,%2]：\n%3")
                .arg(ip.toString())
                .arg(port)
                .arg(buf);
        ui->textBrowser->append(content);//显示到窗口和控制台
        qDebug()<<"收到命令："<<content<<'\n';
        //携带全部信息，进行命令解析+分发
        parseCommand(buf,ip,port);//注意只写buf，不要把content写进来
    }
    else
    {
        QString content=QString("收取失败");
        qDebug()<<content<<'\n';
    }
}
//获取在线用户ip port
QJsonObject QQServer::getTargetIpPort(int targetId)
{
    for(int i=0;i<onlineUser.length();i++)
    {
        if(targetId==onlineUser[i]->id)//找到
        {
            QJsonObject targetObj;
            targetObj.insert("ip",onlineUser[i]->ip.toString());
            targetObj.insert("port",onlineUser[i]->port);
            return targetObj;
        }
    }
    QJsonObject targetObj;
    targetObj.insert("ip","0");
    targetObj.insert("port",0);
    return targetObj;
}

//发（类型的排列组合）
void QQServer::sendMessage(QString content,QString ip, QString port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),QHostAddress(ip),port.toUInt());
}

void QQServer::sendMessage(QString content,QHostAddress ip, quint16 port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),ip,port);
}

void QQServer::sendMessage(QByteArray content, QHostAddress ip, quint16 port)
{
    udpSocket->writeDatagram(content,ip,port);
}

void QQServer::sendMessage(QByteArray content, QString ip, QString port)
{
    udpSocket->writeDatagram(content,QHostAddress(ip),port.toUInt());
}

//解析
void QQServer::parseCommand(QString jsonStr,QHostAddress ip, quint16 port)
{
    //生成json对象
    QJsonParseError error;
    QByteArray jsonByteArray=jsonStr.toUtf8();
    QJsonObject obj=QJsonDocument::fromJson(jsonByteArray,&error).object();
    //解析命令
    QString command=obj["command"].toString();
    //推荐用对应的函数名
    if (command=="register") //注册
    {
        registerRespond(obj,ip,port);
    }
    else if(command=="login")//登录
    {
        loginRespond(obj,ip,port);
    }
    else if(command=="sendChatMessage")//发消息
    {
        sendChatMessageRespond(obj,ip,port);
    }
    else if(command=="search")//查找群/人
    {
        searchRespond(obj,ip,port);
    }
    else if(command=="add")//添加
    {
        addRespond(obj,ip,port);
    }
    else if(command=="delete")//删除
    {
        deleteRespond(obj,ip,port);
    }
    else if(command=="friendRequest")//好友列表
    {
        friendRespond(obj,ip,port);
    }
    else if(command=="groupRequest")//群列表
    {
        groupRespond(obj,ip,port);
    }
    else if(command=="messageRequest")//历史消息
    {
        messageRespond(obj,ip,port);
    }
    else
    {
        //未知命令
        sendMessage(QString("未知命令"),ip,port);
    }

}

//客户端响应函数
void QQServer::registerRespond(QJsonObject obj,QHostAddress ip,quint16 port)
{
    //解包
    QString user=obj["user"].toString();
    QString password=obj["password"].toString();
    //注册+返回
    sendMessage(atModel->addUserAccount(user, password),ip,port);
}

void QQServer::loginRespond(QJsonObject obj,QHostAddress ip,quint16 port)
{
    //解包
    int id=obj["id"].toInt();
    QString password=obj["password"].toString();
    //登录
    QByteArray respond=atModel->checkAccount(id, password);
    bool loginOk=QJsonDocument::fromJson(respond).object()["result"].toBool();
    if(loginOk)//成功登录，添加在线列表
    {
        onlineUser.append(new User(ip,port,id));
        //测试显示
        User* last=onlineUser.last();
        qDebug()<<"上线："<<last->id<<last->ip<<last->port;
    }
    //返回信息
    sendMessage(respond,ip,port);
}

//临时用，后面要进行群和人id的区分以及细化操作
//发消息从在线列表里法
//存记录存所有记录
void QQServer::sendChatMessageRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包
    int sendId=obj["sendId"].toInt();
    int targetId=obj["targetId"].toInt();
    QString content=obj["content"].toString();
    int time=obj["time"].toInt();
    int type=obj["type"].toInt();
    //根据id判断群/人
    if(targetId/100000==1)
    {
        //取目标ip和port
        QJsonObject targetObj=getTargetIpPort(targetId);
        QString targetIp=targetObj["ip"].toString();
        QString targetPort=QString("%1").arg(targetObj["port"].toInt());
        //转发消息
        QJsonObject jsonObj;
        jsonObj.insert("command","sendChatMessageBack");
        jsonObj.insert("sendId",sendId);
        jsonObj.insert("content",content);
        jsonObj.insert("time",time);
        QString diagram=QJsonDocument(jsonObj).toJson();
        sendMessage(diagram,targetIp,targetPort);
        //数据库添加聊天记录
        fdModel->sendMessage(sendId, targetId, type, time, content);
    }
    else
    {
        //取群成员
        Group* group = new Group(targetId,gpModel);
        //遍历发送

        //添加数据库
    }

}

void QQServer::searchRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包
    int targetId=obj["targetId"].toInt();
    //从数据库查数据
    QJsonObject userObj=QJsonDocument::fromJson(atModel->userInfo(targetId)).object();
    QJsonObject groupObj=QJsonDocument::fromJson(gpModel->groupInfo(targetId)).object();
    //封装响应
    QJsonObject respondObj;
    respondObj.insert("command","searchBack");
    if(!userObj["result"].isNull())//找到用户
    {
        respondObj.insert("finded",true);
        respondObj.insert("isPerson",true);
        respondObj.insert("pName",userObj["result"].toObject()["name"].toString());
        respondObj.insert("headImg",userObj["result"].toObject()["icon"].toString());


    }
    else if(!groupObj["result"].isNull())//找到群
    {
        respondObj.insert("finded",true);
        respondObj.insert("isPerson",false);
        respondObj.insert("pName",userObj["result"].toObject()["name"].toString());
        respondObj.insert("headImg",userObj["result"].toObject()["icon"].toString());
    }
    else //啥都没找到
    {
        respondObj.insert("finded",false);
        respondObj.insert("isPerson",false);
        respondObj.insert("pName","无结果");
        respondObj.insert("headImg","无结果");
    }
    QString diagram=QJsonDocument(respondObj).toJson();
    sendMessage(diagram,ip,port);
}

void QQServer::addRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包
    int sendId=obj["sendId"].toInt();
    int targetId=obj["targetId"].toInt();
    //处理
    bool succeed = fdModel->addFriend(sendId,targetId);
    //双向返回信息
    if(succeed)
    {
        //发送者回传
        QJsonObject respondObj;
        respondObj.insert("command","addBack");
        respondObj.insert("friendId",targetId);
        QString diagram=QJsonDocument(respondObj).toJson();
        sendMessage(diagram,ip,port);
        qDebug()<<"addRespond()"<<ip<<port;
        //接受者转发
        QJsonObject targetObj=getTargetIpPort(targetId);
        QJsonObject respondToTargetObj;
        QString targetIp=targetObj["ip"].toString();
        QString targetPort=QString("%1").arg(targetObj["port"].toInt());//int不能直接转str
        respondToTargetObj.insert("command","addBack");
        respondToTargetObj.insert("friendId",sendId);
        QString diagramToTarget=QJsonDocument(respondToTargetObj).toJson();
        sendMessage(diagramToTarget,targetIp,targetPort);
        qDebug()<<"addRespond()"<<targetIp<<targetPort;
    }
    else //加好友失败，id全是0
    {
        QJsonObject respondObj;
        respondObj.insert("command","addBack");
        respondObj.insert("friendId",0);
        QString diagram=QJsonDocument(respondObj).toJson();
        sendMessage(diagram,ip,port);
        //找到接受者ip,port(不在线也无所谓)
        QJsonObject targetObj=getTargetIpPort(targetId);
        if(targetObj["port"].toInt()!=0)
        {
            QJsonObject respondToTargetObj;
            respondToTargetObj.insert("command","addBack");
            respondToTargetObj.insert("friendId",0);
            QString diagramToTarget=QJsonDocument(respondToTargetObj).toJson();
            sendMessage(diagramToTarget,targetObj["ip"].toString(),targetObj["port"].toString());
        }
    }

}

void QQServer::deleteRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包

    //处理
    QJsonObject respondObj;
    respondObj.insert("command","deleteBack");
    //返回
    QString diagram=QJsonDocument(respondObj).toJson();
    sendMessage(diagram,ip,port);
}

void QQServer::friendRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包
    int id=obj["id"].toInt();
    //处理+返回
    sendMessage(fdModel->friendList(id),ip,port);
}

void QQServer::groupRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包
    int id=obj["id"].toInt();
    //处理+返回
    sendMessage(gpModel->groupList(id),ip,port);
}

void QQServer::messageRespond(QJsonObject obj, QHostAddress ip, quint16 port)
{
    //解包
    int targetId=obj["targetId"].toInt();
    int requestId=obj["requestId"].toInt();
    //处理+返回
    QByteArray diagram;
    if(targetId/100000==1) //人
    {
        diagram=fdModel->messageList(requestId,targetId);
    }
    else //群
    {
        diagram=gpModel->messageList(targetId);
    }
    sendMessage(diagram,ip,port);
}

void QQServer::test(SqlAccountModel *atModel, SqlFriendModel *fdModel, SqlGroupModel *gpModel)
{
    /*
    atModel->addUserAccount("cyy","123");//创建
    atModel->addUserAccount("chen","123");
    atModel->addUserAccount("丁真","123");
    atModel->addUserAccount("雪豹","123");
    atModel->addUserAccount("刀哥","123");
    atModel->addUserAccount("虎哥","123");

    fdModel->addFriend(100001,100002);//加好友
    fdModel->addFriend(100001,100003);
    fdModel->addFriend(100001,100004);

    gpModel->createGroup(100001);//建群加群
    gpModel->joinGroup(600001,100002,0);
    gpModel->joinGroup(600001,100003,0);
    gpModel->createGroup(100002);
    gpModel->joinGroup(600002,100001,0);
    gpModel->joinGroup(600002,100003,0);

    fdModel->sendMessage(100001,100002,0,1,"你好");//消息
    fdModel->sendMessage(100002,100001,0,1,"我是丁真");
    fdModel->sendMessage(100001,100003,0,1,"我是雪豹");
    fdModel->sendMessage(100003,100001,0,1,"雪豹闭嘴");


    gpModel->sendMessage(600001,100001,0,1,"群发1");//群发
    gpModel->sendMessage(600001,100002,0,1,"群发2");
    gpModel->sendMessage(600001,100003,0,1,"群发2");
    gpModel->sendMessage(600002,100001,0,1,"群发3");
    gpModel->sendMessage(600002,100002,0,3,"群发5");
    gpModel->sendMessage(600002,100003,0,3,"群发5");
    */
}


