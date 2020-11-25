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
                if (wheel.angleDelta.y < 0)
                {
                    listviewID.incrementCurrentIndex()
                }
                else
                {
                    listviewID.decrementCurrentIndex()
                }
            }
        }

        Component.onCompleted:
        {
        }

        onAtYEndChanged:
        {

        }
    }

    function setValues(first = 0, last = 59, fill_length = 2, fill_value = '0')
    {
        listviewID.first_value = first
        listviewID.last_value = last
        listviewID.fill_length_value = fill_length
        listviewID.fill_sign_value = fill_value

        var index = 0
        for (var i = listviewID.first_value ; i <= listviewID.last_value; i++)
        {
            modelID.append( {"itemID": index, "number": i.toString().padStart(listviewID.fill_length_value, listviewID.fill_sign_value)} )
            console.log(index + " : " + i)
            index++
        }
    }
}

