#include "qqclient.h"
#include "ui_qqclient.h"

QQClient::QQClient(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::QQClient)
{
    ui->setupUi(this);
    quint16 listenPort=9991;
    this->setWindowTitle(QString("客户端监听%1").arg(listenPort));
    //创建套接字
    udpSocket=new QUdpSocket(this);
    //监听
    udpSocket->bind(QHostAddress::Any,listenPort);
    //readyRead响应
    connect(udpSocket,&QUdpSocket::readyRead,
            this,&QQClient::on_udpSocket_readyRead);
}

QQClient::~QQClient()
{
    delete ui;
}

//注册按钮槽函数
void QQClient::on_registerButton_clicked()
{
    //这里提取出user和password
    QString user="cyy";
    QString password="123456";
    //调用函数
    registerAcount(user,password);
}

//登录按钮槽函数
void QQClient::on_loginButton_clicked()
{
    //这里提取出id和password
    int id=123;
    QString password="123456";
    //调用函数
    login(id,password);
}

//收
void QQClient::on_udpSocket_readyRead()
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
    }
    else
    {
        QString content=QString("收取失败");
        ui->textEdit->append(content);
    }

}
//发
void QQClient::sendMessage(QString content, QString ip, QString port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),QHostAddress(ip),port.toUInt());
}

void QQClient::sendMessage(QString content, QHostAddress ip, quint16 port)
{
    udpSocket->writeDatagram(content.toUtf8().data(),ip,port);
}

//注册
void QQClient::registerAcount(QString user, QString password)
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
//登录
void QQClient::login(int id, QString password)
{
    //封装Json
    QJsonObject jsonObj;
    jsonObj.insert("command","login");
    jsonObj.insert("id",id);
    jsonObj.insert("password",password);
    QString content=QJsonDocument(jsonObj).toJson();
    //发送
    sendMessage(content,this->hostIp,this->hostPort);
}


