#include "sqlaccountwidget.h"

#include <QApplication>
#include <QSqlRecord>
#include <QtDebug>
#include <QJsonArray>
#include <QByteArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    sqlAccountWidget w;
    w.show();
    return a.exec();
}
