import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick 2.15
import QtQml 2.15
import "../../components"
import "../../js/FunctionsJS.js" as FunctionJS
import QtQuick.Layouts 1.15

Item {
    id: messagesPage
    function scrollToEnd(){
        messagesFlickable.contentY = messagesFlickable.contentHeight}
    property var plist: []
    property var ppsw: []

    Timer {
        running: true
        interval: 0
        onTriggered: {
            backend.receivePassword("sussy")
        }
    }

    Timer {
        id: messagelist
        interval: 0
        running: false
        onTriggered: {
            for (var i = 0; i < plist.length; i++) {
                sendMessage(plist[i], ppsw[i], "../../../images/images/user_1.png", true)
            }
        }
    }

    // Create New Message
    function sendMessage(message, userName, url, isNewMessage){
        if(message){
            var component = Qt.createComponent("messageItem.qml")
            var msg = component.createObject(messagesColumn, {
                "messageText" : message,
                "timeText" : null,
                "userNameText" : userName,
                "userImage" : null,
                "newMessage" : isNewMessage
            })
        }
    }

    Flickable {
        clip: true
        id: messagesFlickable
        anchors.fill: messagesPage
        anchors.rightMargin: 4
        anchors.bottomMargin: 0
        contentHeight: messagesColumn.height
        pressDelay: 1000

        function changeIcon(path){
            myRightUser.statusIcon = path
        }

        Column {
            id: messagesColumn
            bottomPadding: 30
            topPadding: 10
            spacing: 5
        }

        ScrollBar.vertical: ScrollBar {
            id: controlScroll
            orientation: Qt.Vertical
            y: 3
            bottomPadding: 3
            topPadding: 0
            leftPadding: 0
            rightPadding: 0

            contentItem: Rectangle {
                implicitWidth: 8
                implicitHeight: 100
                radius: width / 2
                color: "#202225"
            }
        }
    }

    Connections {
        target: backend

        function onReceivePasswordVar(name) {
            console.log(name)
            var pswlst = name.split("/")
            for (var i = 0; i < pswlst.length; i++) {
                plist.push(pswlst[i].split("-")[1])
                ppsw.push(pswlst[i].split("-")[0])
            }
            messagelist.running = true
        }

    }
}
