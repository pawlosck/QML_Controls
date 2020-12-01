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

    property var component_infinite: Qt.createComponent("qrc:/controls/infinite_listview.qml")
    property var object_infinite: component_infinite.createObject(mainWindow)
    property var object_infinite2: component_infinite.createObject(mainWindow)
    property var object_infinite3: component_infinite.createObject(mainWindow)

    Button
    {
        x: 50
        y:75
        width: 100
        height: 50
        visible: true
        onClicked:
        {
            object_infinite.setFontColor("blue")
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
        value: 30
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
        object_infinite.height=120

        object_infinite.setBorderSize(1)

        object_infinite.setGradientColor("gray")

        object_infinite.setFontColor("black")

        object_infinite.setValues(0, 23, 2)
        object_infinite.setNumberOfVisibleElements(1)

        object_infinite.visible = true


////////////////////////////////////////////////////////////

        object_infinite2.x=170
        object_infinite2.y=150

        object_infinite2.width=120
        object_infinite2.height=120
        object_infinite2.setBorderSize(1)

        object_infinite2.setGradientColor("gray")

        object_infinite2.setFontColor("black")

        object_infinite2.setValues(0, 59, 2)
        object_infinite2.setNumberOfVisibleElements(1)

        object_infinite2.visible = true

////////////////////////////////////////////////////////////

        object_infinite3.x=290
        object_infinite3.y=150

        object_infinite3.width=120
        object_infinite3.height=120

        object_infinite3.setBorderSize(1)

        object_infinite3.setGradientColor("gray")

        object_infinite3.setFontColor("black")

        object_infinite3.setValues(0, 59, 2)

        object_infinite3.setNumberOfVisibleElements(1)
//        object_infinite3.setNumberOfVisibleElements(3)

        object_infinite3.visible = true

        object_infinite3.signal_value_changed.connect(function(itemID, number, current_index) {console.log("Funkcja main: " + itemID + " : " + number + " : " + current_index)})

    }

    function zegar()
    {
        console.log("egar")
        var d = new Date();
        var h = d.getHours();
        var m = d.getMinutes();
        var s = d.getSeconds();

        mainWindow.object_infinite.setValue(h)
        mainWindow.object_infinite2.setValue(m)
        mainWindow.object_infinite3.setValue(s)
    }

    Timer
    {
        id: timerUpdateListView
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: mainWindow.zegar()
    }





}
