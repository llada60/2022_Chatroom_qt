import QtQuick 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml 2.0
import "./components"

Window {
    id: addFriendWindow
    width: 300
    height: 100
    visible: false
    title: qsTr("加好友/群")


    property string avatarImg: "https://c-ssl.dtstatic.com/uploads/blog/202203/25/20220325232426_17909.thumb.1000_0.jpeg"
    property string userName: "balabala"
    property int userid: 12345
    property bool isPerson: true //用户：true 群聊：false
    property bool finded: false // 是否查找到相应的用户/群聊

    //发送搜索内容（id）
    signal addFriend(int idN)

    //返回搜索结果
    function addFriendBack(data)
    {
        finded = data.finded
        if(false == finded)
        {
            findFalse.open()
            return;
        }
        userName = data.pName
        avatarImg = data.headImg
        isPerson = data.isPerson
        Window.height = 180
        searchResult.visible = true

    }

    MessageDialog
    {
        id:findFalse
        standardButtons: MessageDialog.Cancel
        text: "查无该用户/群聊"
    }

    // 搜索栏

    SearchWidget
    {
        id: searchWidget
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20

    }
    Rectangle
    {
        id:searchResult
        visible: false
        width: parent.width
        height: parent.height
        anchors.top: searchWidget.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.right: parent.right
        anchors.rightMargin: 8

            Text {
                id: pInf
                text: qsTr("<font color='#767777'>联系人</font>")
                visible: isPerson
            }

            Text {
                id: gInf
                anchors.top: pInfList.bottom
                anchors.topMargin: 0
                text: qsTr("<font color='#767777'>群组</font>")
                visible: !isPerson
            }
            Rectangle
            {
                id: pInfList
                anchors.top: pInf.bottom
                width: parent.width
                height: parent.height*0.4

                //好友搜索结果表
                InfListItem
                {
                    id:resultList
                    width: parent.width
                }
            }
    }

}























