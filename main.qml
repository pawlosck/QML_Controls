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

    property var component_infinite: Qt.createComponent("infinite_listview/infinite_listview.qml")
    property var object_infinite: component_infinite.createObject(mainWindow)

    Button
    {
        x: 200
        y:200
        width: 100
        height: 50
//        onClicked: object_infinite.
    }

    SpinBox
    {
        x: 0
        y: 0
        from: -999
        to: 999
        id: a
        value: 0

//        onValueChanged: console.log(diff(a.value, b.value))
        onValueChanged: console.log(Math.floor(a.value/2))
    }

    SpinBox
    {
        x: 150
        y: 0
        from: -999
        to: 999
        id: b
        value: 0

        onValueChanged: console.log(diff(a.value, b.value))
    }

    function diff(a,b)
    {
        return Math.abs(a-b) + 1
    }

    Component.onCompleted:
    {


        object_infinite.visible = true
//        object_infinite.setValues(5, 20, 3)
        object_infinite.setValues()

        object_infinite.x=50
        object_infinite.y=50



    }
}
