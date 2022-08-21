#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <temp.h>
#include <QObject>
#include <QList>

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
    //C++后台通讯
    Temp temp;
    QObject* root=engine.rootObjects()[0];//Qt对象树结构,root是qml全局的根节点
    QObject* loginButton=root->findChild<QObject*>("loginButton");//找到按钮节点
    //qml到C++(信号型通讯)
    QObject::connect(loginButton,SIGNAL(loginSignal(int,QString)),&temp,SLOT(response2(int,QString)));
    //c++调qml函数（直接调）
    QVariant res;
    QVariant input="C++到qml";
    QMetaObject::invokeMethod(root,"myFunc",
                              Q_RETURN_ARG(QVariant,res),
                              Q_ARG(QVariant,input));

    return app.exec();
}
