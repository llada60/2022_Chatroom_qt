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
    //获取好友列表及好友个人信息

};

#endif // SQLFRIENDSMODEL_H
