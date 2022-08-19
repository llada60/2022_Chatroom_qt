import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

ColumnLayout {
    property int myUid: 0
    property string myName: "Shen"
    property string myAvatar: "https://tse2-mm.cn.bing.net/th/id/OIP-C.cS6phGwfJ3qgAtvSXv0rugAAAA?pid=ImgDet&rs=1"
    width: 800

    anchors.fill: parent
    spacing: 12
    anchors.margins: 24

    signal onSendData(string message)

    function appendData(data){
        chatListModel.append(data)
    }

    ListModel {
        id: chatListModel
        ListElement {
            uid: 1
            name: "张三"
            time: 1660893694
            message: "我长得好帅啊~"
            avatar: "https://tse2-mm.cn.bing.net/th/id/OIP-C.cS6phGwfJ3qgAtvSXv0rugAAAA?pid=ImgDet&rs=1"
        }
        ListElement {
            uid: 0
            name: "李四"
            time: 1660893694
            message: "是啊"
            avatar: "https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1"
        }
        ListElement {
            uid: 0
            name: "李四"
            time: 1660893694
            message: "这是一条很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的消息"
            avatar: "https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1"
        }
    }



    ListView {
        id: chatListView
        Layout.fillWidth: true
        Layout.fillHeight: true
        height: childrenRect.height
        clip: true
        spacing: 8

        model: chatListModel
        delegate: Row {
            readonly property bool sentByMe: uid == myUid
            layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight

            anchors.right: sentByMe ? chatListView.contentItem.right : undefined
            spacing: 6

            RoundImage {
                id: avatarImg
                width: height
                height: 24
                img_src: avatar
            }


            Rectangle {
                id: textContainer
                width: Math.min(messageText.implicitWidth + 16,
                                chatListView.width * 0.6)
                height: messageText.implicitHeight + 16

                color: sentByMe ? "lightgrey" : "steelblue"
                radius: 4
                Layout.margins: 8

                Text {
                    id: messageText
                    anchors.centerIn: parent
                    anchors.fill: parent
                    anchors.margins: 8
                    text: message
                    color: sentByMe ? "black" : "white"
                    wrapMode: Text.WordWrap
                    lineHeight: 1.5
                }
            }
        }


    }

    Pane {
        id: pane
        Layout.fillWidth: true
        background: Rectangle {
            color: undefined
        }

        RowLayout {
            width: parent.width


            ScrollView {
                Layout.fillWidth: true
                TextArea {
                    id: messageField
                    width: maximumWidth
                    placeholderText: qsTr("请输入……")
                    wrapMode: TextArea.Wrap
                    focus: true
                    selectByMouse: true
                    background: null
                }
            }



            Button {
                id: sendButton
                text: `<font color="${sendButton.enabled?'white':'green'}">发送</font>`
                enabled: messageField.length > 0
                Material.background: "#90CAF9"
                //                Material.color: sendButton.enabled ? "white" : "lightgrey"
                flat: true
                onClicked: {
                    var message = messageField.text
                    chatListModel.append({
                                             "uid": myUid,
                                             "name": myName,
                                             "time": Date.parse(new Date())/ 1000,
                                             "message": message,
                                             "avatar": myAvatar
                                         })
                    messageField.clear()
                    onSendData(message)
                }
            }
        }
    }

}

