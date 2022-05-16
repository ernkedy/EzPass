import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.15
import QtQuick 2.15
import QtQml 2.15
import "controls"


Window {
    id: mainWindow
    width: 1000
    height: 580
    minimumWidth: 700
    minimumHeight: 380
    visible: true
    color: "#00000000"
    title: qsTr("EzPass")


    // Properties.

    property int windowStatus: 0
    property string currentPage: "loginPage"
    property int windowMargin: 10
    property alias btnMaximizeRestoreBtnIconSource: btnMaximizeRestore.btnIconSource

    // Functions.

    function absoluteMousePos(mouseArea) {
        var windowAbs = mouseArea.mapToItem(null, mouseArea.mouseX, mouseArea.mouseY)
        return Qt.point(windowAbs.x + mainWindow.x,
                        windowAbs.y + mainWindow.y)
    }

    QtObject{
        id: internal

        function resetResizeBorders() {
            windowStatus = 0
            windowMargin = 10
            bg.radius = 20
            resizeBottom.visible = true
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeTop.visible = true
            resizeAll.visible = true
            btnMaximizeRestore.btnIconSource = "../images/icons/icon_maximize.png"
        }

        function maximizeRestore() {
            if(windowStatus == 0) {
                windowStatus = 1
                windowMargin = 0
                bg.radius = 0
                resizeBottom.visible = false
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeTop.visible = false
                resizeAll.visible = false
                mainWindow.showMaximized()
                btnMaximizeRestore.btnIconSource = "../images/icons/icon_restore.png"
            }
            else{
                mainWindow.showNormal()
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = "../images/icons/icon_maximize.png"
            }
        }

        function restoreMargins() {
            if(windowStatus == 1) {
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = "../images/icons/icon_maximize.png"
            }
        }

        function switchPage(pageName) {
            if (currentPage !== pageName) {
                stackView.push(Qt.resolvedUrl("pages/" + pageName + ".qml"))
                currentPage = pageName
                labelRightInfo.text = pageName
            }
        }

        function reloadPage() {
            stackView.push(Qt.resolvedUrl("pages/" + currentPage + ".qml"))
        }
    }


    // Hints.

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint


    // Drop shadow.

    DropShadow {
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0
    }

    Rectangle {
        id: bg
        visible: true
        color: "#22252c"
        radius: 20
        border.color: "#000000"
        border.width: 7
        anchors.fill: parent
        smooth: true
        antialiasing: true
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#00000000"
                radius: 8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 12
                anchors.leftMargin: 12
                anchors.topMargin: 12

                Rectangle {
                    id: titleBar
                    color: "#00ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 125
                    anchors.leftMargin: 165
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active){
                                            if (mainWindow.Maximized) {}
                                            else {
                                                mainWindow.startSystemMove()
                                                internal.resetResizeBorders()
                                            }
                                         }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                    }
                }
                Row {
                    id: rowButtons
                    x: 802
                    width: 105
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.topMargin: 5
                    anchors.rightMargin: 5

                    TopBarButton {
                        id: btnMinimize
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0
                        anchors.bottomMargin: 20
                        anchors.leftMargin: 0
                        btnColorMouseOver: "#3d4554"
                        btnColorDefault: "#353a48"
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        btnColorMouseOver: "#3d4554"
                        btnColorDefault: "#353a48"
                        btnIconSource: "../images/icons/icon_maximize.png"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        anchors.left: parent.left
                        anchors.leftMargin: 70
                        btnColorMouseOver: "#3d4554"
                        btnColorDefault: "#353a48"
                        btnColorClicked: "#ff007f"
                        btnIconSource: "../images/icons/icon_close.png"
                        onClicked: mainWindow.close()
                        btnWidth: 10
                        btnHeight: 10
                    }
                }

                Image {
                    id: image
                    width: 135
                    height: 50
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "../images/icons.png"
                    cache: false
                    anchors.topMargin: 9
                    anchors.leftMargin: 15
                    sourceSize.height: 48
                    sourceSize.width: 48
                    fillMode: Image.PreserveAspectFit
                }

                Rectangle {
                    id: rectangle1
                    y: 5
                    height: 1
                    color: "#2b3744"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    anchors.rightMargin: 10
                    anchors.leftMargin: 190
                }

                Label {
                    id: label1
                    color: "#ffffff"
                    text: "Safely store your passwords."
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.letterSpacing: -0.2
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.NoWrap
                    renderType: Text.QtRendering
                    textFormat: Text.PlainText
                    layer.textureSize.height: 1
                    leftPadding: 0
                    font.preferShaping: true
                    font.kerning: true
                    font.wordSpacing: -1
                    font.family: "Tahoma"
                    font.styleName: "Regular"
                    font.bold: true
                    styleColor: "#ffffff"
                    anchors.bottomMargin: 0
                    anchors.topMargin: -10
                    anchors.leftMargin: 180
                    font.pointSize: 9
                }
            }

            Rectangle {
                id: content
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 165
                    color: "#00000000"
                    radius: 8
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 12
                    anchors.bottomMargin: 12
                    anchors.topMargin: 10

                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 200; else return 70
                        duration: 425
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: column
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0

                        ToggleButton {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            btnText: "Open File"
                            anchors.topMargin: 0
                            btnIconWeight: 22
                            anchors.rightMargin: 5
                            btnIconSource: "../images/svg__images_2/basic_download.png"
                            btnIconHeight: 22
                            anchors.leftMargin: 5
                            onClicked: backend.openPassword(" ")
                        }

                        ToggleButton {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            btnText: "Create File"
                            anchors.topMargin: 40
                            btnIconSource: "../images/svg__images_2/basic_folder_multiple.png"
                            anchors.leftMargin: 5
                            btnIconWeight: 20
                            anchors.rightMargin: 5
                            btnIconHeight: 20
                            onClicked: backend.createPassword(" ")
                        }

                        ToggleButton {
                            height: 40
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            btnIconSource: "../images/svg__images_2/basic_lock.png"
                            anchors.leftMargin: 5
                            btnText: "Add Password"
                            btnIconWeight: 20
                            anchors.rightMargin: 5
                            anchors.topMargin: 100
                            btnIconHeight: 20

                            Window {
                                id: messageBox
                                text: ""
                                modality: Qt.ApplicationModal
                                title: ""
                                visible: false
                                property alias text: messageBoxLabel.text
                                color: parent.color
                                minimumHeight: 200
                                minimumWidth: 300
                                Label {
                                    anchors.margins: 10
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: messageBoxButton.top
                                    horizontalAlignment: Text.AlignHCenter
                                    wrapMode: Text.WordWrap
                                    id: messageBoxLabel
                                    text: ""
                                }

                                Button {
                                    anchors.margins: 10
                                    id: messageBoxButton
                                    anchors.bottom: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: "Ok"
                                    onClicked: {

                                        messageBox.text = addemail.text + "_" + addpassword.text
                                        messageBox.visible = false
                                        msgbox123.running = true

                                    }
                                }

                                TextField {
                                    id: addemail
                                    x: 75
                                    y: 0
                                    width: 150
                                    height: 40
                                    opacity: 100
                                    text: ""
                                    placeholderText: "Email."
                                    font.pointSize: 6
                                    maximumLength: 36
                                    placeholderTextColor: "#373737"
                                }

                                TextField {
                                    id: addpassword
                                    x: 75
                                    y: 50
                                    width: 150
                                    height: 40
                                    opacity: 100
                                    text: ""
                                    placeholderText: "Password."
                                    font.pointSize: 6
                                    echoMode: TextInput.Password
                                    maximumLength: 36
                                    placeholderTextColor: "#373737"
                                }
                            }



                            Timer {
                                id: msgbox123
                                running: false
                                interval: 0
                                onTriggered: {
                                    console.log("amoguss")
                                    console.log(messageBox.text)
                                    backend.addPassword(messageBox.text)
                                    backend.reloadPage(" ")
                                }
                            }

                            onClicked: {
                                messageBox.visible = true


                            }
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#22252c"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 12
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 12
                    anchors.topMargin: 10

                    StackView {
                        id: stackView
                        opacity: 1
                        anchors.fill: parent
                        clip: true
                        initialItem: Qt.resolvedUrl("pages/loginPage.qml")
                    }
                }
            }
        }

        Rectangle {
            id: rectangle
            height: 1
            color: "#ffffff"
            radius: 5
            border.color: "#2d2f3c"
            border.width: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 18
            anchors.leftMargin: 18
            anchors.topMargin: 7
        }

        Rectangle {
            id: rectangle4
            height: 1
            color: "#ffffff"
            radius: 5
            border.color: "#2d2f3c"
            border.width: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            anchors.leftMargin: 18
            anchors.rightMargin: 18
        }
    }

    Connections {
        target: backend

        function onOpenPasswordVar(name) {
            internal.switchPage("homePage2")
            internal.reloadPage()
        }

        function onSwitchPageVar(name) {
            internal.switchPage(name)
        }

        function onReloadPageVar(name) {
            internal.reloadPage()
        }

    }

    // Mouse Areas.

    MouseArea {
        id: resizeLeft
        x: 0
        width: 10
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.topMargin: 20
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: resizeRight
        x: 990
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 20
        anchors.topMargin: 20
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: resizeBottom
        y: 570
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

    MouseArea {
        id: resizeTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.TopEdge) }
        }
    }

    MouseArea {
        id: resizeAll
        width: 30
        height: 30
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        cursorShape: Qt.SizeFDiagCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge) }
        }
    }
}







/*##^##
Designer {
    D{i:0;height:600;width:1000}
}
##^##*/
