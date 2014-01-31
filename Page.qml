import QtQuick 2.0

Item {
    id: page
    anchors.fill: parent

    property var currentPage: parent.hasOwnProperty("selectedPage") ? parent.selectedPage : pageStack.currentPage
    visible: page.currentPage === page

    property string title
    property int count
    property bool closeable
    property bool show: true

    signal close

    property list<Item> leftWidgets: [
        Button {
            iconName: "bars"
            visible: drawer && drawer.visible
            selected: drawer.showing
            onClicked: drawer.toggle(page)
        }

    ]
    property list<Item> rightWidgets
    property Drawer drawer
}
