import QtQuick 2.12
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.12


Item
//Window
{
    id: main_multi_listview

    property var component_value: Qt.createComponent("InfiniteListview.qml")
    property var object_value1: component_value.createObject(mainWindow)
    property var object_value2: component_value.createObject(mainWindow)
    property var object_value3: component_value.createObject(mainWindow)

    property var object_separator1: component_value.createObject(mainWindow)
    property var object_separator2: component_value.createObject(mainWindow)

    TextField
    {
        id: object_value1_textfield

        x: object_value1.x
        y: object_value1.y
        implicitWidth: object_value1.width
        implicitHeight: object_value1.height
        visible: true
        clip: true
        text: ""
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        padding: 0      //pusta przestrzen miedzy tekstem, a obramowaniem
        font.pixelSize: height * 0.8
        validator: IntValidator {}

        background: Rectangle
        {
            anchors.fill: parent
            color: "transparent"
            border.width: 0
        }

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onDoubleClicked:
            {
                object_value1.visible = true
                object_value1_textfield.visible = false
            }

            onClicked:
            {
                object_value1_textfield.focus = true
                object_value1_textfield.selectAll()
            }
        }

        onEditingFinished:
        {
            object_value1.setValue(parseInt(object_value1_textfield.text))
            object_value1.visible = true
            object_value1_textfield.visible = false
        }
    }

    TextField
    {
        id: object_value2_textfield

        x: object_value2.x
        y: object_value2.y
        implicitWidth: object_value2.width
        implicitHeight: object_value2.height
        visible: false
        clip: true
        text: ""
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        padding: 0      //pusta przestrzen miedzy tekstem, a obramowaniem
        font.pixelSize: height * 0.8
        validator: IntValidator {}

        background: Rectangle
        {
            anchors.fill: parent
            color: "transparent"
            border.width: 0
        }

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onDoubleClicked:
            {
                object_value2.visible = true
                object_value2_textfield.visible = false
            }

            onClicked:
            {
                object_value2_textfield.focus = true
                object_value2_textfield.selectAll()
            }
        }

        onEditingFinished:
        {
            object_value2.setValue(parseInt(object_value2_textfield.text))
            object_value2.visible = true
            object_value2_textfield.visible = false
        }
    }

    TextField
    {
        id: object_value3_textfield

        x: object_value3.x
        y: object_value3.y
        implicitWidth: object_value3.width
        implicitHeight: object_value3.height
        visible: false
        clip: true
        text: ""
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        padding: 0      //pusta przestrzen miedzy tekstem, a obramowaniem
        font.pixelSize: height * 0.8
        validator: IntValidator {}

        background: Rectangle
        {
            anchors.fill: parent
            color: "transparent"
            border.width: 0
        }

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onDoubleClicked:
            {
                object_value3.visible = true
                object_value3_textfield.visible = false
            }

            onClicked:
            {
                object_value3_textfield.focus = true
                object_value3_textfield.selectAll()
            }
        }

        onEditingFinished:
        {
            object_value3.setValue(parseInt(object_value3_textfield.text))
            object_value3.visible = true
            object_value3_textfield.visible = false
        }
    }

    Rectangle
    {
        id: external_border
        anchors.fill: parent
        color: "transparent"
        border.width: 1
    }

    Component.onCompleted:
    {
        object_value1.parent = main_multi_listview
        object_value2.parent = main_multi_listview
        object_value3.parent = main_multi_listview

        object_separator1.parent = main_multi_listview
        object_separator2.parent = main_multi_listview


        object_value1.object_name = "object_value1"
        object_value2.object_name = "object_value2"
        object_value3.object_name = "object_value3"

        object_separator1.object_name = "object_object_separator1"
        object_separator2.object_name = "object_object_separator2"

        object_value1.width = Qt.binding(() => (width * 0.3))
        object_value1.height = Qt.binding(() => height)
        object_value2.width = Qt.binding(() => width * 0.3)
        object_value2.height = Qt.binding(() => height)
        object_value3.width = Qt.binding(() => width * 0.3)
        object_value3.height = Qt.binding(() => height)

        object_separator1.width = Qt.binding(() => (width * 0.05))
        object_separator1.height = Qt.binding(() => height)
        object_separator2.width = Qt.binding(() => (width * 0.05))
        object_separator2.height = Qt.binding(() => height)

        object_value1.x = 0
        object_value1.y = 0
        object_value2.x = Qt.binding(() => object_value1.width + object_separator1.width)
        object_value2.y = 0
        object_value3.x = Qt.binding(() => object_value1.width + object_separator1.width + object_value2.width + object_separator2.width)
        object_value3.y = 0

        object_separator1.x = Qt.binding(() => object_value1.width)
        object_separator1.y = 0

        object_separator2.x = Qt.binding(() => object_value1.width + object_separator1.width + object_value2.width)
        object_separator2.y = 0


        object_value1.setNumberOfVisibleElements(1)
        object_value1.setValues(0, 23)

        object_value2.setNumberOfVisibleElements(1)
        object_value2.setValues(0, 59)

        object_value3.setNumberOfVisibleElements(1)
        object_value3.setValues(0, 59)

        object_separator1.setNumberOfVisibleElements(1)
        object_separator2.setNumberOfVisibleElements(1)
        object_separator1.setCustomValue(":")
        object_separator2.setCustomValue(":")

        //Pokaz listview
        object_value1.visible = true
        object_value2.visible = true
        object_value3.visible = true

        //Ukryj obiekty TextField
        object_value1_textfield.visible = false
        object_value2_textfield.visible = false
        object_value3_textfield.visible = false

        //Wymus miganie kursora. To chyba nie dziala, gdy opcja focus nie jest ustawiona na true
        object_value1_textfield.forceActiveFocus()
        object_value2_textfield.forceActiveFocus()
        object_value3_textfield.forceActiveFocus() //Wymusza migajacy kursor

        //Po dwukliku na listview ukryj listview i pokaz textfield
        object_value1.signal_double_clicked.connect(function ()
        {
            object_value1.visible = false
            object_value1_textfield.visible = true
            object_value1_textfield.focus = true

            object_value1_textfield.selectAll()
        })

        object_value2.signal_double_clicked.connect(function ()
        {
            object_value2.visible = false
            object_value2_textfield.visible = true
            object_value2_textfield.focus = true

            object_value2_textfield.selectAll()
        })

        object_value3.signal_double_clicked.connect(function ()
        {
            object_value3.visible = false
            object_value3_textfield.visible = true
            object_value3_textfield.focus = true

            object_value3_textfield.selectAll()
        })
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

    function setValue(element, value)
    {
        if (element === 1)
        {
            object_value1.setValue(value)
        }
        else if (element === 2)
        {
            object_value2.setValue(value)
        }
        else if (element === 3)
        {
            object_value3.setValue(value)
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

    function getValue(element = 0)
    {
        var val1 = object_value1.getValue()
        var val2 = object_value2.getValue()
        var val3 = object_value3.getValue()

        var values_array = [val1, val2, val3];

        if (element === 0)
        {
            return values_array
        }
        else
        if (element === 1)
        {
            return values_array[0]
        }
        else if (element === 2)
        {
            return values_array[1]
        }
        else if (element === 3)
        {
            return values_array[2]
        }

        return null
    }

    function setInternalBorderSize(element, size = 0)
    {
        if (element === 0)
        {
            object_value1.setBorderSize(size)
            object_value2.setBorderSize(size)
            object_value3.setBorderSize(size)

            object_separator1.setBorderSize(size)
            object_separator2.setBorderSize(size)
        }
        else
        if (element === 1)
        {
            object_value1.setBorderSize(size)
        }
        else if (element === 2)
        {
            object_separator1.setBorderSize(size)
        }
        else if (element === 3)
        {
            object_value2.setBorderSize(size)
        }
        else if (element === 4)
        {
            object_separator2.setBorderSize(size)
        }
        else if (element === 5)
        {
            object_value3.setBorderSize(size)
        }
    }

    function setBorderSize(size = 0)
    {
        external_border.border.width = size
    }

    function setGradientColor(element, color = 'gray')
    {
        if (element === 0)
        {
            object_value1.setGradientColor(color)
            object_value2.setGradientColor(color)
            object_value3.setGradientColor(color)

            object_separator1.setGradientColor(color)
            object_separator2.setGradientColor(color)
        }
        else
        if (element === 1)
        {
            object_value1.setGradientColor(color)
        }
        else if (element === 2)
        {
            object_separator1.setGradientColor(color)
        }
        else if (element === 3)
        {
            object_value2.setGradientColor(color)
        }
        else if (element === 4)
        {
            object_separator2.setGradientColor(color)
        }
        else if (element === 5)
        {
            object_value3.setGradientColor(color)
        }
    }
}
