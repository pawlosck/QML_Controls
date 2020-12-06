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
//    property var component_value: Qt.createComponent("qrc:/controls/infinite_listview.qml")
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

//        onValueChanged: object_value.setSize(value*3, value)
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
        value: 1
        editable: true

        onValueChanged: object_value.setNumberOfVisibleElements(value)
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
//        object_value.setPosition(200,200)
//        object_value.setSize(150,450)
//        object_value.x = 0
//        object_value.y = 0
//        object_value.width = 150
//        object_value.height = 150

        object_value.setNumberOfVisibleElements(1)
//        object_value.setNumberOfVisibleElements(3)            //////


        object_value.setPosition(0, 0)
//        object_value.setSize(Qt.binding(() => mainWindow.width), Qt.binding(() => mainWindow.height))
        object_value.width = Qt.binding(() => width)
        object_value.height = Qt.binding(() => height)

        object_value.setValues(1, 0, 6, 2, '0')
        object_value.setValues(2, 0, 6, 2, '0')
        object_value.setValues(3, 0, 10, 2, '0')

//        object_value.setValues(-5, 3, 1, '0')                  ////////
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
