// Main.qml
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects
Window {
    id: root
    width: 1200
    height: 600
    visible: true
    color: "black"
    title: "Vehicle Dashboard"

    // Properties that would be connected to your vehicle data
    property real speedValue: 0
    property real rpmValue: 0
    property real leftOilPressure: 50
    property real rightOilPressure: 50
    property bool engineOilWarning: true
    property bool batteryWarning: true
    property bool coolantTempWarning: true
    property bool engineWarning: true
    property bool brakeWarning: true
    property bool tirePressureWarning: true

    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"

        // Digital time display
        Text {
            id: timeDisplay
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            text: "21:45"
            color: "white"
            font.pixelSize: 40
            font.family: "Arial"
        }

        // Warning lights row
        Row {
            id: warningLights
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: timeDisplay.bottom
            anchors.topMargin: 20
            spacing: 30

            WarningIndicator {
                icon: ""  // Replace with actual icon path if available
                active: engineOilWarning
            }

            WarningIndicator {
                icon: ""  // Replace with actual icon path if available
                active: batteryWarning
            }

            WarningIndicator {
                icon: ""  // Replace with actual icon path if available
                active: coolantTempWarning
            }

            WarningIndicator {
                icon: ""  // Replace with actual icon path if available
                active: engineWarning
            }

            WarningIndicator {
                icon: ""  // Replace with actual icon path if available
                active: brakeWarning
            }

            WarningIndicator {
                icon: ""  // Replace with actual icon path if available
                active: tirePressureWarning
            }
        }

        // Digital speed/value display
        Rectangle {
            id: digitalDisplay
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: warningLights.bottom
            anchors.topMargin: 40
            width: 200
            height: 80
            color: "transparent"
            border.color: "#444444"

            Text {
                anchors.centerIn: parent
                text: "0"
                color: "white"
                font.pixelSize: 60
                font.bold: true
                font.family: "Arial"
            }
        }

        // Speedometer gauge
        CircularGauge {
            id: speedometer
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            width: 400
            height: 400
            minValue: 0
            maxValue: 220
            value: speedValue
            labelText: "km/h"
            valueFontSize: 40
            gaugeColor: "#00AAFF"
            tickCount: 11
            startAngle: 140
            endAngle: -40
        }

        // RPM gauge
        CircularGauge {
            id: rpmGauge
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            width: 400
            height: 400
            minValue: 0
            maxValue: 8
            value: rpmValue
            labelText: "RPM\n1000x"
            valueFontSize: 40
            gaugeColor: "#00AAFF"
            tickCount: 9
            startAngle: 220
            endAngle: 40
        }

        // Left transmission oil pressure
        VerticalBarGauge {
            id: leftOilGauge
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 470
            width: 100
            height: 200
            minValue: 0
            maxValue: 100
            value: leftOilPressure
            labelText: "Transmission Oil\nPressure"
        }

        // Right transmission oil pressure
        VerticalBarGauge {
            id: rightOilGauge
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.right: parent.right
            anchors.rightMargin: 470
            width: 100
            height: 200
            minValue: 0
            maxValue: 100
            value: rightOilPressure
            labelText: "Transmission Oil\nPressure"
        }

        // Green navigation indicators
        Item {
            id: navigationIndicators
            anchors.top: parent.top
            anchors.topMargin: 120
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            Triangle {
                id: leftIndicator
                anchors.left: parent.left
                anchors.leftMargin: 100
                width: 80
                height: 50
                color: "#00FF00"
                direction: "left"
            }

            Triangle {
                id: rightIndicator
                anchors.right: parent.right
                anchors.rightMargin: 100
                width: 80
                height: 50
                color: "#00FF00"
                direction: "right"
            }
        }
    }

    // Mock controls for demo purposes
    Rectangle {
        visible: true // Set to true for testing
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        width: 150
        height: 100
        color: "#333333"

        Column {
            anchors.fill: parent
            spacing: 10

            Button {
                text: "Speed +"
                onClicked: {
                    if (speedValue < 220) speedValue += 10
                }
            }

            Button {
                text: "RPM +"
                onClicked: {
                    if (rpmValue < 8) rpmValue += 0.5
                }
            }
        }
    }

    // Test animation
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            // Simulate changing values for demo
            speedValue = (speedValue + 10) % 220
            rpmValue = (rpmValue + 0.5) % 8
            if (rpmValue < 0.1) rpmValue = 0.5
        }
    }
}
