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
    visible: flase

    property string groupHead: "https://c-ssl.dtstatic.com/uploads/item/202007/23/20200723100019_v4nJm.thumb.1000_0.jpeg"
    property string pBackground: "https://c-ssl.dtstatic.com/uploads/item/202004/25/20200425235603_ybgrj.thumb.1000_0.jpg"
    property string groupName: "东拼西凑组"
    property int groupID: 12345
    property string groupNotic: "见证一款聊天软件的诞生w"
    property string groupSummary: "这是一个组建于2022-08-14的群组\n欢迎新成员加入lol"
    property bool setFlag: true // true:显示模式 false：设置模式

    //接收发来信号判断是否是群主，若是群主拥有设置权限
    property bool isOwner: true

    // 1）接受数据库传来的信息并display
    function receiveGroupInf(data)
    {
        groupHead = data.groupHead
        groupName = data.groupName
        groupID = data.groupID
        groupNotic = data.groupNotic //群公告
        groupSummary = data.groupSummary //群简介
        isOwner = data.isOwner
    }
    function receiveIsOwner(v)
    {
        /*
          v==1:群主（拥有设置修改权限）
          v==0:成员
          */
        if (1 == v)
        {
            isOwner = true
        }
        else
        {
            isOwner = false
        }
    }

    // 2）若为群主对信息进行修改，向服务器推送修改后的信息
    signal sendGroupInf(string groupName,string groupNotic,string groupSummary)


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

                text: setFlag?(reset.pressed? qsTr("<font color='#57c1f2'>设置</font>") :
                                     reset.hovered? qsTr("<font color='#57c1f2'>设置</font>") :
                                                    ("<font color='#e1e7f2'>设置</font>")):
                               (reset.pressed? qsTr("<font color='#57c1f2'>完成</font>") :
                                                                    reset.hovered? qsTr("<font color='#57c1f2'>完成</font>") :
                                                                                   ("<font color='#e1e7f2'>完成</font>"))

                onClicked:
                {
                    if(1 == setFlag)
                    {//readonly -> write
                        name.visible = false
                        nameC.visible = true
                        sendMsg.visible = false
                        summaryDisplay.visible = false
                        summaryC.visible = true
                        noticeContext.visible = false
                        noticeC.visible = true
                    }
                    else
                    {//write -> readonly
                        name.visible = true
                        nameC.visible = false
                        groupName = nameC.text

                        sendMsg.visible = true

                        summaryDisplay.visible = true
                        summaryC.visible = false
                        groupSummary = summaryC.text

                        noticeContext.visible = true
                        noticeC.visible = false
                        groupNotic = noticeC.text

                        console.log("群组信息修改已完成")

                        sendGroupInf(groupName,groupNotic,groupSummary)
                    }

                    setFlag = !setFlag
                }
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
                TextInput
                {
                    id: nameC
                    visible: false
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
            anchors.topMargin: setFlag? 20:40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: qsTr("<font color='#9f9f9f'>群公告</font>")
            }
            Rectangle
            {
                width: 280
                height: 60
                Text
                {
                    id: noticeContext
                    anchors.fill: noticeContext
                    text: groupNotic
                }
                TextArea
                {
                    id: noticeC
                    visible: false
                    width : parent.width
                    anchors.fill:notice
                    text: groupNotic
                    font: font.pixelSize = 13
                    background: Rectangle
                    {
                        border.color : "white"
                    }
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
            anchors.topMargin: setFlag? 30:40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: qsTr("<font color='#9f9f9f'>群介绍</font>")
            }
            Rectangle
            {
                width: 280
                height: 100
                Text
                {
                    id: summaryDisplay
                    anchors.fill: summary
                    text: groupSummary
                }
                TextArea
                {
                    id:summaryC
                    visible: false
                    width: parent.width
                    anchors.fill:summary
                    text: groupSummary
                    font: font.pixelSize = 13
                    background: Rectangle
                    {
                        border.color : "white"
                    }
                }
            }
        }

    }





}
