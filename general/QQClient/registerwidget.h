#ifndef REGISTERWIDGET_H
#define REGISTERWIDGET_H

#include <QWidget>

QT_BEGIN_NAMESPACE
namespace Ui { class RegisterWidget; }
QT_END_NAMESPACE

class RegisterWidget : public QWidget
{
    Q_OBJECT

public:
    RegisterWidget(QWidget *parent = nullptr);
    ~RegisterWidget();

private:
    Ui::RegisterWidget *ui;
};
#endif // REGISTERWIDGET_H
