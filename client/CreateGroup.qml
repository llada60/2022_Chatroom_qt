import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml 2.0
import "./components"

Window {
    id: createGroupWindow
    width: 300
    height: 180
    visible: true

    title: qsTr("创建群聊")


    property string avatarImg: "https://c-ssl.dtstatic.com/uploads/blog/202203/25/20220325232426_17909.thumb.1000_0.jpeg"
    property string userName: "XXX"
    property int userid: 12345
    property var memberId: []



    // 搜索栏

    GroupAddWidget
    {
        id: searchWidget
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20   
        onIdpp:
        {
            userid = idN
            searchResult.visible = true
        }

    }
    Rectangle
    {
        z:1
        id:searchResult
        width: parent.width
        height: parent.height
        anchors.top: searchWidget.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.right: parent.right
        anchors.rightMargin: 8

        visible: false

        Text {
            id: pInf
            text: qsTr("<font color='#767777'>联系人</font>")
            visible: true
        }
        Rectangle
        {
            id: pInfList
            anchors.top: pInf.bottom
            width: parent.width
            height: parent.height*0.4

            //好友搜索结果表
            Rectangle
            {
                width:parent.width
                RowLayout
                {
                    Layout.fillWidth: true
                    RoundImage
                    {
                        id: avatarImgP
                        img_src: avatarImg

                        width: 40
                        height: avatarImgP.width
                        color: "black"
                    }
                    Text
                    {
                        id: searchName
                        Layout.leftMargin: 20
                        text: userName + qsTr("<font color=\"#54b4ef\">(") + userid + qsTr(")</font>")
                    }
                    Rectangle
                    {
                        z:100
                        width: 20
                        height: 20
                        Layout.leftMargin: 80
                        Image
                        {
                            id: createGroupButton
                            anchors.fill: parent
                            source: "qrc:/images/addGroup.png"
                            MouseArea
                            {
                                hoverEnabled: true
                                onHoveredChanged: cursorShape = Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton
                                onClicked:
                                {
                                    if(userid != memberId[memberId.length-1])
                                    {
                                        //发出创建群聊添加成员的信号
                                        memberId.push(userid)
                                        console.log("addFriend")
                                    }
                                }
                            }
                        }
                    }


                }
            }
        }
    }

}























