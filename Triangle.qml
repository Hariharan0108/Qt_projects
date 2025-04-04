// Triangle.qml
import QtQuick 2.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects
Item {
    id: root

    property color color: "green"
    property string direction: "left" // "left" or "right"

    Shape {
        anchors.fill: parent

        ShapePath {
            fillColor: root.color
            strokeWidth: 0

            PathPolyline {
                path: {
                    if (direction === "left") {
                        return [
                            Qt.point(root.width, 0),
                            Qt.point(0, root.height / 2),
                            Qt.point(root.width, root.height)
                        ];
                    } else {
                        return [
                            Qt.point(0, 0),
                            Qt.point(root.width, root.height / 2),
                            Qt.point(0, root.height)
                        ];
                    }
                }
            }
        }
    }
}
