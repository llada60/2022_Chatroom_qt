#include "sqlaccountmodel.h"
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>
#include <QtDebug>

static const char *accountTableName = "USERINFO";

static void createTable()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE", "account");
    db.setDatabaseName("Info.db");
    if(db.tables().contains(accountTableName))
    {
        return;
    }
    if(db.open())
    {
        QSqlQuery query(db);
        if(!query.exec("CREATE TABLE IF NOT EXISTS USERINFO ("
                       "ID INTEGER PRIMARY KEY AUTOINCREMENT, "
                       "NAME CHAR(15) NOT NULL, "
                       "PASSWORD CHAR(15) NOT NULL,"
                       "ICON TEXT,"
                       "GENDER BOOLEAN,"
                       "BIRTH TEXT,"
                       "AREA CHAR(20),"
                       "EDUCATION CHAR(20),"
                       "SIGNATURE TEXT)"))
        {
            qDebug() << "表创建发生错误";
            qDebug() << query.lastError();
        }
    }
    db.close();
}

SqlAccountModel::SqlAccountModel(QObject *parent, QSqlDatabase db):
    QSqlTableModel(parent, db)
{
    createTable();
    setEditStrategy(QSqlTableModel::OnFieldChange);
}

SqlAccountModel::~SqlAccountModel()
{
    database().close();
}

QByteArray SqlAccountModel::addUserAccount(const QString& userName, const QString& userPassword)
{
    setTable(accountTableName);
    QJsonObject obj;
    QJsonDocument doc;
    QByteArray bArry;
    QSqlQuery query;
    int id=0;
    if(!query.exec(QString("INSERT INTO USERINFO(NAME, PASSWORD) VALUES("
                           "'%1', '%2')").arg(userName, userPassword)))
    {
        qDebug() << "插入账号信息发生错误";
        qDebug() << query.lastError();
    }
    else
    {
        qDebug() << "插入账号信息成功";
        select();
        QSqlRecord record = QSqlTableModel::record(rowCount()-1);
        id = record.value(0).toInt();
        if(!query.exec(QString("INSERT INTO FRIENDINFO(USERID, FRIENDID) VALUES("
                               "%1, %2)").arg(QString::number(id), QString::number(id))))
        {
            qDebug() << "插入好友信息发生错误";
            qDebug() << query.lastError();
        }
    }
    obj.insert("command","registerBack");
    obj.insert("id", QJsonValue(id));
    doc = QJsonDocument(obj);
    bArry = doc.toJson();
    return bArry;
}

QByteArray SqlAccountModel::checkAccount(const int& userID, const QString &userPassword)
{
    bool rel;
    QString password;
    int id;
    QJsonObject obj;
    QJsonDocument doc;
    QByteArray bArry;

    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    select();

    if(rowCount()==0)
    {
        qDebug() << "该用户不存在";
        rel = false;
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        id = record.value("ID").toInt();
        password = record.value("PASSWORD").toString();
        if(id==userID && password==userPassword)
        {
            rel = true;
        }
        else rel = false;
    }
    obj.insert("command","loginBack");
    obj.insert("result", QJsonValue(rel));
    doc = QJsonDocument(obj);
    bArry = doc.toJson();
    return bArry;
}

void SqlAccountModel::updateIcon(const int& userID, const QString &iconURL)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
        qDebug() << lastError();
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        record.setValue("ICON", iconURL);
        setRecord(0, record);
        if(!submitAll())
        {
           qDebug() << lastError();
        }
    }
}

void SqlAccountModel::updateName(const int &userID, const QString &name)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
       qDebug() << lastError();
    }
    else
    {
       QSqlRecord record = QSqlTableModel::record(0);
       record.setValue("NAME", name);
       setRecord(0, record);
       if(!submitAll())
       {
          qDebug() << lastError();
       }
    }
}

void SqlAccountModel::updateGender(const int &userID, const QString &gender)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
        qDebug() << lastError();
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        record.setValue("GENDER", gender);
        setRecord(0, record);
        if(!submitAll())
        {
           qDebug() << lastError();
        }
    }
}

void SqlAccountModel::updateBirth(const int &userID, const QString &birth)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
        qDebug() << lastError();
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        record.setValue("BIRTH", birth);
        setRecord(0, record);
        if(!submitAll())
        {
           qDebug() << lastError();
        }
    }
}

void SqlAccountModel::updateArea(const int &userID, const QString &area)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
        qDebug() << lastError();
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        record.setValue("AREA", area);
        setRecord(0, record);
        if(!submitAll())
        {
           qDebug() << lastError();
        }
    }
}

void SqlAccountModel::updateEducation(const int &userID, const QString &education)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
        qDebug() << lastError();
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        record.setValue("EDUCATION", education);
        setRecord(0, record);
        if(!submitAll())
        {
           qDebug() << lastError();
        }
    }
}

void SqlAccountModel::updateSignature(const int &userID, const QString &signature)
{
    setTable(accountTableName);
    setFilter(QString("ID = %1").arg(userID));
    if(!select())
    {
        qDebug() << lastError();
    }
    else
    {
        QSqlRecord record = QSqlTableModel::record(0);
        record.setValue("SIGNATURE", signature);
        setRecord(0, record);
        if(!submitAll())
        {
           qDebug() << lastError();
        }
    }
}





















