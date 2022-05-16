import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick 2.15
import QtQml 2.15


Button {
    id: btnToggle

    // Properties.
    property int btnIconWeight: 28
    property int btnIconHeight: 28
    property url btnIconSource: "../../images/icons/cil-menu.png"
    property string btnText: "Lorem Ipsum"
    property color btnIconDefault: "#778cac"
    property color btnIconClicked: "#00E097"
    property color btnColorDefault: "#00000000"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#303136"
    visible: true
    implicitWidth: 40
    implicitHeight: 40

    QtObject {
        id: internal

        // Mouse over and click colors.
        property var dynamicColor: if(btnToggle.down) {
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    Image {
        id: iconBtn
        width: 20
        source: btnIconSource
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        smooth: true
        sourceSize.height: 32
        sourceSize.width: 32
        fillMode: Image.PreserveAspectFit
        visible: false
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
    }

    ColorOverlay {
        anchors.fill: iconBtn
        source: iconBtn
        color: "#778cac"
        antialiasing: false
    }

    Text {
        id: text1
        y: 12
        color: "#a1b3c6"
        text: qsTr(btnText)
        anchors.left: iconBtn.right
        anchors.right: parent.right
        font.pixelSize: 13
        font.family: "Tahoma"
        font.underline: false
        font.italic: false
        font.bold: false
        anchors.rightMargin: 10
        anchors.leftMargin: 10
    }

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        visible: true
        radius: 10
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:40;width:160}D{i:2}D{i:4}
}
##^##*/
