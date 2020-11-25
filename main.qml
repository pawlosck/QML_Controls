import QtQuick 2.15
import QtQuick.Window 2.15

Window
{
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property var component_infinite: Qt.createComponent("infinite_listview/infinite_listview.qml")
    property var object_infinite: component_infinite.createObject(mainWindow)

    Component.onCompleted:
    {


        object_infinite.visible = true
//        object_infinite.setValues(5, 20, 3)
        object_infinite.setValues()

        object_infinite.x=50
        object_infinite.y=50
    }
}
