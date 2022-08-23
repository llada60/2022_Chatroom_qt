#ifndef ONLINELIST_H
#define ONLINELIST_H
#include <QString>
#include <QTcpSocket>
#include <QHostAddress>


class User //在线成员的节点
{
public:
    User(QHostAddress ip,quint16 port,int id) //把名字和IP PORT绑定。
    {
        this->id=id;
        this->ip=ip;
        this->port=port;
    }
    ~User();

    int id;
    QHostAddress ip;
    quint16 port;
};





#endif // ONLINELIST_H
