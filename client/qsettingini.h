#ifndef QREADINI_H
#define QREADINI_H

#include <QSettings>
#include <QString>
#include <QVariant>


#define DATACONFIG  QSettingIni::getInstance()->getIniConfig()


class QSettingIni
{
public:
    static QSettingIni*getInstance(QString fileName);
    void write(QString key, QVariant value);

    template<class T>
    T read(QString key, T default){

    };

private:
    QSettingIni();
    static QSettingIni* instance;
};


#endif // QREADINI_H
