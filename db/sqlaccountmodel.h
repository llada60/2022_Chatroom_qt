#ifndef SQLACCOUNTMODEL_H
#define SQLACCOUNTMODEL_H

#include <QObject>
#include <QtSql/QSqlTableModel>
#include <QJsonArray>
#include <QByteArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>

class SqlAccountModel : public QSqlTableModel
{
    Q_OBJECT
public:
    SqlAccountModel(QObject *parent, QSqlDatabase db);
    ~SqlAccountModel();

    //添加用户账号信息，如果添加成功返回id, 添加失败返回0, 包装在json下的id字段
    QByteArray addUserAccount(const QString& userName, const QString& userPassword);
    //检查用户账号是否正确，如果正确返回true, 错误返回false, 包装在json下的result字段
    QByteArray checkAccount(const int& userID, const QString& userPassword);
    //添加或更新用户头像的url
    void updateIcon(const int& userID, const QString& iconURL);
    //更新用户名
    void updateName(const int& userID, const QString& name);
    //添加或更新用户性别
    void updateGender(const int& userID, const QString& gender);
    //添加或更新用户出生日期
    void updateBirth(const int& userID, const QString& birth);
    //添加或更新用户地区
    void updateArea(const int& userID, const QString& area);
    //添加或更新用户教育经历
    void updateEducation(const int& userID, const QString& education);
    //添加或更新用户个性签名
    void updateSignature(const int& userID, const QString& signature);
};

#endif // SQLACCOUNTMODEL_H
