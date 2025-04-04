// WarningIndicator.qml
import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Effects

Item {
    id: root
    width: 40
    height: 40

    property string icon: ""
    property bool active: false

    Image {
        id: iconImage
        anchors.fill: parent
        source: icon
        opacity: active ? 1.0 : 0.3
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: active ? 1 : 0
        border.color: "#FF4400"
        opacity: 0.5
    }

    ColorOverlay {
        anchors.fill: iconImage
        source: iconImage
        color: active ? "#FF4400" : "#555555"
    }
}
