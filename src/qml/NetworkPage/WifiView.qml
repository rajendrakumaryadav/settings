import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import FishUI 1.0 as FishUI

ColumnLayout {
    id: _contentLayout
    spacing: FishUI.Units.largeSpacing

    RowLayout {
        spacing: FishUI.Units.smallSpacing * 1.5

        Label {
            id: wlanLabel
            text: qsTr("WLAN")
            color: FishUI.Theme.disabledTextColor
        }

        FishUI.BusyIndicator {
            id: wlanBusyIndicator
            width: wirelessSwitch.height
            height: width
            visible: enabledConnections.wirelessEnabled && wirelessView.count === 0
            running: wlanBusyIndicator.visible
        }

        Item {
            Layout.fillWidth: true
        }

        Switch {
            id: wirelessSwitch
            height: wlanLabel.implicitHeight
            leftPadding: 0
            rightPadding: 0

            checked: enabledConnections.wirelessEnabled
            onCheckedChanged: {
                if (checked) {
                    if (!enabledConnections.wirelessEnabled) {
                        handler.enableWireless(checked)
                        handler.requestScan()
                    }
                } else {
                    if (enabledConnections.wirelessEnabled) {
                        handler.enableWireless(checked)
                    }
                }
            }
        }
    }

    ListView {
        id: wirelessView
        Layout.fillWidth: true
        Layout.preferredHeight: itemHeight * count + ((count - 1) * spacing)
        clip: true
        model: appletProxyModel
        spacing: FishUI.Units.smallSpacing * 1.5
        interactive: false
        visible: count > 0

        property var itemHeight: 45

        delegate: WifiItem {
            width: ListView.view.width
            height: ListView.view.itemHeight
        }
    }
}
