import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Rectangle {
    radius: 4
    ListModel {
        id: historyMessageListModel
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
            latestTime: 1661053691
            latestMessage: "你说咱们要不就继续加油吧"
        }
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
            latestTime: 1661053691
            latestMessage: "你说咱们要不就继续加油吧"
        }
        ListElement {
            userId: 1
            userName: "张三"
            avatar: "https://www.com8.cn/wp-content/uploads/2020/08/20200823052248-5f41fd28d49e4.jpg"
            latestTime: 1661053691
            latestMessage: "你说咱们要不就继续加油吧"
        }
    }

    ListView {
        id: historyMessageListView
        model: historyMessageListModel
        anchors.fill: parent
        spacing: 8
        focus: true
        anchors.margins: 8

        delegate: HistoryMessageListItem{
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    historyMessageListView.currentIndex = index
                }
            }
        }
    }
}


