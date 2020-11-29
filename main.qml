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

    Button
    {
        x: 300
        y:200
        width: 100
        height: 50
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
        onValueChanged: object_infinite.setValues(Number(a.value), Number(b.value), 1)
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

        onValueChanged: object_infinite.setValues(Number(a.value), Number(b.value), 1)
    }

    function diff(a,b)
    {
        return Math.abs(a-b) + 1
    }

    Component.onCompleted:
    {


        object_infinite.visible = true
        object_infinite.setValues(-20, 59, 1)
//        object_infinite.setValues()

//        object_infinite.setGradientColor("transparent")

        object_infinite.x=150
        object_infinite.y=150

        object_infinite.width=120
        object_infinite.height=270



    }
}
