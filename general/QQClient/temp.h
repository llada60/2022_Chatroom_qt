#ifndef TEMP_H
#define TEMP_H

#include <QObject>
#include <QDebug>

//凑数测试用的类
class Temp : public QObject
{
    Q_OBJECT
public:
    Temp(QObject *parent = nullptr);

signals:

private slots:
    void loginRespond(int user,QString pwd)
    {
        qDebug()<<user<<pwd;
    }
    void registerRespond(QString user,QString pwd)
    {
        qDebug()<<user<<pwd;
    }


};

#endif // TEMP_H
