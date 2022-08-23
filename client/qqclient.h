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
    void registerAccount(QString user,QString password);//注册
    void login(int id,QString password);//登录
    void sendChatMessage(int targetId,QString content,int time);//发消息
    void search(int targetId);//查找群/人
    void add(int targetId);//加群/人
    void deleteRequest(int targetId);//删群/人
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
    void searchBack(QJsonObject obj);
    void addBack(QJsonObject obj);
    void deleteBack(QJsonObject obj);
};


#endif // QQCLIENT_H
