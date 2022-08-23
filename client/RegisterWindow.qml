import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import "./js/config_utils.js" as ConfigUtils

Window {
    id: registerWindows
    width: 248
    height: 400
    visible: true //窗口是否可见
    title: qsTr("注册") //窗口标题

    property string usrName: ""
    property string usrPassword: ""
    property int usrID: 0

    MainWindow{id:mainWindow}

    MessageDialog
    {//注册失败提示
            id: wrongRegister
            title: "提示"
            icon: StandardIcon.Warning
            text: "注册失败"
            standardButtons: StandardButton.Cancel
    }

    Dialog
    {//返回注册结果
        id: idDialog
        width: 300;
        height: 300
        title: qsTr("注册信息确认")
        standardButtons: StandardButton.Ok

        Text {
            id: text
            text: qsTr("您的账号：")  +  usrID +  qsTr("\n您的用户名：") + usrName
            anchors.centerIn: parent
        }


        onAccepted:
        {
            console.log("Having checked the new usr inf")
            mainWindow.show()
            registerWindows.hide()
        }
    }


    //发送信号
    signal sendRegisterInf(string usrName,string usrPassword)

    //接收服务器返回的账号，打印后进入主界面
    function receiveID(pID)
    {
        if (0 == pID)
        {
            wrongRegister.open()
        }
        else
        {
            usrID = pID
            idDialog.open()
        }


    }


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
    MessageDialog
    {
            id: noPassword
            title: "提示"
            icon: StandardIcon.Warning
            text: "请输入密码"
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
            Layout.topMargin: 15
            width:200
            height: 50
            leftPadding: 4
            echoMode: TextInput.Password
            placeholderText: qsTr("<center>密码</center>")
        }
        TextField
        {
            id: passwordAgain
            Layout.topMargin: 15
            width:200
            height: 50
            leftPadding: 4
            echoMode: TextInput.Password
            placeholderText: qsTr("<center>确认密码</center>")
        }
        RoundButton
        {
            //注册，自动分配账号，并弹出message写出对应的账号和用户名，跳过登陆步骤进入主界面
            id: register
            Layout.alignment: Qt.AlignHCenter
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
                else if(password.text == "")
                {
                    console.log("no password")
                    noPassword.open()
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
