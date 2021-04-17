import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import FishUI 1.0 as FishUI

Item {
    implicitWidth: 230

    property int itemRadiusV: 8

    property alias view: listView
    property alias model: listModel
    property alias currentIndex: listView.currentIndex

    Rectangle {
        anchors.fill: parent
        color: FishUI.Theme.secondBackgroundColor

        Behavior on color {
            ColorAnimation {
                duration: 250
                easing.type: Easing.Linear
            }
        }
    }

    ListModel {
        id: listModel

        ListElement {
            title: qsTr("User")
            name: "accounts"
            page: "qrc:/qml/AccountsPage.qml"
            iconSource: "accounts.svg"
        }

        ListElement {
            title: qsTr("Display")
            name: "display"
            page: "qrc:/qml/DisplayPage.qml"
            iconSource: "display.svg"
        }

        ListElement {
            title: qsTr("Network")
            name: "network"
            page: "qrc:/qml/NetworkPage/main.qml"
            iconSource: "network.svg"
        }

//        ListElement {
//            title: qsTr("Bluetooth")
//            name: "bluetooth"
//            page: "qrc:/qml/BluetoothPage.qml"
//            iconSource: "bluetooth.svg"
//        }

        ListElement {
            title: qsTr("Appearance")
            name: "appearance"
            page: "qrc:/qml/AppearancePage.qml"
            iconSource: "appearance.svg"
        }

        ListElement {
            title: qsTr("Background")
            name: "background"
            page: "qrc:/qml/Wallpaper/BackgroundPage.qml"
            iconSource: "wallpaper.svg"
        }

        ListElement {
            title: qsTr("Dock")
            name: "dock"
            page: "qrc:/qml/DockPage.qml"
            iconSource: "dock.svg"
        }

        ListElement {
            title: qsTr("Language")
            name: "language"
            page: "qrc:/qml/LanguagePage.qml"
            iconSource: "language.svg"
        }

        ListElement {
            title: qsTr("Battery")
            name: "battery"
            page: "qrc:/qml/BatteryPage.qml"
            iconSource: "battery.svg"
        }

        ListElement {
            title: qsTr("About")
            name: "about"
            page: "qrc:/qml/AboutPage.qml"
            iconSource: "about.svg"
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: listModel

            spacing: FishUI.Units.smallSpacing * 1.5
            leftMargin: FishUI.Units.largeSpacing
            rightMargin: FishUI.Units.largeSpacing
            topMargin: FishUI.Units.smallSpacing * 1.5

            ScrollBar.vertical: ScrollBar {}

            highlightFollowsCurrentItem: true
            highlightMoveDuration: 0
            highlightResizeDuration : 0
            highlight: Rectangle {
                radius: FishUI.Theme.mediumRadius
                color: FishUI.Theme.highlightColor
                smooth: true
            }

            delegate: Item {
                id: item
                width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
                height: 43

                property bool isCurrent: listView.currentIndex === index

                Rectangle {
                    anchors.fill: parent

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton
                        onClicked: listView.currentIndex = index
                    }

                    radius: FishUI.Theme.mediumRadius
                    color: mouseArea.containsMouse ? Qt.rgba(FishUI.Theme.textColor.r,
                                                             FishUI.Theme.textColor.g,
                                                             FishUI.Theme.textColor.b,
                                                             0.1) : "transparent"
                    smooth: true
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: FishUI.Units.largeSpacing
                    spacing: FishUI.Units.largeSpacing

                    Image {
                        id: icon
                        width: 16
                        height: width
                        source: FishUI.Theme.darkMode || isCurrent ? "qrc:/images/sidebar/dark/" + model.iconSource
                                                                   : "qrc:/images/sidebar/light/" + model.iconSource
                        sourceSize: Qt.size(width, height)
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Label {
                        id: itemTitle
                        text: model.title
                        color: isCurrent ? FishUI.Theme.highlightedTextColor : FishUI.Theme.textColor
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
