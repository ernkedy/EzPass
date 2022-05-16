import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick 2.15
import QtQml 2.15


Button {
    id: btnTopBar

    // Properties.
    property url btnIconSource: "../../images/icons/icon_minimize.png"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    property int btnHeight: 16
    property int btnWidth: 16

    width: 30
    height: 30

    QtObject {
        id: internal

        // Mouse over and click colors.
        property var dynamicColor: if(btnTopBar.down) {
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }



    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor
        radius: 5

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: btnHeight
            width: btnWidth
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#C3CCDF"
            antialiasing: false
        }
    }
}


