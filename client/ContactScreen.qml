import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import "./components"

Rectangle {
    id: rectangle


    radius: 4

    // 信号，点击和某人/群聊天触发，参数为对应项的data
    signal messageWithConact(int id, string name, string avatar)
    signal messageWithGroup(int id, string name, string avatar)

    // 获取到联系人后调这个函数，messages为json数组。每一项的数据data参考如下
    /**
      userId: 1
      userName: "张三"
      avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
    */
    function setContacts(contacts){
        contactListModel.clear()
        for(each of contacts){
            contactListModel.append(each)
        }
    }

    // 添加一条好友信息
    function appendContact(data){
        contactListModel.append(data)
    }

    function setGroups(groups){
        groupListModel.clear()
        for(each of groups){
            groupListModel.append(each)
        }
    }

    // 添加一条群组信息
    function appendGroup(data){
        groupListModel.append(data)
    }


    AddFriendWindow{ id : addFriendWindow; visible: false;}

    ListModel {
        id: contactListModel
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
        }
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
        }
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
        }
    }

    ListModel {
        id: groupListModel
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
        }
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
        }
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
        }
    }

    Component {
        id: contactListItem
        Rectangle
        {
            width: 400
            height: 64
            RowLayout
            {
                Layout.fillWidth: true

                RoundImage
                {
                    img_src: avatar
                    width: 40
                    height: width
                    color: "black"
                }
                Text
                {
                    Layout.leftMargin: 20
                    text: userName + qsTr("<font color=\"#54b4ef\">(") + userId + qsTr(")</font>")
                }
                Button
                {
                    id: contactButton
                    width: 20
                    height: 20
                    background: Item{
                        opacity:1
                    }
                    onClicked: {
                        // 这里可能有bug，2xxx开头的id也会被当group处理
                        if(100000 <= userId && userId <= 599999){
                            messageWithConact(userId, userName, avatar);
                        }else messageWithGroup(userId, userName, avatar);
                    }

                    Layout.leftMargin: 80
                    icon.source: "./images/icon_chat.png"
                    icon.color: contactButton.hovered ? Material.accent : "transparent"
                }
            }
        }
    }


    ColumnLayout {
        anchors.margins: 12
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 400
        spacing: 0
        anchors.left: parent.left
        anchors.leftMargin: 12

        Label {
            text: "好友"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.leftMargin: 4
            Layout.bottomMargin: 4
        }

        ListView {
            id: contactListView
            model: contactListModel
            spacing: 8
            focus: true
            Layout.fillWidth: true
            height: Math.min(contactListView.contentHeight, 280)
//            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            clip: true
            delegate: contactListItem
        }

        Label {
            text: "群聊"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.leftMargin: 4
            Layout.bottomMargin: 4
        }

        ListView {
            id: groupListView
            model: groupListModel
            spacing: 8
            focus: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            clip: true
            delegate: contactListItem

        }

        Button {
            height: 56; width: 56
            background: Rectangle {
                color: "transparent"
            }
            icon.source: "../images/addFriend.png"
            icon.width: 32
            icon.height: 32

            Layout.alignment: Qt.AlignLeft
            onClicked: {
                addFriendWindow.show()
            }
        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
