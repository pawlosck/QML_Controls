import QtQuick 2.3
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQml 2.12

Item
//Window
{
    id: main_multi_listview

    property var component_value: Qt.createComponent("qrc:/controls/infinite_listview.qml")
    property var object_value1: component_value.createObject(mainWindow)
    property var object_value2: component_value.createObject(mainWindow)
    property var object_value3: component_value.createObject(mainWindow)

    Rectangle
    {
        anchors.fill: parent
        color: "transparent"
        border.width: 1
        border.color: "blue"
    }

    Component.onCompleted:
    {
        object_value1.parent = main_multi_listview
        object_value2.parent = main_multi_listview
        object_value3.parent = main_multi_listview

        object_value1.width = Qt.binding(() => (width/3))
        object_value1.height = Qt.binding(() => height)
        object_value2.width = Qt.binding(() => width/3)
        object_value2.height = Qt.binding(() => height)
        object_value3.width = Qt.binding(() => width/3)
        object_value3.height = Qt.binding(() => height)

        object_value1.x = 0
        object_value1.y = 0
        object_value2.x = Qt.binding(() => object_value1.width)
        object_value2.y = 0
        object_value3.x = Qt.binding(() => object_value1.width + object_value2.width)
        object_value3.y = 0

        object_value1.setNumberOfVisibleElements(1)
        object_value1.setValues(0, 23)

        object_value2.setNumberOfVisibleElements(1)
        object_value2.setValues(0, 59)

        object_value3.setNumberOfVisibleElements(1)
        object_value3.setValues(0, 59)
    }

    function setValues(element, first = 0, last = 59, fill_length = 2, fill_value = '0')
    {
        if (element === 1)
        {
            object_value1.setValues(first, last, fill_length, fill_value)
        }
        else if (element === 2)
        {
            object_value2.setValues(first, last, fill_length, fill_value)
        }
        else if (element === 3)
        {
            object_value3.setValues(first, last, fill_length, fill_value)
        }
    }

    function setSize(width, height)
    {
        main_multi_listview.width = Qt.binding(() => width)
        main_multi_listview.height = Qt.binding(() => height)
    }

    function setPosition(x, y)
    {
        main_multi_listview.x = Qt.binding(() => x)
        main_multi_listview.y = Qt.binding(() => y)
    }

    function setNumberOfVisibleElements(numberOfVisibleElements = 3)
    {
        //Funkcja umozliwiajacy wybor ilosci wierszy w liscie. Dostepne sa opcje 1 i 3 wiersze
        object_value1.setNumberOfVisibleElements(numberOfVisibleElements)
        object_value2.setNumberOfVisibleElements(numberOfVisibleElements)
        object_value3.setNumberOfVisibleElements(numberOfVisibleElements)
    }
}
