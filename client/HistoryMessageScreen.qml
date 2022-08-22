import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Rectangle {

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
                    clickHistoryMessageItem(historyMessageListModel[index])
                }
            }
        }
    }
}


