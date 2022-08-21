import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Rectangle {
    radius: 8
    property int myUid: 0
    property string myName: "Shen"
    property string myAvatar: "https://tse2-mm.cn.bing.net/th/id/OIP-C.cS6phGwfJ3qgAtvSXv0rugAAAA?pid=ImgDet&rs=1"
    signal onSendData(string message)

    function appendData(data){
        chatListModel.append(data)
    }

    ColumnLayout {

        anchors.fill: parent
        spacing: 12
        anchors.margins: 24



        ListModel {
            id: chatListModel
            ListElement {
                uid: 1
                name: "张三"
                time: 1660893694
                message: "我长得好帅啊~"
                avatar: "https://tse2-mm.cn.bing.net/th/id/OIP-C.cS6phGwfJ3qgAtvSXv0rugAAAA?pid=ImgDet&rs=1"
                type: 0
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


        ListView {
            id: chatListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            //        height: parent.height - 64
            clip: true
            spacing: 8

            model: chatListModel
            delegate: ChatListItem{} // getWidget(type)
        }


        RowLayout {
            width: parent.width
            height: 64

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
                text: `<font color="${sendButton.enabled?'white':'green'}">发送</font>`
                enabled: messageField.length > 0
                Material.background: "#90CAF9"
                //                Material.color: sendButton.enabled ? "white" : "lightgrey"
                flat: true
                onClicked: {
                    var message = messageField.text
                    if(message === "") return
                    chatListModel.append({
                                             "uid": myUid,
                                             "name": myName,
                                             "time": Date.parse(new Date())/ 1000,
                                             "message": message,
                                             "avatar": myAvatar
                                         })
                    messageField.clear()
                    chatListView.currentIndex = chatListModel.count - 1;
                    onSendData(message)
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

                                     "avatar": "https://ts1.cn.mm.bing.net/th/id/R-C.1eed2de61a172c6ca2d79fc5ea62eb01?rik=c7W7KrSN7xFOIg&riu=http%3a%2f%2fimg.crcz.com%2fallimg%2f202003%2f10%2f1583821081100057.jpg&ehk=q%2f9lt0hQhwZzKFdRKYyG2g4zxQKgTWKJ4gHeelom3Mo%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1",
                                     "type": 1 // 1代表文件
                                 })
        }

    }

}
