import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import "./components/"

Window {
    visible: false
    width: 1000
    height: 600
    title: qsTr("WeTalk")
    color: "#edf5f9"

    VerticalTabWidget {
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.bottomMargin: 12
        anchors.topMargin: 12
        anchors.fill: parent

        // 聊天页面
        RowLayout {
            spacing: 12
            anchors.fill: parent

            HistoryMessageScreen {
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.3
            }

            ChatScreen {
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.68
            }
        }

        // 联系人页面
        Rectangle {
            anchors.fill: parent
            radius: 4
        }


    }
}
