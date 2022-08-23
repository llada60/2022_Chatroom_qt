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
    QObject* registerWindow=root->findChild<QObject*>("registerWindow");
    QObject::connect(registerWindow,SIGNAL(registerSignal(QString,QString)), //注册
                     this,SLOT(registerAccount(QString,QString)));
    QObject* chatScreen=root->findChild<QObject*>("mainWindow")->findChild<QObject*>("chatWindow1")
            ->findChild<QObject*>("chatWindow2")->findChild<QObject*>("chatScreen");
    QObject::connect(chatScreen,SIGNAL(sendMessageSignal(int,QString,int)),
                     this,SLOT(sendChatMessage(int,QString,int)));


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
    QObject* registerButton=root->findChild<QObject*>("registerWindow")
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
    char buf[4096]={0};
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
    else if(command=="sendChatMessageBack")//收到单发消息
    {
        sendChatMessageBack(obj);
    }
    else if(command=="searchBack")//查找响应
    {
        searchBack(obj);
    }
    else if(command=="addBack")//添加响应
    {
        addBack(obj);
    }
    else if(command=="deleteBack")//删除响应
    {
        deleteBack(obj);
    }
    else if(command=="friendBack")//好友列表响应
    {
        friendBack(obj);
    }
    else if(command=="groupBack")//群列表响应
    {
        groupBack(obj);
    }
    else if(command=="messageBack")//历史消息响应
    {
        messageBack(obj);
    }
    else
    {
        //未知命令
        qDebug()<<"未知命令";
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
    //测试代码

    //add(100002);
    //deleteRequest(100002);
    //friendRequest(100001);
    //groupRequest(100001);
    messageRequest(100001);

}

//单发请求
void QQClient::sendChatMessage(int targetId, QString content,int time)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","sendChatMessage");
    jsonObj.insert("sendId",clientId);
    jsonObj.insert("targetId",targetId);
    jsonObj.insert("content",content);
    jsonObj.insert("time",time);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}

//查找请求
void QQClient::search(int targetId)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","search");
    jsonObj.insert("targetId",targetId);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}

//添加请求
void QQClient::add(int targetId)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","add");
    jsonObj.insert("targetId",targetId);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}

//删除请求
void QQClient::deleteRequest(int targetId)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","delete");
    jsonObj.insert("targetId",targetId);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}
//好友列表请求
void QQClient::friendRequest(int id)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","friendRequest");
    jsonObj.insert("id",id);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}
//历史消息请求
void QQClient::messageRequest(int id)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","messageRequest");
    jsonObj.insert("id",id);
    QString diagram=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(diagram,this->hostIp,this->hostPort);
}
//群列表请求
void QQClient::groupRequest(int id)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","groupRequest");
    jsonObj.insert("id",id);
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
    QObject* registerWindow=root->findChild<QObject*>("registerWindow");
    QMetaObject::invokeMethod(registerWindow,"registerBack",
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
void QQClient::sendChatMessageBack(QJsonObject obj)
{
    //解包
    int sendId=obj["sendId"].toInt();
    QString content=obj["content"].toString();
    int time=obj["time"].toInt();
    //结合本地数据构建消息包
    QJsonObject jsonObj;
    jsonObj.insert("uid",sendId);
    jsonObj.insert("name","cyy");//这里要从id获取名字
    jsonObj.insert("time",time);
    jsonObj.insert("message",content);//头像应该也是从id获取
    jsonObj.insert("avatar","https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1");
    jsonObj.insert("type",0);
    //调用QML函数
    QVariant res;
    QObject* chatScreen=root->findChild<QObject*>("mainWindow")->findChild<QObject*>("chatWindow1")
            ->findChild<QObject*>("chatWindow2")->findChild<QObject*>("chatScreen");
    QMetaObject::invokeMethod(chatScreen,"appendData",
                              Q_RETURN_ARG(QVariant,res),
                              Q_ARG(QVariant,jsonObj)
                              );
}
//查找响应
void QQClient::searchBack(QJsonObject obj)
{
    qDebug()<<"searchBack()"<<obj;
}
//添加响应
void QQClient::addBack(QJsonObject obj)
{
    qDebug()<<"addBack()"<<obj;
}
//删除响应
void QQClient::deleteBack(QJsonObject obj)
{
    qDebug()<<"deleteBack()"<<obj;
}
//朋友列表响应
void QQClient::friendBack(QJsonObject obj)
{
    //解包
    QJsonArray friendJsonList=obj["list"].toArray();
    //清空原有朋友列表
    friendList.clear();
    //遍历添加刷新后朋友列表
    for(int i=0;i<friendJsonList.size();i++)
    {
        //解包
        QJsonObject user=friendJsonList[i].toObject();
        //添加对象
        this->friendList.append(new User(
                                    user["id"].toInt(),
                                    user["name"].toString(),
                                    user["icon"].toString())
                                        );
    }
}
//历史消息响应
void QQClient::messageBack(QJsonObject obj)
{
    //解包
    QJsonObject friendMessages=obj["friendlist"].toObject();
    QJsonObject groupMessages=obj["grouplist"].toObject();
    //时间还是string
    qDebug()<<friendMessages;
    qDebug()<<groupMessages;

}
//群列表响应
void QQClient::groupBack(QJsonObject obj)
{
    //解包
    QJsonArray groupJsonList=obj["groupList"].toArray();
    //清空原有朋友列表
    groupList.clear();
    //遍历添加刷新后朋友列表
    for(int i=0;i<groupJsonList.size();i++)
    {
        //解包
        QJsonObject group=groupJsonList[i].toObject();
        //添加对象
        this->groupList.append(new Group(group["id"].toInt(),
                               group["name"].toString(),
                               group["icon"].toString(),
                               group["intro"].toString(),
                               group["notice"].toString())
                               );
    }
    for(int i=0;i<groupList.length();i++)
    {
        qDebug()<<groupList[i]->name;
    }
}


}
