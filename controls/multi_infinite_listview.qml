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
    }

    Component.onCompleted:
    {
        object_value1.parent = main_multi_listview
        object_value2.parent = main_multi_listview
        object_value3.parent = main_multi_listview

        object_value1.width = Qt.binding(() => width/3)
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

//        setSizeInternal(1, width/3, height)
//        setSizeInternal(2, width/3, height)
//        setSizeInternal(3, width/3, height)

//        setPositionInternal(1, 0, 0)
//        setPositionInternal(2, width/3, 0)
//        setPositionInternal(3, main_multi_listview.x + (main_multi_listview.width*2), main_multi_listview.y)

        object_value1.setNumberOfVisibleElements(1)
//        object_value1.setPosition(0, 0)
//        object_value1.setSize(50, 50)
//        object_value1.setValues(0, 23)


        object_value2.setNumberOfVisibleElements(1)
//        object_value2.setPosition(50, 0)
//        object_value2.setSize(50, 50)
//        object_value2.setValues(0, 59)


        object_value3.setNumberOfVisibleElements(1)
//        object_value3.setPosition(100, 0)
//        object_value3.setSize(50, 50)
//        object_value3.setValues(0, 59)
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

    function setSizeInternal(element, width, height)
    {
        if (element === 1)
        {
            object_value1.setSize(width, height)
        }
        else if (element === 2)
        {
            object_value2.setSize(width, height)
        }
        else if (element === 3)
        {
            object_value3.setSize(width, height)
        }
    }

    function setPositionInternal(element, x, y)
    {
        if (element === 1)
        {
            object_value1.setPosition(x, y)
        }
        else if (element === 2)
        {
            object_value2.setPosition(x, y)
        }
        else if (element === 3)
        {
            object_value3.setPosition(x, y)
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
