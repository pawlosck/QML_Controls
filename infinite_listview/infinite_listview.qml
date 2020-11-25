import QtQuick 2.3
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQml 2.12

//Item
Window
{
    width: 30
    height: 60
    ListModel
    {
        id: modelID

//        ListElement
//        {
//            itemID: 0
//            number: 0
//        }
    }

    Component
    {
        id: delegateID
        Rectangle
        {
            id: itemDelegate
            height: listviewID.height/3
            width: listviewID.width
            x: 0
            y: 0

            Text
            {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                height: parent.height
                width: parent.width
                text: number

                font.pixelSize: parent.height
                fontSizeMode: Text.Fit
            }
        }
    }

    ListView
    {

        id: listviewID

        property var first_value: 0
        property var last_value: 99
        property var fill_length_value: 2
        property var fill_sign_value: '0'

        width: parent.width
        height: parent.height

        //Ucina listview do konkretnego rozmiaru. PRzydatne, gdy uzyje sie opcji preferredHighlightBegin i preferredHighlightEnd
        clip: true

        //Ustawia ilosc widocznego listview na poczatku i na koncu. To jest dodatkowa przestrzen widoczna. PRzydaje sie, zeby elementy plynnie pojawialy sie i znikaly Dane podawane w pikselach.
        preferredHighlightBegin: parent.height/3
        preferredHighlightEnd: parent.height/3
        highlightRangeMode: ListView.StrictlyEnforceRange

        highlightMoveDuration: 1000
        highlightMoveVelocity: -1

        model: modelID
        delegate: delegateID

        Rectangle
        {
            id: current_index_border
            x: 0
            y: parent.height/3
            width: parent.width
            height: parent.height/3
            color: "transparent"
            border.width: 1
        }

        MouseArea
        {
            anchors.fill: parent
            onWheel:
            {
                console.log( listviewID.currentIndex )
                if (wheel.angleDelta.y < 0)
                {
                    console.log("W DOL 1->2")
                    console.log(listviewID.currentIndex)
                    if(listviewID.currentIndex > (modelID.count/2))
                    {
                        modelID.move(0, modelID.count - 1, 1)
//                        listviewID.currentIndex = modelID.count - 1
                    }
                    listviewID.incrementCurrentIndex()
                }
                else if (wheel.angleDelta.y > 0)
                {
                    console.log("W GORE 2->1")
                    console.log(listviewID.currentIndex)
                    if(listviewID.currentIndex < (modelID.count/2))
                    {
                        modelID.move(modelID.count - 1, 0, 1)
//                        listviewID.currentIndex = 0
                    }
                    listviewID.decrementCurrentIndex()
                }
            }
        }

        Component.onCompleted:
        {
        }
    }

    function setValues(first = 0, last = 59, fill_length = 2, fill_value = '0')
    {
        listviewID.first_value = first
        listviewID.last_value = last
        listviewID.fill_length_value = fill_length
        listviewID.fill_sign_value = fill_value

        var sum = numberOfElements(first, last)
        var half1 = 0
        var half2 = 0

        var resultOfMod = sum % 2
        if (resultOfMod === 0)
        {
            half1 = Math.floor(sum/2)
        }
        else
        {
            half1 = Math.floor(sum/2)
            half2 = sum - half1
        }


        modelID.clear()

        var index = listviewID.last_value - half1
        for (var i = (listviewID.first_value) ; i <= listviewID.last_value; i++)
        {
            console.log("index: " + index + " : i: " + i + " : listviewID.first_value: " + listviewID.first_value)
            if ( index <= listviewID.last_value)
            {
                modelID.append( {"itemID": index, "number": index.toString().padStart(listviewID.fill_length_value, listviewID.fill_sign_value)} )
            }
            else
            {
                index = listviewID.first_value
                modelID.append( {"itemID": index, "number": index.toString().padStart(listviewID.fill_length_value, listviewID.fill_sign_value)} )
            }

            index++
        }
    }

    function numberOfElements(a, b)
    {
        //Zwraca ilosc elementow, niezaleznie, czy pierwsza, lub ostatnia liczba jest dodatnia, lub ujemna
        return Math.abs(a-b) + 1
    }
}

