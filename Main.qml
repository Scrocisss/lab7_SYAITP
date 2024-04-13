import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels
import ListModel 0.1
import "listmodel.js" as ListModel
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Органайзер задач")
    Popup {
            id: addForm
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
            anchors.centerIn: Overlay.overlay
            width: 250
            height: 500

            ColumnLayout {
                Text {
                    text: "Название:"
                    font.bold: true
                    font.pixelSize: 16
                    color: "steelblue"
                }
                TextField {
                    id: addFormTitleField
                    placeholderText: "Введите название"
                    Layout.fillWidth: true
                }

                Text {
                    text: "Описание:"
                    font.bold: true
                    font.pixelSize: 16
                    color: "steelblue"
                    anchors.topMargin: 10
                }
                TextField {
                    id: addFormDescrField
                    placeholderText: "Введите описание"
                    Layout.fillWidth: true
                }

                Text {
                    text: "Дата:"
                    font.bold: true
                    font.pixelSize: 16
                    color: "steelblue"
                    anchors.topMargin: 10
                }
                ColumnLayout {
                    RowLayout {
                        Button {
                            text: '<'

                            width: 80
                            height: 25
                            Layout.fillWidth: true
                            onClicked: {

                                switch (gridm.month) {
                                    case Calendar.January:
                                        gridm.month = Calendar.December
                                        gridm.year = gridm.year - 1;
                                        break;
                                    case Calendar.February:
                                        gridm.month = Calendar.January
                                        break;
                                    case Calendar.March:
                                        gridm.month = Calendar.February
                                        break;
                                    case Calendar.April:
                                        gridm.month = Calendar.March
                                        break;
                                    case Calendar.May:
                                        gridm.month = Calendar.April
                                        break;
                                    case Calendar.June:
                                        gridm.month = Calendar.May
                                        break;
                                    case Calendar.July:
                                        gridm.month = Calendar.June
                                        break;
                                    case Calendar.August:
                                        gridm.month = Calendar.July
                                        break;
                                    case Calendar.September:
                                        gridm.month = Calendar.August
                                        break;
                                    case Calendar.October:
                                        gridm.month = Calendar.September
                                        break;
                                    case Calendar.November:
                                        gridm.month = Calendar.October
                                        break;
                                    case Calendar.December:
                                        gridm.month = Calendar.November
                                        break;
                                }
                                curText.text = gridm.month + 1 < 10 ? "0"+(gridm.month + 1) + "." + gridm.year : (gridm.month + 1) + "." + gridm.year;
                            }
                        }
                        Text {
                            id: curText
                            text: gridm.month + 1 < 10 ? "0"+(gridm.month + 1) + "." + gridm.year : (gridm.month + 1) + "." + gridm.year;
                            width: 80
                            height: 25
                            Layout.fillWidth: true
                        }
                        Button {
                            text: '>'

                            width: 80
                            height: 25
                            Layout.fillWidth: true
                            onClicked: {
                                switch (gridm.month) {
                                    case Calendar.January:
                                        gridm.month = Calendar.February
                                        break;
                                    case Calendar.February:
                                        gridm.month = Calendar.March
                                        break;
                                    case Calendar.March:
                                        gridm.month = Calendar.April
                                        break;
                                    case Calendar.April:
                                        gridm.month = Calendar.May
                                        break;
                                    case Calendar.May:
                                        gridm.month = Calendar.June
                                        break;
                                    case Calendar.June:
                                        gridm.month = Calendar.July
                                        break;
                                    case Calendar.July:
                                        gridm.month = Calendar.August
                                        break;
                                    case Calendar.August:
                                        gridm.month = Calendar.September
                                        break;
                                    case Calendar.September:
                                        gridm.month = Calendar.October
                                        break;
                                    case Calendar.October:
                                        gridm.month = Calendar.November
                                        break;
                                    case Calendar.November:
                                        gridm.month = Calendar.December
                                        break;
                                    case Calendar.December:
                                        gridm.month = Calendar.January
                                        gridm.year = gridm.year + 1;
                                        break;
                                }
                                curText.text = gridm.month + 1 < 10 ? "0"+(gridm.month + 1) + "." + gridm.year : (gridm.month + 1) + "." + gridm.year;
                            }
                        }
                    }

                    DayOfWeekRow {
                        locale: gridm.locale
                        Layout.fillWidth: true
                    }

                    MonthGrid {
                        id: gridm
                        month: Calendar.January
                        year: 2024
                        locale: Qt.locale("ru_RU")
                        Layout.fillWidth: true
                        property date selectedDate
                        onClicked: (date) => {
                                        console.log("date clicked is " + date)
                                        gridm.selectedDate = date
                                        selDate.text = "Выбранная дата: " + gridm.selectedDate.toLocaleDateString('ru-RU')
                                       }
                        delegate: Text {
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: model.day
                            font: control.font
                            //color: gridm.selectedDate == model.date ? 'blue' : 'black'
                        }

                    }

                    Text {
                        id: selDate
                        text: "Выбранная дата: нет"
                        font.bold: true
                        font.pixelSize: 16
                        color: "#333"  // изменение цвета текста
                    }

                    Button {
                        id: addFormAddButton
                        text: 'Добавить'
                        width: 100
                        height: 30
                        font.bold: true
                       Layout.fillWidth: true
                        onClicked: {
                            var date = gridm.selectedDate.getDate() + "." + (gridm.selectedDate.getMonth() + 1 < 10 ? "0"+(gridm.selectedDate.getMonth() + 1) : (gridm.selectedDate.getMonth() + 1)) + "." + gridm.selectedDate.getFullYear()
                            sqlitedatabase.insertIntoTable(addFormTitleField.text, addFormDescrField.text, date);
                            tableView.model.updateModel();
                        }
                        background: Rectangle {
                            color: "#0077CC"  // изменение цвета фона
                            radius: 5
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Button {
                        text: 'Закрыть'
                        id: rejectButton
                        width: 100
                        height: 30
                        Layout.fillWidth: true
                        onClicked: {
                            addForm.close()
                        }
                        background: Rectangle {
                            color: "#CC0000"  // изменение цвета фона
                            radius: 5
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }



                }

            }
        }


    Popup {
            id: editForm
            property int note_id
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
            anchors.centerIn: Overlay.overlay
            width: 250
            height: 500

            ColumnLayout {
                Text {
                    text: "Название:"
                    font.bold: true
                    font.pixelSize: 16
                                        color: "steelblue"
                }

                TextField {
                    id: editFormTitleField
                    placeholderText: "Введите название"
                    width: parent.width
                    height: 30
                    font.pixelSize: 14
                    background: Rectangle {
                        color: "#f2f2f2"
                        radius: 5
                    }
                    verticalAlignment: TextInput.AlignVCenter
                    onFocusChanged: {
                        if (focus) cursorPosition = text.length
                    }
                }

                Text {
                    text: "Описание:"
                    font.bold: true
                    font.pixelSize: 16
                                        color: "steelblue"
                    anchors.top: editFormTitleField.bottom
                }

                TextField {
                    id: editFormDescrField
                    placeholderText: "Введите описание"
                    width: parent.width
                    height: 50
                    font.pixelSize: 14
                    background: Rectangle {
                        color: "#f2f2f2"
                        radius: 5
                    }
                    wrapMode: TextEdit.Wrap
                }

                Text {
                    text: "Дата:"
                    font.bold: true
                    font.pixelSize: 16
                                        color: "steelblue"
                    anchors.top: editFormDescrField.bottom
                }



                ColumnLayout {
                    RowLayout {
                        Button {
                            text: '<'

                            width: 80
                            height: 25
                            Layout.fillWidth: true
                            onClicked: {

                                switch (gridmed.month) {
                                    case Calendar.January:
                                        gridm.month = Calendar.December
                                        gridmed.year = gridmed.year - 1;
                                        break;
                                    case Calendar.February:
                                        gridmed.month = Calendar.January
                                        break;
                                    case Calendar.March:
                                        gridmed.month = Calendar.February
                                        break;
                                    case Calendar.April:
                                        gridmed.month = Calendar.March
                                        break;
                                    case Calendar.May:
                                        gridmed.month = Calendar.April
                                        break;
                                    case Calendar.June:
                                        gridmed.month = Calendar.May
                                        break;
                                    case Calendar.July:
                                        gridmed.month = Calendar.June
                                        break;
                                    case Calendar.August:
                                        gridmed.month = Calendar.July
                                        break;
                                    case Calendar.September:
                                        gridmed.month = Calendar.August
                                        break;
                                    case Calendar.October:
                                        gridmed.month = Calendar.September
                                        break;
                                    case Calendar.November:
                                        gridmed.month = Calendar.October
                                        break;
                                    case Calendar.December:
                                        gridmed.month = Calendar.November
                                        break;
                                }
                                curTextEdit.text = gridmed.month + 1 < 10 ? "0"+(gridmed.month + 1) + "." + gridmed.year : (gridmed.month + 1) + "." + gridmed.year;
                            }
                        }
                        Text {
                            id: curTextEdit
                            text: gridm.month + 1 < 10 ? "0"+(gridmed.month + 1) + "." + gridmed.year : (gridmed.month + 1) + "." + gridmed.year;
                            width: 80
                            height: 25
                            Layout.fillWidth: true
                        }
                        Button {
                            text: '>'
                            width: 80
                            height: 25
                            Layout.fillWidth: true
                            onClicked: {
                                switch (gridmed.month) {
                                    case Calendar.January:
                                        gridmed.month = Calendar.February
                                        break;
                                    case Calendar.February:
                                        gridmed.month = Calendar.March
                                        break;
                                    case Calendar.March:
                                        gridmed.month = Calendar.April
                                        break;
                                    case Calendar.April:
                                        gridmed.month = Calendar.May
                                        break;
                                    case Calendar.May:
                                        gridmed.month = Calendar.June
                                        break;
                                    case Calendar.June:
                                        gridmed.month = Calendar.July
                                        break;
                                    case Calendar.July:
                                        gridm.month = Calendar.August
                                        gridmed;
                                    case Calendar.August:
                                        gridmed.month = Calendar.September
                                        break;
                                    case Calendar.September:
                                        gridmed.month = Calendar.October
                                        break;
                                    case Calendar.October:
                                        gridmed.month = Calendar.November
                                        break;
                                    case Calendar.November:
                                        gridmed.month = Calendar.December
                                        break;
                                    case Calendar.December:
                                        gridmed.month = Calendar.January
                                        gridmed.year = gridmed.year + 1;
                                        break;
                                }
                                curTextEdit.text = gridmed.month + 1 < 10 ? "0"+(gridmed.month + 1) + "." + gridmed.year : (gridmed.month + 1) + "." + gridmed.year;
                            }
                        }
                    }
                    DayOfWeekRow {
                        locale: gridmed.locale
                        Layout.fillWidth: true
                    }
                    MonthGrid {
                        id: gridmed
                        month: Calendar.January
                        year: 2024
                        locale: Qt.locale("ru_RU")
                        Layout.fillWidth: true
                        property date selectedDate
                        onClicked: (date) => {
                                        console.log("date clicked is " + date)
                                        gridmed.selectedDate = date
                                        selDateEdit.text = "Выбранная дата: " + gridmed.selectedDate.toLocaleDateString('ru-RU')
                                       }
                        delegate: Text {
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: model.day
                            font: control.font
                        }

                    }

                    Text {
                        id: selDateEdit
                        text: "Выбранная дата: нет"
                        color: "red"
                    }
                    Button {
                        text: 'Изменить'
                        id: editFormAddButton
                        width: 80
                        height: 25
                        Layout.fillWidth: true
                        onClicked: {
                            var date = gridmed.selectedDate.getDate() + "." + (gridmed.selectedDate.getMonth() + 1 < 10 ? "0" + (gridmed.selectedDate.getMonth() + 1) : (gridmed.selectedDate.getMonth() + 1)) + "." + gridmed.selectedDate.getFullYear()
                            sqlitedatabase.updateRecord(editForm.note_id, editFormTitleField.text, editFormDescrField.text, date);
                            tableView.model.updateModel();
                        }
                        background: Rectangle {
                            color: "#387EEA" // цвет фона кнопки
                            radius: height / 2 // делаем углы круглыми
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.bold: true
                            anchors.centerIn: parent
                        }
                    }

                    Button {
                        text: 'Закрыть'
                        id: rejectButtonEditForm
                        width: 80
                        height: 25
                        Layout.fillWidth: true
                        onClicked: {
                            editForm.close()
                        }
                        background: Rectangle {
                            color: "#E53935" // цвет фона кнопки
                            radius: height / 2 // делаем углы круглыми
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.bold: true
                            anchors.centerIn: parent
                        }
                    }


                }

            }
        }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        RowLayout {
            TextField {
                id: searchField
                width: 200
                height: 25
                placeholderText: "Введите текст для поиска..."
                onTextChanged: {
                    filteredModel.clear();
                    for (var i = 0; i < listModel.count; i++) {
                        var item = listModel.get(i);
                        if (item.title.toLowerCase().includes(text.toLowerCase())) {
                            filteredModel.append(item);
                        }
                    }
                }
            }

                Button {
                            text: 'Добавить'
                            id: addButton
                            width: 80
                            height: 25
                            Layout.fillWidth: true
                            onClicked: {
                                addForm.open();
                            }
                            background: Rectangle {
                                color: "#4CAF50" // зеленый цвет фона кнопки
                                radius: 12 // делаем углы круглыми
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                Button {
                            text: 'Изменить'
                            id: editButton
                            width: 80
                            height: 25
                            Layout.fillWidth: true
                            onClicked: {
                                if (tableView.selectedId != -1){
                                    editForm.note_id = tableView.selectedId
                                    editForm.open();
                                } else {
                                    console.log('sdf');
                                }
                            }
                            background: Rectangle {
                                color: "#FFC107" // оранжевый цвет фона кнопки
                                radius: 12
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                Button {
                    text: 'Удалить'
                    id: delButton
                    width: 80
                    height: 25
                    Layout.fillWidth: true
                    onClicked: {
                        if (tableView.selectedId != -1){
                            sqlitedatabase.removeRecord(tableView.selectedId);
                            tableView.selectedRow = -1
                            tableView.selectedId = -1
                            tableView.model.updateModel();
                        } else {
                            console.log('sdf');
                        }
                    }
                    background: Rectangle {
                        color: "#E91E63" // цвет фона кнопки
                        radius: height / 2 // делаем углы круглыми
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            HorizontalHeaderView {
                id: horizontalHeader
                anchors.left: tableView.left
                syncView: tableView
                clip: true
                model: ["Идентификатор","Название","Описание","Дата"]
            }
            TableView {
                    id: tableView
                    anchors.left: parent.left
                    anchors.top: horizontalHeader.bottom
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    clip: true
                    property int selectedRow: -1
                    property int selectedId: -1
                    model: ListModel {
                        id: listModel
                    }
                selectionModel: ItemSelectionModel {
                    model: listModel
                }
                columnWidthProvider: function () { return parent.width/4}
                delegate: ItemDelegate {
visible: model.title.toLowerCase().includes(searchField.text.toLowerCase())
                    highlighted: tableView.selectedRow != -1 && row == tableView.selectedRow
                    onClicked: {tableView.selectedRow = row; tableView.selectedId = id}
                    text: column == 0 ? id : column == 1 ? title : column == 2 ? descr : date
                    background: Rectangle {
                                    color: highlighted ? palette.light : palette.window
                                }
                    palette.light: "skyblue"
                    palette.highlightedText: "black"
                    palette.text: "black"
                    palette.window: "lightgrey"
                }
            }
    }
    function getDate(){
        return gridm.selectedDate;
    }

    Component.onCompleted: {
    }
}
