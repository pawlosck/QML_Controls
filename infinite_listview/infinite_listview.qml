import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQml 2.12

//Item
Window
{
    width: 100
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
            height: 20
            width: 30

            Text
            {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                height: 20
                width: 30
                text: number
            }
        }
    }

    ListView
    {
        id: listviewID

        width: 30
        height: 60

        preferredHighlightBegin: 20
        preferredHighlightEnd: 40
        highlightRangeMode: ListView.StrictlyEnforceRange

        highlightMoveDuration: 1000
        highlightMoveVelocity: -1

        model: modelID
        delegate: delegateID

        Rectangle
        {
            x: 0
            y: 20
            width: 30
            height: 20
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
    }

    function setValues(first=0, last=59, fill_number=2, fill_value='0')
    {
        for (var i = first; i <= last; i++)
        {
            modelID.append( {"itemID": i, "number": i.toString().padStart(fill_number, fill_value)} )
        }
    }

    function setStartIndex(startIndex=0)
    {
        listviewID.positionViewAtIndex(startIndex, ListView.Center)
    }
}

