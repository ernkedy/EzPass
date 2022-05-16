import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../components"
import "../../js/FunctionsJS.js" as FunctionJS
import QtQuick.Layouts 1.15

Item {
    id: messagesPage

    // Function Messages Scroll To End
    function scrollToEnd(){
        messagesFlickable.contentY = messagesFlickable.contentHeight
    }

    // Custom Messages

    Timer { running: true; interval: 0
        onTriggered: {
            for (var i = 1; i < 10; i++) {
                sendMessage("Test", "Test", "../../../images/images/user_1.png", true)
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

        function changeIcon(path){
            myRightUser.statusIcon = path
        }

        Column {
            id: messagesColumn
            bottomPadding: 30
            topPadding: 10
            spacing: 3
        }

        ScrollBar.vertical: ScrollBar {
            id: controlScroll
            orientation: Qt.Vertical
            y: 3
            bottomPadding: 3
            topPadding: 0
            leftPadding: 0
            rightPadding: 0
            visible: messagesFlickable.moving

            contentItem: Rectangle {
                implicitWidth: 8
                implicitHeight: 100
                radius: width / 2
                color: "#202225"
            }
        }
    }
}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
