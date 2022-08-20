/********************************************************************************
** Form generated from reading UI file 'qqserver.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_QQSERVER_H
#define UI_QQSERVER_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_QQServer
{
public:
    QWidget *centralwidget;
    QTextBrowser *textBrowser;
    QTextEdit *textEdit;
    QMenuBar *menubar;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *QQServer)
    {
        if (QQServer->objectName().isEmpty())
            QQServer->setObjectName(QString::fromUtf8("QQServer"));
        QQServer->resize(800, 600);
        centralwidget = new QWidget(QQServer);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        textBrowser = new QTextBrowser(centralwidget);
        textBrowser->setObjectName(QString::fromUtf8("textBrowser"));
        textBrowser->setGeometry(QRect(130, 40, 256, 192));
        textEdit = new QTextEdit(centralwidget);
        textEdit->setObjectName(QString::fromUtf8("textEdit"));
        textEdit->setGeometry(QRect(160, 300, 104, 70));
        QQServer->setCentralWidget(centralwidget);
        menubar = new QMenuBar(QQServer);
        menubar->setObjectName(QString::fromUtf8("menubar"));
        menubar->setGeometry(QRect(0, 0, 800, 21));
        QQServer->setMenuBar(menubar);
        statusbar = new QStatusBar(QQServer);
        statusbar->setObjectName(QString::fromUtf8("statusbar"));
        QQServer->setStatusBar(statusbar);

        retranslateUi(QQServer);

        QMetaObject::connectSlotsByName(QQServer);
    } // setupUi

    void retranslateUi(QMainWindow *QQServer)
    {
        QQServer->setWindowTitle(QApplication::translate("QQServer", "QQServer", nullptr));
    } // retranslateUi

};

namespace Ui {
    class QQServer: public Ui_QQServer {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_QQSERVER_H
