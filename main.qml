import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window
{
    id: mainWindow
    width: 640
    height: 900
    visible: true
    title: qsTr("Hello World")
    color: "yellow"

    property var component_value: Qt.createComponent("qrc:/controls/multi_infinite_listview.qml")
    property var object_value: component_value.createObject(mainWindow)

    Button
    {
        x: 50
        y:75
        width: 100
        height: 50
        visible: true
        onClicked:
        {
//            object_infinite.setFontColor("blue")
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
//        onValueChanged: object_infinite.setValues(Number(a.value), Number(b.value), 2)
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

//        onValueChanged: object_infinite.setValues(Number(a.value), Number(b.value), 2)
    }

    SpinBox
    {
        x: 300
        y: 0
        from: -10000
        to: 10000
        id: c
        value: 30
        editable: true

//        onValueChanged: object_infinite3.setValue(value)
//        onValueModified: object_infinite3.setValue(value)
    }

    function diff(a,b)
    {
        return Math.abs(a-b) + 1
    }

    Component.onCompleted:
    {
//        object_value.setPosition(100,100)
//        object_value.setSize(50,150)
        object_value.x = 0
        object_value.y = 100
        object_value.width = 450
        object_value.height = 450

//        object_value.setNumberOfVisibleElements(1)

//        object_value.setPosition(200, 200)
//        object_value.setSize(300, 300)
        object_value.setValues(1, 0, 10, 2, '0')
        object_value.setValues(2, 0, 20, 2, '0')
        object_value.setValues(3, 0, 30, 2, '0')
    }

//    function zegar()
//    {
//        console.log("egar")
//        var d = new Date();
//        var h = d.getHours();
//        var m = d.getMinutes();
//        var s = d.getSeconds();

//        mainWindow.object_infinite.setValue(h)
//        mainWindow.object_infinite2.setValue(m)
//        mainWindow.object_infinite3.setValue(s)
//    }

    Timer
    {
        id: timerUpdateListView
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
//        onTriggered: mainWindow.zegar()
    }
}
