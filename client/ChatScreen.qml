import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "./components"

ColumnLayout {
//    anchors.fill: parent
    spacing: 12
    anchors.margins: 24
    property int myUid: 0
    property string myName: "Shen"
    property string myAvatar: "https://tse2-mm.cn.bing.net/th/id/OIP-C.cS6phGwfJ3qgAtvSXv0rugAAAA?pid=ImgDet&rs=1"
    property int targetId: 1

    // 信号，当前端发送了一条信息时调用
    // targetId: 发给谁
    // message: 消息
    // time: 消息发送的 unix 时间戳（类似 1660893694）
    signal sendData(int targetId, string message, int time)


    // 函数： 当c++层接收到新的消息时调用，往UI里添加一条消息
    // data 样例见下面的 chatListModel
    function appendData(data){
        chatListModel.append(data)
    }

    // 设置聊天对象
    function setArg(uid){
        targetId = uid;
    }

    ListModel {
        id: chatListModel
        ListElement {
            uid: 1
            name: "张三"
            time: 1660893694
            message: "我长得好帅啊~"
            avatar: "https://tse2-mm.cn.bing.net/th/id/OIP-C.cS6phGwfJ3qgAtvSXv0rugAAAA?pid=ImgDet&rs=1"
            type: 0 // type 0: 文本消息 1:文件
        }
        ListElement {
            uid: 0
            name: "李四"
            time: 1660893694
            message: "是啊"
            avatar: "https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1"
            type: 0
        }
        ListElement {
            uid: 0
            name: "李四"
            time: 1660893694
            message: "这是一条很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的消息"
            avatar: "https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1"
            type: 0
        }
    }


    Rectangle {
        radius: 4
        Layout.fillWidth: true
        Layout.fillHeight: true

        ListView {
            id: chatListView
            anchors.fill: parent
            anchors.margins: 16
            clip: true
            spacing: 8
            model: chatListModel
            delegate: ChatListItem{} // getWidget(type)
        }
    }


    Rectangle {
        id: rect
        radius: 4
        Layout.fillWidth: true
        Layout.preferredHeight: childrenRect.height
        Layout.alignment: Qt.AlignBottom
        anchors.margins: 16

        Item {
            id: imgContainer
            width : 20
            height: 20
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 12
            anchors.topMargin: 8
            Image {
                id: img
                source: "./images/icon_folder.png"
                width : parent.width
                height: parent.height


                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                    }
                    hoverEnabled: true
                    onHoveredChanged: cursorShape = Qt.PointingHandCursor

                }
            }

            ColorOverlay {
                anchors.fill: img
                source: img
                color: Material.primary
            }
        }




        RowLayout {

            width: parent.width
            height: 64
            anchors.top: imgContainer.bottom
            anchors.left: parent.left
            anchors.leftMargin: 12

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

                    Keys.onReturnPressed: {
                        sendButton.onClicked()
                    }
                }
            }



            Button {
                id: sendButton
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 16
                text: `<font color="${sendButton.enabled?'white':'green'}">发送</font>`
                enabled: messageField.length > 0
                Material.background: "#90CAF9"
                //                Material.color: sendButton.enabled ? "white" : "lightgrey"
                flat: true
                onClicked: {
                    var message = messageField.text
                    if(message === "") return
                    var time = Date.parse(new Date())/ 1000
                    chatListModel.append({
                                             "uid": myUid,
                                             "name": myName,
                                             "time": Date.parse(new Date())/ 1000,
                                             "message": message,
                                             "avatar": myAvatar
                                         })
                    messageField.clear()
                    chatListView.currentIndex = chatListModel.count - 1;
                    sendData(targetId, message, time)
                }
            }
        }
    }




    Component.onCompleted: {
        chatListModel.append({
                                 "uid": 0,
                                 "name": "李四",
                                 "time": 1660893694,

                                 "fileName": "来来来.txt",
                                 "fileSize": 1389420,
                                 "localPath": "d:/test/来来来.txt",

                                 "avatar": "https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1",
                                 "type": 1 // 1代表文件
                             })
    }



}
