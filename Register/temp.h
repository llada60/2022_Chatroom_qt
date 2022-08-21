#ifndef TEMP_H
#define TEMP_H
#include <QObject>
#include <QDebug>

class Temp: public QObject
{
    Q_OBJECT
public:
    void response1()
    {
        qDebug()<<1;
    }
private slots:
    //槽函数
    void response2(int id,QString pwd)
    {
        qDebug()<<id<<pwd;
    }

};

#endif // TEMP_H
