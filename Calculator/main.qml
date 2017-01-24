import QtQuick 2.5
import QtQuick.Controls 2.0
import "Components"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("PERPHeads Calculator")
    property int tax:25
    property int valueWithTax

    footer: Item {
        width: parent.width
        height: 66
        Rectangle {
            id: footerRect
            width: parent.width
            height: 66
            color: "#607D8B"
            Row {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8
                x: 35
                TextField {
                    width: 100
                    id: field
                    text: Number(root.tax)
                }

                Button {
                    text: "Set Tax"
                    onClicked: {
                        root.tax = Number(field.text)
                        koszykModel.clear()
                        root.valueWithTax = 0
                    }
                }
                ComboBox {
                    x: listView.x
                      model: ListModel {
                          ListElement { key: "Materials";}
                      }
                  }

            }
            Row {
                spacing: 8
                anchors.right: parent.right
                anchors.rightMargin: 26
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    color: "#ffffff"
                    text: "Price: "
                    font.pointSize: 13
                }
                Text{
                    id: priceLabel
                    color: "#fffbfb"
                    text: valueWithTax
                    font.pointSize: 13
                }
                Row {
                    spacing: 2
                Text{
                    color: "#ffffff"
                    text: "(with "
                    font.pointSize: 13
                }
                Text{
                    color: "#ffffff"
                    text: root.tax
                    font.pointSize: 13
                }
                Text{
                    color: "#ffffff"
                    text: "% tax)"
                    font.pointSize: 13
                }
                }
            }

        }
    }
    ListModel {
        id: koszykModel
    }
    ListModel {
        id: materialsModel
        ListElement {name: "Wrench"; price: 250 }
        ListElement {name: "Paint Bucket"; price: 60 }
        ListElement { name: "Metal Rod"; price: 500}
        ListElement { name: "Wooden Board"; price: 400 }
        ListElement { name: "Metal Polish"; price: 50 }
        ListElement { name: "Brass Bulk"; price: 100 }
        ListElement { name: "Glass Shard"; price: 550 }
        ListElement { name: "Chunk of Plastic"; price: 200 }
        ListElement { name: "Hunk of Polymer"; price: 100 }
        ListElement { name: "Piece of Metal"; price: 500 }
        ListElement { name: "Cardboard box"; price: 150 }
        ListElement { name: "Propane Tank"; price: 1500 }
        ListElement { name: "Lodine"; price: 200 }
        ListElement { name: "Saw-Horse"; price: 750 }
        ListElement { name: "Glue"; price: 125 }
        ListElement { name: "Wood Nails"; price: 100 }
        ListElement { name: "Box of Springs"; price: 50 }
        ListElement { name: "Electronics"; price: 300 }
        ListElement { name: "Gun Powder"; price: 100 }
        ListElement { name: "Cinder Blocks"; price: 500 }
        ListElement { name: "Ref Metal 25%"; price: 675 }
        ListElement { name: "Ref Metal 50%"; price: 2070 }
        ListElement { name: "Ref Metal 75%"; price: 3900 }
        ListElement { name: "Ref Metal 100%"; price: 7675 }
        ListElement { name: "Gun Powder"; price: 100 }
        ListElement { name: "Paper Towels"; price: 130 }
    }
    Row {
        id: fRow
        height: 35
        x: 35

    }
    Row {
        y: 50
        x: 15
        width: parent.width-60
        height: parent.height-70
        spacing: (parent.width-(160*2))-8
        ListView {
            id: listView
            width: 160
            height: parent.height
            model: materialsModel
            property int indexNumber: 0
            delegate: Element {
                text: name
                onClicked:{
                    koszykModel.append({"name": name, "price": Number(price), "index": parent.indexNumber})
                    root.valueWithTax += price * ((root.tax/100)+1)
                    parent.indexNumber += 1;
                    console.log(price)
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
        ListView {
            id: viv
            width: 160
            height: parent.height
            model: koszykModel

            delegate: Element {
                text: name
                value: price
                onClicked: {
                    koszykModel.remove(index)
                    root.valueWithTax -= value * ((root.tax/100)+1)
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
}
