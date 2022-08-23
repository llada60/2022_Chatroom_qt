import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Rectangle
{

    width:parent.width

    RowLayout
    {
        Layout.fillWidth: true

        RoundImage
        {
            id: avatarImgP
            img_src: avatarImg

            width: 40
            height: avatarImgP.width
            color: "black"
        }
        Text
        {
            id: searchName
            Layout.leftMargin: 20
            text: userName + qsTr("<font color=\"#54b4ef\">(") + userid + qsTr(")</font>")
        }
        Button
        {
            id: addFriendButton
            width: 20
            height: 20
            background: Item{
                opacity:1
            }
            Layout.leftMargin: 80
            icon.source: addFriendButton.pressed? "qrc:/images/addFriend1.png":
                                 addFriendButton.hovered? "qrc:/images/addFriend1.png" :
                                                ("qrc:/images/addFriend.png")
            icon.color: "transparent"
            onClicked:
            {
                //发出好友（群聊）添加信号
                addSignal()
            }
        }
    }
}
