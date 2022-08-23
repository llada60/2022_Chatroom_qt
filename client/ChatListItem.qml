import QtQuick 2.12
import "./components"

Item {
    id: multiDelegate

    anchors.left: parent.left
    anchors.right: parent.right
    height: childrenRect.height
    readonly property bool sentByMe: uid == myUid

    function bestDelegate(t) {
        if(t === 1)
            return fileDelegate;
        return txtDelegate; // t == "text"
    }


    PersonalInf
    {
        id:objectInf
    }

    function openInfoWindow(){
        //应增加从服务器扒取其余信息) 为什么没有传递成功啊！
        objectInf.isMe = sentByMe
        objectInf.personalHead = avatar
        objectInf.personalName = name
        objectInf.personalID = uid
        objectInf.show()
    }

    Component {
        id: fileDelegate
        Row {

            property var extraData: JSON.parse(message)

            layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight

            spacing: 6

            RoundImage {
                id: avatarImg
                width: height
                height: 24
                img_src: avatar
                MouseArea
                {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: openInfoWindow()
                    onHoveredChanged: cursorShape = Qt.PointingHandCursor
                }
            }

            FileWidget {
                id: fileWidget
                _fileName: extraData["fileName"]
                _fileSize: extraData["fileSize"]
            }
        }


    }

    Component {
        id: txtDelegate
        Row {
            //            readonly property bool sentByMe: uid == myUid
            layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight

            spacing: 6

            RoundImage {
                id: avatarImg
                width: height
                height: 24
                img_src: avatar
                MouseArea
                {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: openInfoWindow()
                    onHoveredChanged: cursorShape = Qt.PointingHandCursor
                }
            }


            Rectangle {
                id: textContainer
                width: Math.min(messageText.implicitWidth + 16,
                                chatListView.width * 0.6)
                height: messageText.implicitHeight + 12

                color: sentByMe ? "lightgrey" : "steelblue"
                radius: 4
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

    Loader {
        id: itemDisplay
        anchors.left: parent.left
        anchors.right: parent.right
        sourceComponent: bestDelegate(type)
    }
}
