import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
 import QtQuick.Dialogs 1.3

Window {
    id: registerWindows
    width: 248
    height: 400
    visible: false //窗口是否可见
    title: qsTr("注册") //窗口标题

    property string usrName: ""
    property string usrPassword: ""

    signal sendRegisterInf(string usrName,string usrPassword)


    MessageDialog
    {
            id:wrongPSW
            title: "提示"
            icon: StandardIcon.Warning
            text: "输入密码不匹配"
            standardButtons: StandardButton.Cancel
    }
    MessageDialog
    {
            id: noUsrName
            title: "提示"
            icon: StandardIcon.Warning
            text: "请输入用户名"
            standardButtons: StandardButton.Cancel
    }


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
            text: qsTr("注册")
            flat: true

            onClicked:
            {
                usrName = usr.text
                usrPassword = password.text

                if(passwordAgain.text != password.text)
                {
                    console.log("psw not match.")
                    wrongPSW.open()

                }
                else if(usrName == "")
                {
                    console.log("no usr name")
                    noUsrName.open()
                }
                else
                {
                    console.log("inf config ok")
                    sendRegisterInf(usrName,usrPassword)
                }

            }

            anchors.verticalCenterOffset: 125
        }



    }


}
