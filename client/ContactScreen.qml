import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import "./components"

Rectangle {
    id: rectangle


    radius: 4

    // 信号，点击item触发，参数为对应项的data
    // data 的数据参考同下

    signal clickHistoryMessageItem(var data)

    // 获取到聊天记录后调这个函数，messages为json数组。每一项的数据data参考如下
    /**
      userId: 1
      userName: "张三"
      avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
      latestTime: 1661053691
      latestMessage: "你说咱们要不就继续加油吧"
    */

    function setMessages(messages){
        historyMessageListModel.clear()
        for(each of messages){
            historyMessageListModel.append(each)
        }
    }

    AddFriendWindow{ id : addFriendWindow }

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

    //    Label {
    //        id: labelFriend
    //        text: "好友"
    //    }


    ColumnLayout {
        anchors.margins: 12
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 235
        anchors.left: parent.left
        anchors.leftMargin: 12



        ListView {
            id: contactListView
            model: contactListModel

            spacing: 8
            focus: true
            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true

            delegate: Rectangle
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

                        Layout.leftMargin: 80
                        icon.source: "./images/icon_chat.png"
                        icon.color: contactButton.hovered ? Material.accent : "transparent"
                    }
                }
            }
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
