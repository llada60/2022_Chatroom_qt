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
            id: avatarImg
            img_src: avatar

            width: 40
            height: avatarImg.width
            color: "black"
        }
        Text
        {
            id: searchName
            anchors.left: avatarImg.right
            anchors.leftMargin: 20
            text: userName + qsTr("<font color=\"#54b4ef\">(") + userid + qsTr(")</font>")
        }
        Button
        {
            id: addFriendButton
            width: 20
            height: 20
            background:
            {
                opacity:1
            }
            anchors.left: searchName.right
            anchors.leftMargin: 80
            icon.source: addFriendButton.pressed? "qrc:/img/addFriend1.png":
                                 addFriendButton.hovered? "qrc:/img/addFriend1.png" :
                                                ("qrc:/img/addFriend.png")
            icon.color: "transparent"
        }
    }
}
