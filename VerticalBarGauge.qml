// VerticalBarGauge.qml
import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: root

    property real minValue: 0
    property real maxValue: 100
    property real value: 50
    property string labelText: ""

    Rectangle {
        id: background
        anchors.fill: parent
        color: "transparent"

        Column {
            anchors.fill: parent
            spacing: 5

            Text {
                width: parent.width
                text: labelText
                color: "white"
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Rectangle {
                id: barBackground
                width: parent.width
                height: parent.height - 40
                color: "transparent"

                Rectangle {
                    anchors.top: parent.top
                    width: parent.width
                    height: 1
                    color: "#444444"
                }

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    height: 1
                    color: "#444444"

                    Text {
                        anchors.right: parent.left
                        anchors.rightMargin: 5
                        text: "50"
                        color: "white"
                        font.pixelSize: 12
                    }
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: "#444444"

                    Text {
                        anchors.right: parent.left
                        anchors.rightMargin: 5
                        text: "100"
                        color: "white"
                        font.pixelSize: 12
                    }
                }

                Rectangle {
                    width: parent.width * 0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: Math.min(value, 50) / 50 * (parent.height / 2)
                    anchors.bottom: parent.verticalCenter
                    color: "#0088FF"
                }

                Rectangle {
                    width: parent.width * 0.6
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: Math.max(0, Math.min(value - 50, 30)) / 30 * (parent.height * 0.3)
                    anchors.top: parent.verticalCenter
                    color: "#555555"
                }
            }
        }
    }
}
