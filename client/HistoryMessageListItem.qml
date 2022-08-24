import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import "./js/time_utils.js" as TimeUtils
import "./components"

Rectangle {
    id: itemContainer
    anchors.left: parent.left
    anchors.right: parent.right
    height: 72
    clip: true
    color: ListView.isCurrentItem ? "#f2f2f2" : "white"
    radius: ListView.isCurrentItem ? 12 : 8


    RowLayout {
        height: parent.height
        spacing: 8
        width: 270 // parent.width

        RoundImage {
            id: avatarImg
            img_src: avatar
            width: 48
            height: avatarImg.width
            Layout.leftMargin: 8
            color: "blue"
        }

//        Label {
//            Layout.alignment: Qt.AlignLeft
//            color: "#ee000000"
//            text: `<font color=\"#5e5e5e\">${latestMessage}</font>`
//            Layout.maximumWidth: itemContainer * 0.6
//            elide: "ElideRight"
//            font.pointSize: 9
//        }

        RowLayout {
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.topMargin: (itemContainer.height - avatarImg.height ) / 2 + 4
            Layout.fillWidth: true
            ColumnLayout {
                Layout.alignment: Qt.AlignLeft
                Label{
                    id: userNameLabel
                    text: userName
                    elide: "ElideRight"
                }
                Label {
                    color: "#ee000000"
                    text: `<font color="#5e5e5e">${latestMessage}</font>`
                    Layout.maximumWidth: itemContainer * 0.6
                    elide: "ElideRight"
                    font.pointSize: 9
                }

            }
            Label {
                text: TimeUtils.getTimeString(new Date(latestTime));
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                Layout.rightMargin: 8
                font.pointSize: 8
            }
        }
    }
}
