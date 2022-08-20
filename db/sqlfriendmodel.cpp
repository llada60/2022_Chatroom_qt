#include "sqlfriendmodel.h"
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>
#include <QtDebug>
#include <QtMath>

static const char* friendTableName = "FRIENDINFO";
static void createTable()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE", "friend");
    db.setDatabaseName("Info.db");
    if(db.tables().contains(friendTableName))
    {
        return;
    }
    if(db.open())
    {
        QSqlQuery query(db);
        if(!query.exec(QString("CREATE TABLE IF NOT EXISTS %1("
                               "USERID INTEGER NOT NULL, "
                               "FRIENDID INTEGER NOT NULL CHECK (USERID<=FRIENDID),"
                               "PRIMARY KEY (USERID, FRIENDID),"
                               "FOREIGN KEY (USERID) REFERENCES USERINFO(ID) ON DELETE CASCADE,"
                               "FOREIGN KEY (FRIENDID) REFERENCES USERINFO(ID) ON DELETE CASCADE)"
                               ).arg(friendTableName)))
        {
            qDebug() << "表创建发生错误";
            qDebug() << query.lastError();
        }
    }
    db.close();
}

SqlFriendModel::SqlFriendModel(QObject *parent, QSqlDatabase db):
    QSqlTableModel(parent, db)
{
    createTable();
}

SqlFriendModel::~SqlFriendModel()
{
    database().close();
}

void SqlFriendModel::addFriend(const int &aID, const int &bID)
{
    setTable(friendTableName);
    QSqlQuery query;
    int id1, id2;
    id1 = qMin(aID, bID);
    id2 = qMax(aID, bID);
    if(!query.exec(QString("INSERT INTO FRIENDINFO(USERID, FRIENDID) VALUES("
                           "%1, %2)").arg(QString::number(id1), QString::number(id2))))
    {
        qDebug() << "添加好友发生错误";
        qDebug() << query.lastError();
    }
    else
    {
        qDebug() << "添加好友成功";
    }
}
