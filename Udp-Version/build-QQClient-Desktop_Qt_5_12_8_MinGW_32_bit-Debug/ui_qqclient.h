/********************************************************************************
** Form generated from reading UI file 'qqclient.ui'
**
** Created by: Qt User Interface Compiler version 5.12.8
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_QQCLIENT_H
#define UI_QQCLIENT_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_QQClient
{
public:
    QWidget *centralwidget;
    QWidget *layoutWidget;
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout_3;
    QLabel *labelIP;
    QLineEdit *lineIP;
    QHBoxLayout *horizontalLayout_2;
    QLabel *labelPort;
    QLineEdit *linePort;
    QTextBrowser *textBrowser;
    QTextEdit *textEdit;
    QHBoxLayout *horizontalLayout_4;
    QPushButton *sentButton_2;
    QSpacerItem *horizontalSpacer_2;
    QPushButton *closeButton_2;
    QHBoxLayout *horizontalLayout;
    QPushButton *registerButton;
    QSpacerItem *horizontalSpacer;
    QPushButton *loginButton;
    QMenuBar *menubar;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *QQClient)
    {
        if (QQClient->objectName().isEmpty())
            QQClient->setObjectName(QString::fromUtf8("QQClient"));
        QQClient->resize(378, 412);
        centralwidget = new QWidget(QQClient);
        centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
        layoutWidget = new QWidget(centralwidget);
        layoutWidget->setObjectName(QString::fromUtf8("layoutWidget"));
        layoutWidget->setGeometry(QRect(10, 10, 356, 282));
        verticalLayout = new QVBoxLayout(layoutWidget);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        verticalLayout->setContentsMargins(0, 0, 0, 0);
        horizontalLayout_3 = new QHBoxLayout();
        horizontalLayout_3->setObjectName(QString::fromUtf8("horizontalLayout_3"));
        labelIP = new QLabel(layoutWidget);
        labelIP->setObjectName(QString::fromUtf8("labelIP"));

        horizontalLayout_3->addWidget(labelIP);

        lineIP = new QLineEdit(layoutWidget);
        lineIP->setObjectName(QString::fromUtf8("lineIP"));

        horizontalLayout_3->addWidget(lineIP);


        verticalLayout->addLayout(horizontalLayout_3);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        labelPort = new QLabel(layoutWidget);
        labelPort->setObjectName(QString::fromUtf8("labelPort"));

        horizontalLayout_2->addWidget(labelPort);

        linePort = new QLineEdit(layoutWidget);
        linePort->setObjectName(QString::fromUtf8("linePort"));

        horizontalLayout_2->addWidget(linePort);


        verticalLayout->addLayout(horizontalLayout_2);

        textBrowser = new QTextBrowser(layoutWidget);
        textBrowser->setObjectName(QString::fromUtf8("textBrowser"));

        verticalLayout->addWidget(textBrowser);

        textEdit = new QTextEdit(layoutWidget);
        textEdit->setObjectName(QString::fromUtf8("textEdit"));

        verticalLayout->addWidget(textEdit);

        horizontalLayout_4 = new QHBoxLayout();
        horizontalLayout_4->setObjectName(QString::fromUtf8("horizontalLayout_4"));
        sentButton_2 = new QPushButton(layoutWidget);
        sentButton_2->setObjectName(QString::fromUtf8("sentButton_2"));

        horizontalLayout_4->addWidget(sentButton_2);

        horizontalSpacer_2 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout_4->addItem(horizontalSpacer_2);

        closeButton_2 = new QPushButton(layoutWidget);
        closeButton_2->setObjectName(QString::fromUtf8("closeButton_2"));

        horizontalLayout_4->addWidget(closeButton_2);


        verticalLayout->addLayout(horizontalLayout_4);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        registerButton = new QPushButton(layoutWidget);
        registerButton->setObjectName(QString::fromUtf8("registerButton"));

        horizontalLayout->addWidget(registerButton);

        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);

        loginButton = new QPushButton(layoutWidget);
        loginButton->setObjectName(QString::fromUtf8("loginButton"));

        horizontalLayout->addWidget(loginButton);


        verticalLayout->addLayout(horizontalLayout);

        QQClient->setCentralWidget(centralwidget);
        menubar = new QMenuBar(QQClient);
        menubar->setObjectName(QString::fromUtf8("menubar"));
        menubar->setGeometry(QRect(0, 0, 378, 21));
        QQClient->setMenuBar(menubar);
        statusbar = new QStatusBar(QQClient);
        statusbar->setObjectName(QString::fromUtf8("statusbar"));
        QQClient->setStatusBar(statusbar);

        retranslateUi(QQClient);

        QMetaObject::connectSlotsByName(QQClient);
    } // setupUi

    void retranslateUi(QMainWindow *QQClient)
    {
        QQClient->setWindowTitle(QApplication::translate("QQClient", "QQClient", nullptr));
        labelIP->setText(QApplication::translate("QQClient", "\345\257\271\346\226\271IP  \357\274\232", nullptr));
        labelPort->setText(QApplication::translate("QQClient", "\345\257\271\346\226\271\347\253\257\345\217\243\357\274\232", nullptr));
        sentButton_2->setText(QApplication::translate("QQClient", "\345\217\221\351\200\201", nullptr));
        closeButton_2->setText(QApplication::translate("QQClient", "\345\205\263\351\227\255", nullptr));
        registerButton->setText(QApplication::translate("QQClient", "\346\263\250\345\206\214", nullptr));
        loginButton->setText(QApplication::translate("QQClient", "\347\231\273\345\275\225", nullptr));
    } // retranslateUi

};

namespace Ui {
    class QQClient: public Ui_QQClient {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_QQCLIENT_H
