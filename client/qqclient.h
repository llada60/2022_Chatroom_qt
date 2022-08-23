#ifndef QQCLIENT_H
#define QQCLIENT_H
#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
#include <QHostAddress>
#include <QUdpSocket>
#include <QQmlApplicationEngine>
#include <QDateTime>
#include <iostream>



class QQClient:public QObject
{
    Q_OBJECT
public:
    //初始化的时候把QMLengine塞进去
    QQClient(QQmlApplicationEngine* engine,QObject *parent = nullptr);
    ~QQClient();

private slots:
    //请求函数：QML到C++的槽函数
    void registerAccount(QString user,QString password);
    void login(int id,QString password);
    void sendChatMessage(int targetId,QString content,int time);
private:
    //配置信息
    QUdpSocket* udpSocket;//服务器ip和端口
    QHostAddress hostIp=QHostAddress("127.0.0.1");
    quint16 hostPort=9990;
    int clientId=0;//储存当前id
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
    void registerBack(QJsonObject obj);
    void loginBack(QJsonObject obj);
    void sendChatMessageBack(QJsonObject obj);
};


#endif // QQCLIENT_H
