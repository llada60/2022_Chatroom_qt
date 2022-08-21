#include "sqlaccountwidget.h"
#include "ui_sqlaccountwidget.h"
#include <QString>
#include <QtDebug>
#include <QMessageBox>
#include <QJsonParseError>

sqlAccountWidget::sqlAccountWidget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::sqlAccountWidget)
{
    ui->setupUi(this);
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("Info.db");
    db.open();
    atModel = new SqlAccountModel(this, db);
    fdModel = new SqlFriendModel(this, db);
}

sqlAccountWidget::~sqlAccountWidget()
{
    delete ui;
    delete atModel;
}

void sqlAccountWidget::on_pushButtonSubmit_clicked()
{
    QString userName = ui->lineEditName->text();
    QString userPassword = ui->lineEditPassword->text();
    QJsonObject obj;
    QJsonDocument doc;
    QJsonParseError error;
    int id;
    doc = QJsonDocument::fromJson(atModel->addUserAccount(userName, userPassword), &error);
    obj = doc.object();
    id = obj.value("id").toInt();
    if(userPassword!=ui->lineEditConfirmPass->text())
    {
        QMessageBox::information(this, "注册反馈","密码不一致");
    }
    else if(id != 0)
    {
        ui->lineEditID->setText(QString::number(id));
    }
    else
    {
        QMessageBox::information(this, "注册反馈", "注册错误");
        ui->lineEditID->clear();
    }
    ui->lineEditName->clear();
    ui->lineEditPassword->clear();
    ui->lineEditConfirmPass->clear();
}

void sqlAccountWidget::on_AuthBotton_clicked()
{
    bool rel;
    qlonglong id = ui->AuthID->text().toInt();
    QString password = ui->AuthPass->text();
    QJsonParseError error;
    rel = QJsonDocument::fromJson(atModel->checkAccount(id, password), &error).object().value("result").toBool();
    if(rel)
    {
        QMessageBox::information(this, "返回结果", "登录成功");
    }
    else
    {
        QMessageBox::information(this, "返回结果", "用户名或密码错误");
    }
    ui->AuthID->clear();
    ui->AuthPass->clear();
}

void sqlAccountWidget::on_iconSubmit_clicked()
{
    int id = ui->iconID->text().toInt();
    QString icon = ui->iconURL->text();
    QString gender = ui->gender->text();
    QString birth = ui->birth->text();
    QString area = ui->area->text();
    QString edu = ui->edu->text();
    QString sig = ui->sig->text();
    atModel->updateIcon(id, icon);
    atModel->updateGender(id, gender);
    atModel->updateArea(id, area);
    atModel->updateBirth(id, birth);
    atModel->updateEducation(id, edu);
    atModel->updateSignature(id, sig);
    ui->iconID->clear();
    ui->iconURL->clear();
}

void sqlAccountWidget::on_addFd_clicked()
{
    int id1 = ui->myID->text().toInt();
    int id2 = ui->othersID->text().toInt();
    fdModel->addFriend(id1, id2);
}
