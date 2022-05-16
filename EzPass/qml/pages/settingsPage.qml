import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick 2.15
import QtQml 2.15

Item {
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent

        Button {
            id: button
            text: qsTr("Test!")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 199
            anchors.bottomMargin: 241
            anchors.leftMargin: 203
            anchors.rightMargin: 497
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
