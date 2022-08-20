#include "qqserver.h"
#include "ui_qqserver.h"

QQServer::QQServer(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::QQServer)
{
    ui->setupUi(this);
    quint16 listenPort=9990;
    this->setWindowTitle(QString("服务端监听%1").arg(listenPort));
    //创建套接字
    udpSocket=new QUdpSocket(this);
    //监听
    udpSocket->bind(QHostAddress::Any,listenPort);
    //readyRead响应
    connect(udpSocket,&QUdpSocket::readyRead,
            this,&QQServer::on_udpSocket_readyRead);
    //测试代码
}

QQServer::~QQServer()
{
    delete ui;
}

//收
void QQServer::on_udpSocket_readyRead()
{
    //收到UDP包，提取信息：对方IP，端口，报文
    //准备空间
    char buf[1024]={0};
    QHostAddress ip;
    quint16 port;
    //提取
    qint64 len = udpSocket->readDatagram(buf,sizeof(buf),&ip,&port);
    //显示+处理
    if(len>0)
    {
        QString content=QString("[%1,%2]：%3")
                .arg(ip.toString())
                .arg(port)
                .arg(buf);
        ui->textBrowser->append(content);
        //携带全部信息，进行命令解析+分发
        parseCommand(buf,ip,port);//注意只写buf，不要把content写进来
    }
    else
    {
        QString content=QString("收取失败");
        ui->textEdit->append(content);
    }
}

//发
void QQServer::sendMessage(QString content,QString ip, QString port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),QHostAddress(ip),port.toUInt());
}

void QQServer::sendMessage(QString content,QHostAddress ip, quint16 port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),ip,port);
}


//解析
void QQServer::parseCommand(QString jsonStr,QHostAddress ip, quint16 port)
{
    //生成json对象
    QJsonParseError error;
    QByteArray jsonByteArray=jsonStr.toUtf8();
    QJsonObject obj=QJsonDocument::fromJson(jsonByteArray,&error).object();//出错
    //解析命令
    QString command=obj["command"].toString();
    if (command=="register") //推荐用对应的函数名
    {
        //注册
        QString user=obj["user"].toString();
        QString password=obj["password"].toString();
        //注册函数
        //返回信息（待定）
        sendMessage("register backward",ip,port);
    }
    else if(command=="login")
    {
        //登录
        int id=obj["id"].toInt();
        QString password=obj["password"].toString();
        //登录函数
        //返回信息（待定）
        sendMessage("login backward",ip,port);
    }
    else if(command=="sendToFriend")
    {
        //单发
    }
    else if(command=="sendToGroup")
    {
        //群发
    }
    else
    {
        //未知命令
        sendMessage("未知命令",ip,port);
    }

}



