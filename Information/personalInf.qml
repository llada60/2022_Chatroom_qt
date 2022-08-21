import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.5



Window {
    width: 338
    height: 506
    visible: true

    property string personalHead: "https://c-ssl.dtstatic.com/uploads/blog/202203/19/20220319111710_f487b.thumb.1000_0.jpg"
    property string pBackground: "https://c-ssl.dtstatic.com/uploads/item/202004/25/20200425235603_ybgrj.thumb.1000_0.jpg"
    property string personalName: "清心寡欲"
    property string personalSaying: "生如春花之烂漫，逝如秋叶之静美"

    property int sex_num: 0 //1为男 0为女
    property string sex: sex_num==1? "男":"女"

    property string birthday: "2000-01-01"
    property var birth1: birthday.split('-')
    property int birthYear: Number(birth1[0])
    property int birthMonth: Number(birth1[1])
    property int birthDay: Number(birth1[2])
    property int nowYear:  2022

    property string areaFrom: "火星"
    property int personalID: 12345

    property string edu: "本科"


    function checkShengXiao()
    {
        switch ((birthYear-1000)%12)
        {
            // 1000年为老鼠
            case 0 :
            {
                return "鼠"
                break;
            }
            case 1 :
            {
                return "牛"
                break;
            }
            case 2 :
            {
                return "虎"
                break;
            }
            case 3 :
            {
                return "兔"
                break;
            }
            case 4 :
            {
                return "龙"
                break;
            }
            case 5 :
            {
                return "蛇"
                break;
            }
            case 6 :
            {
                return "马"
                break;
            }
            case 7 :
            {
                return "羊"
                break;
            }
            case 8 :
            {
                return "猴"
                break;
            }
            case 9 :
            {
                return "鸡"
                break;
            }
            case 10 :
            {
                return "狗"
                break;
            }
            case 11 :
            {
                return "猪"
                break;
            }
            default:
            {
                break;
            }
        }
    }

    property string shengXiao: checkShengXiao()

    property string xingZuo: birthMonth

    ColumnLayout
    {
        z:1
        anchors.fill: parent

        //设置按钮: 写成stackView，多界面切换
        ToolButton
        {
            z:100
            id: reset
            width: 15
            height: 15
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top:parent.top
            anchors.topMargin: 10

            font.pixelSize :15

            text: reset.pressed? qsTr("<font color='#57c1f2'>设置</font>") :
                                 reset.hovered? qsTr("<font color='#57c1f2'>设置</font>") :
                                                ("<font color='#e1e7f2'>设置</font>")
        }

        // 头像
        Rectangle
        {
            id: img
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -200
            width: 338
            height: 180
            radius: width/2
            Image
            {
                //背景图
                anchors.fill: img
                source: pBackground
            }
            Rectangle
            {
                id: imgHead
                width: 100
                height: 100
                radius: imgHead.width/2

                anchors.centerIn: img
                anchors.verticalCenterOffset: 80

                Image {
                    id: _image
                    smooth: true
                    anchors.fill: parent
                    visible: false
                    source: personalHead
                    antialiasing: true
                }
                Rectangle {
                    id: _mask
                    anchors.fill: parent
                    radius: imgHead.width/2
                    visible: false
                    antialiasing: true
                    smooth: true
                }
                OpacityMask {
                    id:mask_image
                    anchors.fill: _image
                    source: _image
                    maskSource: _mask
                    visible: true
                    antialiasing: true
                }
            }
        }
        //头像下部分信息
        ColumnLayout
        {
            id: belowInf
            anchors.centerIn: img
            anchors.verticalCenterOffset: 180
            Text
            {
                id: usrName
                anchors.centerIn: belowInf
                anchors.verticalCenterOffset: -25
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.family: "SimHei"
                font.bold: true
                text: personalName
            }
            Text
            {
                id: usrSaying
                anchors.top: usrName.bottom
                anchors.topMargin: 8
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
                font.family: "LiSu"
                color: "#767777"
                text: personalSaying
            }
            //插图片的梦想
//            RowLayout
//            {
//                Text {
//                    id: sex
//                    text: qsTr("性别")
//                }
//                Text {
//                    id: shengxiao
//                    text: qsTr("生肖")
//                }
//                Text {
//                    id: xingzuo
//                    text: qsTr("星座")
//                }
//            }
        }

        ColumnLayout
        {
            id: detailInf
            anchors.top: belowInf.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 40

            RowLayout
            {
                spacing: 50

                Text {
                    id: sexDisplay
                    text: qsTr("<font color='#8a898a'>性别：</font>") + sex
                }
                Text {
                    id: birthdayDisplay
                    text: qsTr("<font color='#8a898a'>生日：</font>") + birthday
                }
            }
            RowLayout
            {
                spacing: 48

                Text {
                    id: ageDisplay
                    text: qsTr("<font color='#8a898a'>年龄：</font>") + (nowYear-birthYear)
                }
                Text {
                    id: areaDisplay
                    text: qsTr("<font color='#8a898a'>地区：</font>") + areaFrom
                }
            }
            RowLayout
            {
                spacing: 50

                Text {

                    id: shengXiaoDisplay
                    text: qsTr("<font color='#8a898a'>生肖：</font>") + shengXiao
                }
                Text {
                    id: aDisplay
                    text: qsTr("<font color='#8a898a'>教育经历：</font>") + edu
                }
            }
        }
    }





}
