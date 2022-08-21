import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.5

/*

  */

Window {
    id: groupPage
    width: 338
    height: 506
    visible: true

    property string groupHead: "https://c-ssl.dtstatic.com/uploads/item/202007/23/20200723100019_v4nJm.thumb.1000_0.jpeg"
    property string pBackground: "https://c-ssl.dtstatic.com/uploads/item/202004/25/20200425235603_ybgrj.thumb.1000_0.jpg"
    property string groupName: "东拼西凑组"
    property int groupID: 12345
    property string groupNotic: "见证一款聊天软件的诞生w"
    property string groupSummary: "这是一个组建于2022-08-14的群组\n欢迎新成员加入lol"


    //接收发来信号判断是否是群主，若是群主拥有设置权限
    property bool isOwner: false


    /*
      接收服务端发来的群聊信息，并进行显示
      */
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

                visible: isOwner

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
                height: 350
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
                    anchors.verticalCenterOffset: 20

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
                anchors.verticalCenterOffset: 130
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
                Button
                {
                    //跳转页面到群聊天界面
                    id: sendMsg
                    anchors.top: groupNum.bottom
                    anchors.topMargin: 0
                    background:
                    {
                        opacity:1
                    }


                    anchors.horizontalCenter: parent.horizontalCenter
                    icon.source: sendMsg.pressed? "qrc:/img/message1.png":
                                         sendMsg.hovered? "qrc:/img/message1.png" :
                                                        ("qrc:/img/message.png")
                    icon.color:"transparent"
                }
            }






        //群公告
        ColumnLayout
        {
            id:notice
            anchors.top: belowInf.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: qsTr("<font color='#9f9f9f'>群公告</font>")
            }
            Rectangle
            {
                id: noticeContext
                width: 280
                height: 60
                Text
                {
                    anchors.fill: noticeContext
                    text: groupNotic
                }
            }
        }
        //分割线
        Canvas
        {

            id: canvas1
            width: parent.width
            height: parent.height
            onPaint: {
                  var ctx = getContext("2d");
                  draw(ctx);
            }
            function draw(ctx ) {
                // 画之前清空画布
                ctx.clearRect(0, 0, parent.width, parent.height);

                ctx.fillStyle ="#f2f2f2";           // 设置画笔属性
                ctx.strokeStyle = "#f2f2f2";
                ctx.lineWidth = 2

                ctx.beginPath();                  // 开始一条路径
                ctx.moveTo(40,360);         // 移动到指定位置
                ctx.lineTo(298,360);

                ctx.stroke();
             }
        }

        //群简介
        ColumnLayout
        {
            id:summary
            anchors.top: notice.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: qsTr("<font color='#9f9f9f'>群介绍</font>")
            }
            Rectangle
            {
                id: summaryDisplay
                width: 280
                height: 60
                Text
                {
                    anchors.fill: summary
                    text: groupSummary
                }
            }
        }

    }





}
