#include "qqclient.h"

QQClient::QQClient(QQmlApplicationEngine *engine, QObject *parent)
{
    //保存前端指针
    this->engine=engine;
    this->root=engine->rootObjects().first();//Qt对象树结构,root是qml全局的根节点，唯一
    //qDebug()<<root->property("width");
    //客户端设置
    quint16 listenPort=9991;
    qDebug()<<QString("客户端监听%1").arg(listenPort);
    //创建套接字
    udpSocket=new QUdpSocket(this);
    //监听
    udpSocket->bind(QHostAddress::Any,listenPort);
    //readyRead响应
    connect(udpSocket,&QUdpSocket::readyRead,
            this,&QQClient::on_udpSocket_readyRead);
    //
    //qml到C++(信号型通讯)
    QObject::connect(root,SIGNAL(loginSignal(int,QString)), //登录
                     this,SLOT(login(int,QString)));
    QObject* registerWindows=root->findChild<QObject*>("registerWindows");
    QObject::connect(registerWindows,SIGNAL(registerSignal(QString,QString)), //注册
                     this,SLOT(registerAccount(QString,QString)));

    /*
    //c++调qml函数（例子）
    QVariant res;
    QVariant input="C++到qml";
    QMetaObject::invokeMethod(root,"myFunc",
                              Q_RETURN_ARG(QVariant,res),
                              Q_ARG(QVariant,input));
    */

    /*
    // 节点测试
    QObject* registerButton=root->findChild<QObject*>("registerWindows")
            ->findChild<QObject*>("registerButton");//注册按钮节点
    qDebug()<<loginButton->property("width"); //要是正常输出属性就说明找对了
    */
}

QQClient::~QQClient()
{

}

//标准收
void QQClient::on_udpSocket_readyRead()
{
    //收到UDP包，提取信息：对方IP，端口，报文
    //准备空间
    char buf[1024]={0};
    QHostAddress ip;
    quint16 port;
    QJsonParseError parseErr;
    QJsonObject recObj;
    QString result;
    //提取
    qint64 len = udpSocket->readDatagram(buf,sizeof(buf),&ip,&port);
    //显示+处理
    if(len>0)
    {
        //这里不做解析，基本不做处理，解析交给parseCommand
        QString content=QString("[%1,%2]：%3")
                        .arg(ip.toString())
                        .arg(port)
                        .arg(buf);
        qDebug()<<content<<'\n';
        //携带全部信息，进行命令解析+分发
        parseCommand(buf,ip,port);//注意只写buf，不要把content写进来
    }
    else
    {
        QString content=QString("收取失败");
        qDebug()<<content<<'\n';
    }

}

//标准发（类型的排列组合）
void QQClient::sendMessage(QString content,QString ip, QString port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),QHostAddress(ip),port.toUInt());
}

void QQClient::sendMessage(QString content,QHostAddress ip, quint16 port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),ip,port);
}

void QQClient::sendMessage(QByteArray content, QHostAddress ip, quint16 port)
{
    udpSocket->writeDatagram(content,ip,port);
}

void QQClient::sendMessage(QByteArray content, QString ip, QString port)
{
    udpSocket->writeDatagram(content,QHostAddress(ip),port.toUInt());
}

//响应解析
void QQClient::parseCommand(QString jsonStr,QHostAddress ip, quint16 port)
{
    //生成json对象
    QJsonParseError error;
    QByteArray jsonByteArray=jsonStr.toUtf8();
    QJsonObject obj=QJsonDocument::fromJson(jsonByteArray,&error).object();
    //解析命令
    QString command=obj["command"].toString();
    //推荐用对应的函数名
    if (command=="registerBack")//注册响应
    {
        registerBack(obj);
    }
    else if(command=="loginBack")//登录响应
    {
        loginBack(obj);
    }
    else if(command=="sendToFriendBack")//收到单发消息
    {
        sendToFriendBack(obj);
    }
    else if(command=="sendToGroupBack")//收到群发消息
    {
        //群发
    }
    else
    {
        //未知命令
        sendMessage(QString("未知命令"),ip,port);
    }

}


//请求函数
//注册请求
void QQClient::registerAccount(QString user, QString password)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","register");
    jsonObj.insert("user",user);
    jsonObj.insert("password",password);
    QString content=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(content,this->hostIp,this->hostPort);
}

//登录请求
void QQClient::login(int id, QString password)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","login");
    jsonObj.insert("id",id);
    jsonObj.insert("password",password);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
    //设置临时客户端id
    clientId=id;
}

//单发请求
void QQClient::sendToFriend(int targetId, QString content,QString time)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","sendToFriend");
    jsonObj.insert("sendId",clientId);
    jsonObj.insert("targetId",targetId);
    jsonObj.insert("content",content);
    jsonObj.insert("time",time);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}

//响应函数
//注册响应

void QQClient::registerBack(QJsonObject obj)
{
    //注册
    int id=obj["id"].toInt();
    qDebug()<<"register";
    //调用QML注册函数
    QVariant res; //如果QML函数没有返回值会不会报错？
    QObject* registerWindows=root->findChild<QObject*>("registerWindows");
    QMetaObject::invokeMethod(registerWindows,"registerBack",
                              Q_RETURN_ARG(QVariant,res),
                              Q_ARG(QVariant,id));
}

//登录响应
void QQClient::loginBack(QJsonObject obj)
{
    //登录
    bool isSuccess=obj["result"].toBool();
    //如果登录失败就重置客户端id
    if (!isSuccess)
    {
        clientId=0;
    }
    //调用QML登录函数
    QVariant res; //如果QML函数没有返回值会不会报错？
    QMetaObject::invokeMethod(root,"loginBack",
                              Q_RETURN_ARG(QVariant,res),
                              Q_ARG(QVariant,isSuccess));

}
//单发响应
void QQClient::sendToFriendBack(QJsonObject obj)
{
    //解包
    int sendId=obj["sendId"].toInt();
    QString content=obj["content"].toString();
    QString time=obj["time"].toString();
    //调用QML函数
    QVariant res;
    QMetaObject::invokeMethod(root,"sendToFriendBack",
                              Q_RETURN_ARG(QVariant,res),
                              Q_ARG(QVariant,sendId),
                              Q_ARG(QVariant,content),
                              Q_ARG(QVariant,time));
}



