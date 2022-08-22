import QtQuick 2.12
import "./components"

Item {
    id: multiDelegate

    anchors.left: parent.left
    anchors.right: parent.right
    height: childrenRect.height

    function bestDelegate(t) {
        if(t === 1)
            return fileDelegate;
        return txtDelegate; // t == "text"
    }

    Component {
        id: fileDelegate
        Row {
            readonly property bool sentByMe: uid == myUid
            layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight

            spacing: 6

            RoundImage {
                id: avatarImg
                width: height
                height: 24
                img_src: avatar
            }

            FileWidget {
                id: fileWidget
                fileName: fileName
                fileSize: fileSize
            }
        }
    }

    Component {
        id: txtDelegate
        Row {
            readonly property bool sentByMe: uid == myUid
            layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight

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
                height: messageText.implicitHeight + 12

                color: sentByMe ? "lightgrey" : "steelblue"
                radius: 4
                // Layout.margins: 8

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
