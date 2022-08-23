#ifndef QQSERVER_H
#define QQSERVER_H

#include <QMainWindow>
#include <QUdpSocket>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument> //默认toJson是utf-8
#include <QDebug>
#include <iostream>
#include "sqlaccountmodel.h"
#include "sqlfriendmodel.h"
#include "sqlgroupmodel.h"
#include "onlinelist.h"
#include <QList>

QT_BEGIN_NAMESPACE
namespace Ui { class QQServer; }
QT_END_NAMESPACE

class QQServer : public QMainWindow
{
    Q_OBJECT

public:
    QQServer(QWidget *parent = nullptr);
    ~QQServer();


private slots:
    //通用收信息函数
    void on_udpSocket_readyRead();

private:
    Ui::QQServer *ui;
    //Socket
    QUdpSocket* udpSocket=NULL;
    //在线用户和群链表
    QList<User*> onlineUser;
    //数据库操作
    SqlAccountModel *atModel;
    SqlFriendModel *fdModel;
    SqlGroupModel * gpModel;
    //数据包通信解析
    void parseCommand(QString jsonStr,QHostAddress ip,quint16 port);
    //不同参数类型的的发送信息
    void sendMessage(QString content,QString ip,QString port);
    void sendMessage(QString content,QHostAddress ip,quint16 port);
    void sendMessage(QByteArray content,QHostAddress ip,quint16 port);
    void sendMessage(QByteArray content,QString ip,QString port);
    //对客户端请求响应
    void registerRespond(QJsonObject obj,QHostAddress ip,quint16 port);//注册
    void loginRespond(QJsonObject obj,QHostAddress ip,quint16 port);//登录
    void sendChatMessageRespond(QJsonObject obj,QHostAddress ip,quint16 port);//发消息（单发+群发）
    void searchRespond(QJsonObject obj,QHostAddress ip,quint16 port);//查找（好友或群）
    void addRespond(QJsonObject obj,QHostAddress ip,quint16 port);//添加（好友或群）
    void deleteRespond(QJsonObject obj,QHostAddress ip,quint16 port);//删除（好友或群）
    void friendRespond(QJsonObject obj,QHostAddress ip,quint16 port);//好友列表
    void groupRespond(QJsonObject obj,QHostAddress ip,quint16 port);//群列表
    void messageRespond(QJsonObject obj,QHostAddress ip,quint16 port);//历史消息

};
#endif // QQSERVER_H
