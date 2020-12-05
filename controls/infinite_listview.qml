import QtQuick 2.3
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQml 2.12

Item
//Window
{
    x: 0
    y: 0
    id: mainListView

    width: parent.width/3
    height: parent.height

    property color font_color: "black"

    //Zmienne uzywane w funkcji "setNumberOfVisibleElements".
    //Nie dało się dostac bezposrednio do parametrow obiektu dziecka,
    //wiec trzeba bylo stworzyc te zmienne i dopiero te zmienne mozna bylo przypisac do parametrow obiektu dziecka.
    //Modyfikujac te parametry, modyfikuje sie parametry znajdujace sie w obiekcie dziecka
    property int delegate_height: listviewID.height/3
    property var preferredHighlightBegin: mainListView.height/3
    property var preferredHighlightEnd: mainListView.height/3

    signal signal_value_changed(int itemID, string number, int current_index)

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
//            height: listviewID.height/3     //Tu zmienic na "listviewID.height", zeby byl jeden wiersz, listviewID.height/3 - 3 wiersze, listviewID.height/7 - 7 wierszy (currentitem nie jest na srodku)
            height: delegate_height
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
                color: font_color
            }
        }
    }

    ListView
    {
        id: listviewID

        snapMode: ListView.SnapToItem

        property var first_value: 0
        property var last_value: 99
        property var fill_length_value: 2
        property var fill_sign_value: '0'

        property var gradient_color: 'gray'
        property var border_size: 1

        property int how_many_times_lists_repeated: 10      //Ile razy ma byc zduplikowana lista z elementami listy. uzywane do plynniejszego przewijania list, ktore zawieraja mala ailosc elementow.

        width: parent.width
        height: parent.height

        //Ucina listview do konkretnego rozmiaru. PRzydatne, gdy uzyje sie opcji preferredHighlightBegin i preferredHighlightEnd
        clip: true

        //Ustawia ilosc widocznego listview na poczatku i na koncu. To jest dodatkowa przestrzen widoczna. PRzydaje sie, zeby elementy plynnie pojawialy sie i znikaly Dane podawane w pikselach.
        preferredHighlightBegin: mainListView.preferredHighlightBegin
        preferredHighlightEnd: mainListView.preferredHighlightEnd
        highlightRangeMode: ListView.StrictlyEnforceRange
        cacheBuffer: delegate_height*2

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
            border.width: 0
        }

        Rectangle
        {
            anchors.fill: parent
            border.width: listviewID.border_size
            gradient: Gradient
            {
                GradientStop { position: 0.0; color: listviewID.gradient_color }
                GradientStop { position: 0.33; color: "transparent" }
                GradientStop { position: 0.66; color: "transparent" }
                GradientStop { position: 1.0; color: listviewID.gradient_color }
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onWheel:
            {
                listviewID.set_values_first_time = false
                //Kod odpowiadajacy za nieskoczone przewijanie przy uzyciu scroola myszy
                if (wheel.angleDelta.y < 0)
                {
                    var curr_index_tmp = listviewID.currentIndex
                    if(listviewID.currentIndex > (modelID.count/2))
                    {
                        modelID.move(0, modelID.count - 1, 1)
//                        modelID.move(0, modelID.count - 1, 1)
//                        modelID.move(0, modelID.count - 1, 1)
//                        modelID.move(0, modelID.count - 1, 1)
//                        modelID.move(0, modelID.count - 1, 1)
                        listviewID.currentIndex = curr_index_tmp-1
                    }
                    listviewID.incrementCurrentIndex()
                }
                else if (wheel.angleDelta.y > 0)
                {
                    var curr_index_tmp = listviewID.currentIndex
                    if(listviewID.currentIndex < (modelID.count/2))
                    {
                        modelID.move(modelID.count - 1, 0, 1)
//                        modelID.move(modelID.count - 1, 0, 1)
//                        modelID.move(modelID.count - 1, 0, 1)
//                        modelID.move(modelID.count - 1, 0, 1)
//                        modelID.move(modelID.count - 1, 0, 1)
                        listviewID.currentIndex = curr_index_tmp+1
                    }
                    listviewID.decrementCurrentIndex()
                }
                listviewID.set_values_first_time = true
            }

        }

        onCurrentItemChanged:
        {
            mainListView.signal_value_changed(modelID.get(listviewID.currentIndex).itemID, modelID.get(listviewID.currentIndex).number, listviewID.currentIndex)

            if(listviewID.set_values_first_time === true)
            {
                var current_index_at_top = indexAt(1, contentY)
                if(current_index_at_top < (modelID.count/2))
                {
                    modelID.move(modelID.count - 1, 0, 1)
                    modelID.move(modelID.count - 1, 0, 1)
                    modelID.move(modelID.count - 1, 0, 1)
                    modelID.move(modelID.count - 1, 0, 1)
                }

                var current_index_at_bottom = indexAt(1, (contentY+height)-1)
                if(current_index_at_bottom > (modelID.count/2))
                {
                    modelID.move(0, modelID.count - 1, 1)
                    modelID.move(0, modelID.count - 1, 1)
                    modelID.move(0, modelID.count - 1, 1)
                    modelID.move(0, modelID.count - 1, 1)
                }
            }
        }

        Component.onCompleted:
        {
        }

    }

    function setValues(first = 0, last = 59, fill_length = 2, fill_value = '0')
    {
        listviewID.set_values_first_time = false

        listviewID.first_value = Number(first)
        listviewID.last_value = Number(last)
        listviewID.fill_length_value = Number(fill_length)
        listviewID.fill_sign_value = fill_value

        if (listviewID.first_value > listviewID.last_value)
        {
            //Pierwsza wartosc musi byc wieksza, niz zdruga
            modelID.clear()
            modelID.append( {"itemID": 0, "number": "ERROR: 1"} )
            return -1
        }
        else if ( numberOfElements( listviewID.first_value, listviewID.last_value) <= 2)
        {
            //Ilosc elementow miedzy pierwszym, a ostatnim elementem musi byc min 3 elementy, zeby wszystkie pola byly zajete w liscie
            modelID.clear()
            modelID.append( {"itemID": 0, "number": "ERROR: 2"} )
            return -2
        }

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

        //Ile razy ma byc powtorzona lista.
        //Dodanie wiekszej ilosci razy tej samej listy skutkuje plynniejszym przewijaniem listy przy mniejszej ilosci elementow w liscie
        for(var how_many_times_lists_repeated_tmp = 0 ; how_many_times_lists_repeated_tmp < listviewID.how_many_times_lists_repeated ; how_many_times_lists_repeated_tmp++)
        {
            //Dodawania elementow do listy
            for (var index_tmp = listviewID.last_value - half1, i = listviewID.first_value ; i <= listviewID.last_value; i++, index_tmp++)
            {
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
        }



        var index_how_many_times_lists_repeated_half = 0
        listviewID.currentIndex = -1    //Z tym ustaiwniem, poprawnie sie ustawia na 0, ale uzywajac scroola, przeskakuje w dzziwne miejsce
        for (var i = listviewID.first_value, index_tmp = 0 ; i <= listviewID.last_value+modelID.count; i++, index_tmp++)
        {
            if(modelID.get(index_tmp).itemID === listviewID.first_value)
            {
                if(index_how_many_times_lists_repeated_half > listviewID.how_many_times_lists_repeated/2)
//                {

//                }
//                else
                {
                    listviewID.positionViewAtIndex(index_tmp, ListView.Center)
                    listviewID.currentIndex = index_tmp
                    break
                }
                index_how_many_times_lists_repeated_half++

            }
        }
        listviewID.set_values_first_time = true

        return 0
    }

    function numberOfElements(a, b)
    {
        //Zwraca ilosc elementow, niezaleznie, czy pierwsza, lub ostatnia liczba jest dodatnia, lub ujemna
        return Math.abs(a-b) + 1
    }

    function getValue()
    {
        return modelID.get(listviewID.currentIndex).number
    }

    function setGradientColor(color = 'gray')
    {
        listviewID.gradient_color = color
    }

    function setBorderSize(size = 1)
    {
        listviewID.border_size = size
    }

    function setValue(value = 0)
    {
        if(value >= listviewID.first_value && value <= listviewID.last_value)
        {
            for (var i = listviewID.first_value, index_tmp = 0 ; i <= listviewID.last_value; i++, index_tmp++)
            {
                if(modelID.get(index_tmp).itemID === Number(value))
                {
                    listviewID.currentIndex = index_tmp
                    break
                }
            }
        }
    }

    function setCustomValue(value = ":")
    {
        modelID.clear()
        modelID.append( {"itemID": 0, "number": value} )
    }

    function setFontColor(font_color = "black")
    {
        mainListView.font_color = font_color
    }

    function setNumberOfVisibleElements(numberOfVisibleElements = 3)
    {
        //Funkcja umozliwiajacy wybor ilosci wierszy w liscie. Dostepne sa opcje 1 i 3 wiersze
        if(numberOfVisibleElements === 3)
        {
            mainListView.delegate_height = Qt.binding(() => listviewID.height/3)
            mainListView.preferredHighlightBegin = Qt.binding(() => mainListView.height/3)
            mainListView.preferredHighlightEnd = Qt.binding(() => mainListView.height/3)
        }
        else if(numberOfVisibleElements === 1)
        {
            mainListView.delegate_height = Qt.binding(() => listviewID.height/1)
            mainListView.preferredHighlightBegin = Qt.binding(() => 0)
            mainListView.preferredHighlightEnd = Qt.binding(() => mainListView.height)
        }
    }

    function setSize(width, height)
    {
        mainListView.width = Qt.binding(() => width)
        mainListView.height = Qt.binding(() => height)
    }

    function setPosition(x, y)
    {
        mainListView.x = Qt.binding(() => x)
        mainListView.y = Qt.binding(() => y)
    }

    onSignal_value_changed:
    {
        console.log(itemID + " : " + number + " : " + current_index)
    }
}

