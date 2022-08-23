#ifndef SQLFRIENDMODEL_H
#define SQLFRIENDMODEL_H

#include <QObject>
#include <QtSql/QSqlTableModel>
#include <QJsonArray>
#include <QByteArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>

class SqlFriendModel : public QSqlTableModel
{
    Q_OBJECT
public:
    SqlFriendModel(QObject *parent, QSqlDatabase db);
    ~SqlFriendModel();
    //添加好友
    void addFriend(const int& aID, const int& bID);
    //删除好友
    void delFriend(const int& aID, const int& bID);
    //获取好友列表
    QByteArray friendList(const int& ID);
    //发送聊天信息
    void sendMessage(const int& sendID, const int& receiveID, const int& type,const int& datetime, const QString& message);
};

#endif // SQLFRIENDSMODEL_H
