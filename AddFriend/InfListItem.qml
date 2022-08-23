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
            img_src: headImg

            width: 40
            height: avatarImg.width
            color: "black"
        }
        Text
        {
            id: searchName
            Layout.leftMargin: 25
            text: pName + qsTr("<font color=\"#54b4ef\">(") + pID + qsTr(")</font>")
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
            Layout.leftMargin: 50
            icon.source: addFriendButton.pressed? "qrc:/img/addFriend1.png":
                                 addFriendButton.hovered? "qrc:/img/addFriend1.png" :
                                                ("qrc:/img/addFriend.png")
            icon.color: "transparent"
        }
    }
}
