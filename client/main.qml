import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: 900
    height: 600
    title: qsTr("WeTalk")
    color: "#f3efec"


    RowLayout {
        anchors.rightMargin: 12
        anchors.leftMargin: 12
        anchors.bottomMargin: 12
        anchors.topMargin: 12
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

//    ChatScreen {
//        anchors.fill: parent
//    }
}
