import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3

Window {
    id: registerWindows
    width: 248
    height: 400
    visible: false //窗口是否可见
    title: qsTr("注册") //窗口标题

    ColumnLayout
    {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -20
        TextField
        {
            id: usr
            width:200
            height: 50
            leftPadding: 4
            placeholderText: qsTr("<center>用户名</center>")
        }
        TextField
        {
            id: password
            anchors.top: usr.bottom
            anchors.topMargin: 15
            width:200
            height: 50
            leftPadding: 4
            placeholderText: qsTr("<center>密码</center>")
        }
        TextField
        {
            id: passwordAgain
            anchors.top: password.bottom
            anchors.topMargin: 15
            width:200
            height: 50
            leftPadding: 4
            placeholderText: qsTr("<center>确认密码</center>")
        }
        RoundButton
        {
            //注册，自动分配账号，并弹出message写出对应的账号和用户名，跳过登陆步骤进入主界面
            id: register
            anchors.centerIn: parent
            text: qsTr("Login")
            flat: true

            anchors.verticalCenterOffset: 125
        }



    }


}
