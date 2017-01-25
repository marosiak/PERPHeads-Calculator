import QtQuick 2.5
import QtQuick.Controls 2.0
import "Components"
import "Models"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("PERPHeads Calculator")
    property int tax:25
    property int valueWithTax

    Ammo        {id: ammoModel}
    Materials   {id: materialsModel}
    Pistols     {id: pistolsModel}
    Shotguns    {id: shotgunsModel}

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
                          ListElement { key: "Ammo";}
                          ListElement { key: "Pistols";}
                          ListElement { key: "Shotguns";}
                      }
                      onHighlighted: {
                          switch(index) {
                          case 0:
                              listView.model = materialsModel
                              break;
                          case 1:
                              listView.model = ammoModel
                              break;
                          case 2:
                              listView.model = pistolsModel
                              break;
                          case 3:
                              listView.model = shotgunsModel
                              break;
                          }
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
                    if(root.valueWithTax < 0) {
                        root.valueWithTax = 0
                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
}
