// CircularGauge.qml
import QtQuick 2.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: root

    property real minValue: 0
    property real maxValue: 100
    property real value: 50
    property string labelText: ""
    property color gaugeColor: "#00AAFF"
    property int valueFontSize: 30
    property int tickCount: 11
    property real startAngle: 140
    property real endAngle: -40

    property real angleRange: endAngle > startAngle ? 360 - (startAngle - endAngle) : startAngle - endAngle
    property real valueAngle: startAngle - (value - minValue) / (maxValue - minValue) * angleRange

    Rectangle {
        id: outerRing
        anchors.fill: parent
        color: "transparent"
        radius: width / 2
        border.width: 4
        border.color: gaugeColor
    }

    Shape {
        id: tick_marks
        anchors.fill: parent

        ShapePath {
            strokeWidth: 2
            strokeColor: "white"
            fillColor: "transparent"

            PathPolyline {
                id: tickPath
            }

            Component.onCompleted: {
                var points = [];
                var centerX = width / 2;
                var centerY = height / 2;
                var radiusOuter = width / 2 - 10;
                var radiusInner = width / 2 - 30;

                for (var i = 0; i < tickCount; i++) {
                    var tickValue = minValue + (maxValue - minValue) * i / (tickCount - 1);
                    var angle = startAngle - (tickValue - minValue) / (maxValue - minValue) * angleRange;
                    var radians = angle * Math.PI / 180;

                    var x1 = centerX + radiusInner * Math.cos(radians);
                    var y1 = centerY - radiusInner * Math.sin(radians);
                    var x2 = centerX + radiusOuter * Math.cos(radians);
                    var y2 = centerY - radiusOuter * Math.sin(radians);

                    points.push(Qt.point(x1, y1));
                    points.push(Qt.point(x2, y2));

                    var labelRadius = radiusInner - 25;
                    var labelX = centerX + labelRadius * Math.cos(radians);
                    var labelY = centerY - labelRadius * Math.sin(radians);

                    var numberLabel = numberComponent.createObject(root, {
                        "x": labelX - 15,
                        "y": labelY - 15,
                        "text": tickValue.toFixed(0)
                    });
                }

                tickPath.path = points;
            }
        }
    }

    Rectangle {
        id: centerCircle
        anchors.centerIn: parent
        width: parent.width * 0.5
        height: width
        radius: width / 2

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#000033" }
            GradientStop { position: 1.0; color: "#0000FF" }
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: centerCircle.width
                height: centerCircle.height
                radius: width / 2
            }
        }
    }

    Text {
        anchors.bottom: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: value.toFixed(0)
        color: "white"
        font.pixelSize: valueFontSize
        font.bold: true
    }

    Text {
        anchors.top: parent.verticalCenter
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        text: labelText
        color: "white"
        font.pixelSize: valueFontSize / 2
        horizontalAlignment: Text.AlignHCenter
    }

    Shape {
        id: needle
        anchors.fill: parent
        rotation: valueAngle
        transformOrigin: Item.Center

        ShapePath {
            strokeWidth: 2
            strokeColor: "red"
            fillColor: "red"

            startX: parent.width / 2
            startY: parent.height / 2

            PathLine { x: parent.width / 2; y: parent.height * 0.2 }
            PathLine { x: parent.width / 2 + 5; y: parent.height / 2 }
            PathLine { x: parent.width / 2 - 5; y: parent.height / 2 }
        }
    }

    Component {
        id: numberComponent

        Text {
            width: 30
            height: 30
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 16
        }
    }
}
