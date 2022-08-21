#ifndef QQCLIENT_H
#define QQCLIENT_H
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
#include <QHostAddress>
#include <QUdpSocket>
#include <QQmlApplicationEngine>

class QQClient:public QObject
{
    Q_OBJECT
public:
    //初始化的时候把QMLengine塞进去
    QQClient(QQmlApplicationEngine* engine,QObject *parent = nullptr);
    ~QQClient();

    //关于按钮的槽函数我写的只是凑合用的
    //你按着我的逻辑自己写即可
private slots:
    //请求函数：QML到C++的槽函数
    void registerAccount(QString user,QString password);
    void login(int id,QString password);
private:
    //固定服务器ip和端口
    QUdpSocket* udpSocket;
    QHostAddress hostIp=QHostAddress("127.0.0.1");
    quint16 hostPort=9990;
    //前端通信engine
    QQmlApplicationEngine* engine=NULL;
    QObject* root=NULL;
    //基本通信方法
    void on_udpSocket_readyRead();
    void sendMessage(QString content,QString ip,QString port);//不同参数类型的的发送信息
    void sendMessage(QString content,QHostAddress ip,quint16 port);
    void sendMessage(QByteArray content,QHostAddress ip,quint16 port);
    void sendMessage(QByteArray content,QString ip,QString port);
    //数据包通信解析
    void parseCommand(QString jsonStr,QHostAddress ip,quint16 port);
    //响应函数：C++到QML的函数
    void registerBack();
    void loginBack();

};


#endif // QQCLIENT_H
