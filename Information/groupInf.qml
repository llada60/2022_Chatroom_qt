import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.5


Window {
    width: 338
    height: 506
    visible: true

    property string groupHead: "https://c-ssl.dtstatic.com/uploads/blog/202203/19/20220319111710_f487b.thumb.1000_0.jpg"
    property string pBackground: "https://c-ssl.dtstatic.com/uploads/item/202004/25/20200425235603_ybgrj.thumb.1000_0.jpg"
    property string groupName: "东拼西凑组"
    property int groupID: 12345

    ColumnLayout
    {
        z:1
        anchors.fill: parent

        //设置按钮：设置成stackView多界面切换
        ToolButton
        {
            z:100
            id: reset
            width: 15
            height: 15
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top:parent.top
            anchors.topMargin: 10

            font.pixelSize :15

            text: reset.pressed? qsTr("<font color='#57c1f2'>设置</font>") :
                                 reset.hovered? qsTr("<font color='#57c1f2'>设置</font>") :
                                                ("<font color='#e1e7f2'>设置</font>")
        }

        // 头像
        Rectangle
        {
            id: img
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -200
            width: 338
            height: 180
            radius: width/2
            Image
            {
                //背景图
                anchors.fill: img
                source: pBackground
            }
            Rectangle
            {
                id: imgHead
                width: 100
                height: 100
                radius: imgHead.width/2

                anchors.centerIn: img
                anchors.verticalCenterOffset: 80

                Image {
                    id: _image
                    smooth: true
                    anchors.fill: parent
                    visible: false
                    source: groupHead
                    antialiasing: true
                }
                Rectangle {
                    id: _mask
                    anchors.fill: parent
                    radius: imgHead.width/2
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
        }
        //头像下部分信息：群名称+群号
        ColumnLayout
        {
            id: belowInf
            anchors.centerIn: img
            anchors.verticalCenterOffset: 170
            Text
            {
                id: name
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.family: "SimHei"
                font.bold: true
                text: groupName
            }
            Text
            {
                id: groupNum
                anchors.top: groupName.bottom
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
                font.family: "LiSu"
                color: "#767777"
                text: qsTr("群号：") + groupID
            }
        }

        //detail Information
        ColumnLayout
        {
            id:detail
            Text {
                id: notice
                text: qsTr("群公告")
            }
        }


    }





}
