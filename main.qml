import QtQuick 2.15
import QtQuick.Window 2.15
 import QtQuick.Controls 2.15

Window
{
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property var component_infinite: Qt.createComponent("qrc:/controls/infinite_listview/infinite_listview.qml")
    property var object_infinite: component_infinite.createObject(mainWindow)
    property var object_infinite2: component_infinite.createObject(mainWindow)
    property var object_infinite3: component_infinite.createObject(mainWindow)

    Button
    {
        x: 300
        y:200
        width: 100
        height: 50
        visible: false
        onClicked:
        {
            object_infinite.getValue()
        }
    }

    SpinBox
    {
        x: 0
        y: 0
        from: -10000
        to: 10000
        id: a
        value: 0
        editable: true

//        onValueChanged: console.log(diff(a.value, b.value))
//        onValueChanged: console.log(Math.floor(a.value/2))
        onValueChanged: object_infinite.setValues(Number(a.value), Number(b.value), 2)
    }

    SpinBox
    {
        x: 150
        y: 0
        from: -10000
        to: 10000
        id: b
        value: 59
        editable: true

        onValueChanged: object_infinite.setValues(Number(a.value), Number(b.value), 2)
    }

    SpinBox
    {
        x: 300
        y: 0
        from: -10000
        to: 10000
        id: c
        value: 0
        editable: true

        onValueChanged: object_infinite3.setValue(value)
//        onValueModified: object_infinite3.setValue(value)
    }

    function diff(a,b)
    {
        return Math.abs(a-b) + 1
    }

    Component.onCompleted:
    {
        object_infinite.x=50
        object_infinite.y=150

        object_infinite.width=120
        object_infinite.height=270

        object_infinite.setBorderSize(1)

        object_infinite.setValues(0, 23, 2)

        object_infinite.visible = true


////////////////////////////////////////////////////////////

        object_infinite2.x=170
        object_infinite2.y=150

        object_infinite2.width=120
        object_infinite2.height=270

        object_infinite2.setBorderSize(1)

        object_infinite2.setValues(2000, 2020, 2)

        object_infinite2.visible = true

////////////////////////////////////////////////////////////

        object_infinite3.x=290
        object_infinite3.y=150

        object_infinite3.width=120
        object_infinite3.height=270

        object_infinite3.setBorderSize(1)

        object_infinite3.setValues(-50, 100, 1)

        object_infinite3.visible = true

    }
}
