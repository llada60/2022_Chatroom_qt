import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0


Window {
    property int usrID: 0
    property string usrPSW: ""
    property string usrHead: "qrc:/image/mushroom.jpg"

    function sendMsg()
    {

    }


    id: loginWindows
    width: 248
    height: 400
    visible: true //窗口是否可见
    title: qsTr("登陆") //窗口标题

    RegisterWindow{id: registerWindows}

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
        width:200
        height: 50
        y:150
        x:20
        leftPadding: 4
        placeholderText: qsTr("<center>账号</center>")
    }
    TextField
    {
        width:200
        height: 50
        y:200
        x:20
        leftPadding: 4
        placeholderText: qsTr("<center>密码</center>")
    }

    // 确认
    Button
    {
        id: sendMsg
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 90
        width: 40
        height: 40
        icon.source: "qrc:/image/rightArrow.png"

        MouseArea
        {
            acceptedButtons: Qt.LeftButton
            onClicked:
            {
                //发送消息
                sendMsg()
            }
        }
    }


    ToolButton
    {
        width:50
        height: 30
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
