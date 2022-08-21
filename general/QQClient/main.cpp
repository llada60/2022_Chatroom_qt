#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <qqclient.h>
#include <QObject>
#include <QList>
#include <temp.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");
    //加载QML文件
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/LoginWindow.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    //C++后台通讯，以app为父对象实例化后台通讯类，便于内存管理
    QQClient* qqClient=new QQClient(&engine,&app);

    return app.exec();
}
