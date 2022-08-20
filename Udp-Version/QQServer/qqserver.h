#ifndef QQSERVER_H
#define QQSERVER_H

#include <QMainWindow>
#include <QUdpSocket>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument> //默认toJson是utf-8
#include <QDebug>
#include "sqlaccountmodel.h"
#include "sqlfriendmodel.h"

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
    void on_udpSocket_readyRead();

private:
    Ui::QQServer *ui;
    QUdpSocket* udpSocket=NULL;
    SqlAccountModel *atModel;
    SqlFriendModel *fdModel;


    void parseCommand(QString jsonStr,QHostAddress ip,quint16 port);
    void sendMessage(QString content,QString ip,QString port); //重载两个模式的发
    void sendMessage(QString content,QHostAddress ip,quint16 port);
    void sendMessage(QByteArray content,QHostAddress ip,quint16 port);
    void sendMessage(QByteArray content,QString ip,QString port);

};
#endif // QQSERVER_H
