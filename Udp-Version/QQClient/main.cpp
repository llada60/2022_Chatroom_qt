#include "qqclient.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QQClient w;
    w.show();
    return a.exec();
}
