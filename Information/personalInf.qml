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

    id: personalInfPage

    //2）发送：设置信息返回服务器端->数据库端存储
    signal sendUsrInf(string name,string saying,int usrid,int sexn,string area,string edul)



    //1）接受数据库发送的个人/好友信息，并展示
    function getIsMeValue(v)
    {
        //v为bool类型
        //v=1表示为个人信息 v=0表示好友信息
        isMe = v
    }
    function getInf(data)
    {
        personalHead = data.personalHead;
        personalName = data.personalName
        personalSaying = data.personalSaying
        personalID = data.personalID
        sex_num = data.sex
        birthday = data.birthday
        areaFrom = data.areaFrom
        edu = data.edu
    }

    property bool isMe: true //1表示个人信息可设置，0表示他人信息不可设置
    property string personalHead: "https://c-ssl.dtstatic.com/uploads/blog/202203/19/20220319111710_f487b.thumb.1000_0.jpg"
    property string pBackground: "https://c-ssl.dtstatic.com/uploads/item/202004/25/20200425235603_ybgrj.thumb.1000_0.jpg"
    property string personalName: "我想开了"
    property string personalSaying: "生如春花之烂漫，逝如秋叶之静美"

    property int sex_num: 0 //1为男 0为女
    property string sex: sex_num==1? "男":"女"
    function sexToNum()
    {
        if("男" == sex)
            sex_num = 1
        else
            sex_num = 0
        return sex_num
    }

    property string birthday: "2000-01-01"
    property var birth1: birthday.split('-')
    property int birthYear: Number(birth1[0])
    property int birthMonth: Number(birth1[1])
    property int birthDay: Number(birth1[2])
    property int nowYear:  2022

    function getBirthYMD()
    {
        birth1 = birthday.split('-')
        birthYear = Number(birth1[0])
        birthMonth = Number(birth1[1])
        birthDay = Number(birth1[2])
    }



    property string areaFrom: "火星"
    property int personalID: 12345

    property string edu: "北理"
    property bool setFlag: true //1：readOnly界面 0:修改界面



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




    ColumnLayout
    {
        z:1
        anchors.fill: parent

        //设置按钮: 切换到设置界面
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
            visible: isMe

            font.pixelSize :15

            text: setFlag?(reset.pressed? qsTr("<font color='#57c1f2'>设置</font>") :
                                 reset.hovered? qsTr("<font color='#57c1f2'>设置</font>") :
                                                ("<font color='#e1e7f2'>设置</font>")):
                           (reset.pressed? qsTr("<font color='#57c1f2'>完成</font>") :
                            reset.hovered? qsTr("<font color='#57c1f2'>完成</font>") :
                                           ("<font color='#e1e7f2'>完成</font>"))

            onClicked:
            {

                console.log("i'm clicked")
                if(1 == setFlag)
                {// 切换到设置模式
                    usrNameC.visible = true
                    usrName.visible = false
                    usrSayingC.visible = true
                    usrSaying.visible = false
                    sexC.visible = true
                    birthdayC.visible = true
                    areaC.visible = true
                    eduC.visible = true
                }

                else
                {// 切换到完成设置，回到readOnly，并发送修改信息
                    usrNameC.visible = false
                    usrName.visible = true

                    usrSayingC.visible = false
                    usrSaying.visible = true

                    personalName = usrNameC.text
                    personalSaying = usrSayingC.text

                    sexC.visible = false
                    sex = sexC.currentText

                    birthdayC.visible = false
                    birthday = birthdayC.text
                    getBirthYMD()

                    areaC.visible = false
                    areaFrom = areaC.text

                    eduC.visible = false
                    edu = eduC.text

                    console.log("个人信息修改已完成")

                    // 发送信号(string name,string saying,int usrid,int sexn,string area,string edul)
                    sendUsrInf(personalName,personalSaying,personalID,sexToNum(),areaFrom,edu)
                }


                setFlag = !setFlag

            }

        }

        // 头像
        Rectangle
        {
            id: img
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -200
            width: 338
            height: 200
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
            //上传图片修改头像：上传方法暂不会
            Button
            {
                id:changeHead
                visible: false
                text: "修改头像"
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
            TextInput
            {
                id: usrNameC
                visible: false
                anchors.centerIn: belowInf
                anchors.verticalCenterOffset: -25
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                font.family: "SimHei"
                font.bold: true
                text: personalName

            }
            TextInput
            {
                id: usrSayingC
                visible: false
                anchors.top: usrName.bottom
                anchors.topMargin: 8
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
                font.family: "LiSu"
                color: "#767777"
                text: personalSaying
            }

        }
        //分割线
        Canvas
        {

            id: canvas
            width: parent.width
            height: parent.height
            onPaint: {
                  var ctx = getContext("2d");
                  draw(ctx);
            }

            function draw(ctx ) {
                // 画之前清空画布
                ctx.clearRect(0, 0, parent.width, parent.height);

                ctx.fillStyle ="#f2f2f2";           // 设置画笔属性
                ctx.strokeStyle = "#f2f2f2";
                ctx.lineWidth = 2

                ctx.beginPath();                  // 开始一条路径
                ctx.moveTo(40,260);         // 移动到指定位置
                ctx.lineTo(298,260);

                ctx.stroke();
             }
        }


        ColumnLayout
        {
            id: detailInf
            anchors.top: belowInf.bottom
            anchors.topMargin: setFlag? 40:30
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 40

            RowLayout
            {
                spacing: setFlag?60:8

                RowLayout{
                    Text {
                        id: sexDisplay
                        text: qsTr("<font color='#8a898a' >性别：</font>") + (setFlag?  sex : qsTr(""))
                    }
                    ComboBox
                    {
                        id: sexC
                        visible: false
                        font: font.pixelSize = 13

                        model: ["男","女"]
                        background: Rectangle
                        {
                            implicitWidth:70
                            implicitHeight:30
                        }
                    }
                }

                RowLayout
                {
                    Text {
                        id: birthdayDisplay
                        text: qsTr("<font color='#8a898a'>生日：</font>") + (setFlag? birthday : qsTr(""))
                    }
                    TextInput
                    {
                        id: birthdayC
                        visible: false
                        text: qsTr(birthday)
                    }
                }



            }

            RowLayout
            {
                spacing: 47

                RowLayout
                {
                    Text {
                        id: areaDisplay
                        text: qsTr("<font color='#8a898a'>地区：</font>") + (setFlag? areaFrom:"")
                    }
                    TextInput
                    {
                        id: areaC
                        font.pixelSize: 13
                        visible: false
                        text: qsTr(areaFrom)
                    }
                }
                RowLayout
                {
                    Text {
                        id: eduDisplay
                        text: qsTr("<font color='#8a898a'>教育经历：</font>") + (setFlag? edu:"")
                    }
                    TextInput
                    {
                        id: eduC
                        width: 20
                        visible: false
                        text: qsTr(edu)
                    }
                }


            }
            RowLayout
            {
                spacing: setFlag? 57:62

                Text {
                    id: ageDisplay
                    text: qsTr("<font color='#8a898a'>年龄：</font>") + (nowYear-birthYear)
                }
                Text {

                    id: shengXiaoDisplay
                    text: qsTr("<font color='#8a898a'>生肖：</font>") + shengXiao
                }



            }
        }
    }





}
