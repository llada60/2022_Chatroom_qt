import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0


Window {
    property int usrID: 0
    property string usrPSW: ""
    property string usrHead: "qrc:/image/mushroom.jpg" //登陆时若本地就有头像自动获取；否则使用自带默认头像（类qq的企鹅）

    id: loginWindows
    width: 248
    height: 400
    visible: true //窗口是否可见
    title: qsTr("登陆") //窗口标题

    RegisterWindow{id: registerWindows}

    //qml全局函数，一般从C++那头调就调这里的函数

    function myFunc(s)
    {
        console.log(s)
        return "你好"
    }


    // 头像
    Rectangle {
        id: img
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -125
        width: 100
        height: 100
        radius: width/2
        color: "black"

        Image {
            id: _image
            smooth: true
            visible: false
            anchors.fill: parent
            source: usrHead
            antialiasing: true
        }
        Rectangle {
            id: _mask
            anchors.fill: parent
            radius: width/2
            visible: false
            antialiasing: true
            smooth: true
        }
        OpacityMask {
            id:mask_image
            anchors.fill: _image
            source: _image
            maskSource: _mask
            visible: true
            antialiasing: true
        }
    }

    // 账号 密码
    TextField
    {
        id: inputID
        width:200
        height: 50
        y:150
        x:20
        leftPadding: 4
        placeholderText: qsTr("<center>账号</center>")
    }
    TextField
    {
        id: inputPSW
        width:200
        height: 50
        y:200
        x:20
        leftPadding: 4
        echoMode: TextInput.Password
        placeholderText: qsTr("<center>密码</center>")
    }

    // 确认
    Button
    {
        //signal loginSignal(int usrID,string usrPSW)
        id: sendMsg
        objectName: "loginButton"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 90
        width: 40
        height: 40
        icon.source: "qrc:/image/rightArrow.png"
        signal loginSignal(int usrID,string usrPSW)

        onClicked:
        {
            usrID = Number(inputID.text)
            usrPSW = inputPSW.text
            //发送消息
            console.log(usrPSW)
            console.log("登录")
            loginSignal(usrID,usrPSW)
        }
    }


    ToolButton
    {
        width:50
        height: 30
        objectName: "registerButton"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 180
        highlighted: true
        text: qsTr("注册")
        onClicked:
        {
            registerWindows.show()
            loginWindows.hide()
        }
    }


}
