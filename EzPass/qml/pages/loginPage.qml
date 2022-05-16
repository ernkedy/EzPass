import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick 2.15
import QtQml 2.15
import "../components"
import "../js/FunctionsJS.js" as FunctionJS
import QtQuick.Layouts 1.15

Item {
    id: homePageRoot

    Button {
        id: button
        x: 364
        y: 230
        text: qsTr("Login")
        onClicked: {
            backend.switchPage("homePage2")
            backend.sendPassword(password.text)
        }
    }

    TextField {
        id: password
        x: 334
        y: 156
        width: 160
        height: 40
        opacity: 100
        text: ""
        horizontalAlignment: Text.AlignHCenter
        placeholderText: "Password."
        font.pointSize: 6
        echoMode: TextInput.Password
        maximumLength: 36
        placeholderTextColor: "#373737"
        anchors.bottomMargin: 60
        anchors.rightMargin: 110
    }
    Connections {
        target: backend

    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#4c4e50";height:480;width:900}D{i:2}
}
##^##*/
