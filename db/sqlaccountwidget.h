#ifndef SQLACCOUNTWIDGET_H
#define SQLACCOUNTWIDGET_H

#include <QWidget>
#include "sqlaccountmodel.h"
#include "sqlfriendmodel.h"

QT_BEGIN_NAMESPACE
namespace Ui { class sqlAccountWidget; }
QT_END_NAMESPACE

class sqlAccountWidget : public QWidget
{
    Q_OBJECT

public:
    sqlAccountWidget(QWidget *parent = nullptr);
    ~sqlAccountWidget();

private slots:
    void on_pushButtonSubmit_clicked();

    void on_AuthBotton_clicked();

    void on_iconSubmit_clicked();

    void on_addFd_clicked();

private:
    Ui::sqlAccountWidget *ui;
    SqlAccountModel *atModel;
    SqlFriendModel *fdModel;
};
#endif // SQLACCOUNTWIDGET_H
