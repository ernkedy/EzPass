import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components"
import "../js/FunctionsJS.js" as FunctionJS
import QtQuick.Layouts 1.15

Item {
    id: homePageRoot

    Rectangle {
        id: content
        visible: true
        color: "#22252C"
        radius: 100
        anchors.fill: homePageRoot

        Rectangle {
            id: left_home_page
            width: 300
            color: "#22252C"
            anchors.left: content.left
            anchors.top: content.top
            anchors.bottom: content.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            ColumnLayout {
                id: left_column
                anchors.fill: left_home_page
                spacing: 1

                Loader{
                    id: loaderLeftMenu
                    width: 240
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    source: Qt.resolvedUrl("homePage/leftMessages.qml")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }

        }


        Loader{
            id: homeMessagesLoader
            width: 300
            anchors.left: left_home_page.right
            anchors.top: content.top
            anchors.bottom: content.bottom
            source: Qt.resolvedUrl("homePage/messages.qml")
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
        }
    }

}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#4c4e50";height:480;width:900}
}
##^##*/
