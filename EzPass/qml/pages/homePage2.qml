import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick 2.15
import QtQml 2.15
import "../components"
import "../js/FunctionsJS.js" as FunctionJS

Item {
    id: item1

    Rectangle {
        id: rectangle
        color: "#22252C"
        anchors.fill: parent

        Loader{
            id: homeMessagesLoader
            anchors.left: left_home_page.right
            anchors.fill: parent
            source: Qt.resolvedUrl("homePage/messages.qml")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
