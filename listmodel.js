.import QtQuick 2.0 as QtQuick

function searchFunction(searchText, originalModel) {
    for (var i = 0; i < originalModel.count; i++) {
        var item = originalModel.get(i);
        item.visible = item.title.toLowerCase().includes(searchText.toLowerCase());
    }
}











