import QtQuick 2.3
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQml 2.12

Item
//Window
{

    id: mainListView

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
        onCurrentItemChanged:
        {
            //Kod odpowiedzialny za nieskonczone przewijanie przy uzyciu myszy (wcisniety lewy przycisk myszy) i dotyku na Androidzie. Kod przenosi elemeny z konca listy na poczatek i odwrotnie
            if(listviewID.currentIndex < (modelID.count/2))
            {
                modelID.move(modelID.count - 1, 0, 1)
            }

            if(listviewID.currentIndex > (modelID.count/2))
            {
                modelID.move(0, modelID.count - 1, 1)
            }
        }

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

        property bool set_values_first_time: false

        model: modelID
        delegate: delegateID

        Rectangle
        {
            //Obramowanie srodkowej czesci listy
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
                //Kod odpowiadajacy za nieskoczone przewijanie przy uzyciu scroola myszy
                console.log( listviewID.currentIndex )
                if (wheel.angleDelta.y < 0)
                {
                    console.log("W DOL 1->2")
                    console.log(listviewID.currentIndex)
                    var curr_index_tmp = listviewID.currentIndex
                    if(listviewID.currentIndex > (modelID.count/2))
                    {
                        modelID.move(0, modelID.count - 1, 1)
                        modelID.move(0, modelID.count - 1, 1)
                        modelID.move(0, modelID.count - 1, 1)
//                        modelID.move(0, modelID.count - 1, 1)
//                        modelID.move(0, modelID.count - 1, 1)
                        listviewID.currentIndex = curr_index_tmp-3
                    }
                    listviewID.incrementCurrentIndex()
                }
                else if (wheel.angleDelta.y > 0)
                {
                    console.log("W GORE 2->1")
                    console.log(listviewID.currentIndex)
                    var curr_index_tmp = listviewID.currentIndex
                    if(listviewID.currentIndex < (modelID.count/2))
                    {
                        modelID.move(modelID.count - 1, 0, 1)
                        modelID.move(modelID.count - 1, 0, 1)
                        modelID.move(modelID.count - 1, 0, 1)
//                        modelID.move(modelID.count - 1, 0, 1)
//                        modelID.move(modelID.count - 1, 0, 1)
                        listviewID.currentIndex = curr_index_tmp+3
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
        listviewID.first_value = Number(first)
        listviewID.last_value = Number(last)
        listviewID.fill_length_value = Number(fill_length)
        listviewID.fill_sign_value = fill_value

        //Obliczenia zwiazane z okresleniem srodkowego elementu listy, ktory ma byc na poczatku listy
        var sum = numberOfElements(listviewID.first_value, listviewID.last_value)
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
        //Dodawania elementow do listy
        for (var index_tmp = listviewID.last_value - half1, i = listviewID.first_value ; i <= listviewID.last_value; i++, index_tmp++)
        {
            console.log("index_tmp: " + index_tmp + " : i: " + i + " : listviewID.first_value: " + listviewID.first_value)
            if ( index_tmp <= listviewID.last_value)
            {
                modelID.append( {"itemID": index_tmp, "number": index_tmp.toString().padStart(listviewID.fill_length_value, listviewID.fill_sign_value)} )
            }
            else
            {
                //Jak dodawany element dojdzie do wartosci listviewID.last_value, to licznik sie resetuje, zeby lista zaczynala sie na srodku, na srodku byla wartosc 0 i ostatni element takze byl na srodku listy
                index_tmp = listviewID.first_value
                modelID.append( {"itemID": index_tmp, "number": index_tmp.toString().padStart(listviewID.fill_length_value, listviewID.fill_sign_value)} )
            }
        }

        listviewID.currentIndex = -1    //Z tym ustaiwniem, poprawnie sie ustawia na 0, ale uzywajac scroola, przeskakuje w dzziwne miejsce
        for (var i = listviewID.first_value, index_tmp = 0 ; i <= listviewID.last_value; i++, index_tmp++)
        {

            if(modelID.get(index_tmp).itemID === listviewID.first_value)
            {
                listviewID.positionViewAtIndex(index_tmp, ListView.Center)
                if(listviewID.set_values_first_time === false)
                {
                    //Uzywane, gdy ustawia sie liste po razz pierwszy po uruchomieniu
                    listviewID.currentIndex = index_tmp-2
                }
                else
                {
                    //Uzywane, gdy uzywa sie funkcji set_values po raz drugi i kolejny podczas dzialania programu. Nie wiem, od czego to zalezy.
                    listviewID.currentIndex = index_tmp
                }
                break
            }
        }
        listviewID.set_values_first_time = true
    }

    function numberOfElements(a, b)
    {
        //Zwraca ilosc elementow, niezaleznie, czy pierwsza, lub ostatnia liczba jest dodatnia, lub ujemna
        return Math.abs(a-b) + 1
    }
}

