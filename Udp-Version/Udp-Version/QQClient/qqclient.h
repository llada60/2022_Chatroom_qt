#ifndef QQCLIENT_H
#define QQCLIENT_H

#include <QMainWindow>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
#include <QHostAddress>
#include <QUdpSocket>

QT_BEGIN_NAMESPACE
namespace Ui { class QQClient; }
QT_END_NAMESPACE

class QQClient : public QMainWindow
{
    Q_OBJECT

public:
    QQClient(QWidget *parent = nullptr);
    ~QQClient();

    //关于按钮的槽函数我写的只是凑合用的
    //你按着我的逻辑自己写即可
private slots:
    void on_registerButton_clicked();

    void on_loginButton_clicked();

private:
    Ui::QQClient *ui;
    //固定服务器ip和端口
    QUdpSocket* udpSocket;
    QHostAddress hostIp=QHostAddress("127.0.0.1");
    quint16 hostPort=9990;
    //基本通信方法
    void on_udpSocket_readyRead();
    void sendMessage(QString content,QString ip,QString port); //重载两个模式的发
    void sendMessage(QString content,QHostAddress ip,quint16 port);
    //注册登录
    void registerAcount(QString user,QString password);
    void login(int id,QString password);

};
#endif // QQCLIENT_H
