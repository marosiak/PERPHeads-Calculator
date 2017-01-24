import QtQuick 2.5
import QtQuick.Controls 2.0

Item {
    id: rpo
    width: 126
    height: 36
    signal clicked
    property string text
    property int value
    Rectangle {
        anchors.fill: parent
        Text {
            anchors.left: parent.left
            anchors.leftMargin: 8
            height: parent.height
            id: txt
            text: rpo.text
            verticalAlignment: Text.AlignVCenter
        }
    }
    MouseArea {
        id: ma
        anchors.fill:parent
        onClicked: rpo.clicked()
    }
    PaperRipple {
            id: ripple
            radius: 1
            mouseArea: ma
        }
}
