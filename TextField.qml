/*
 * QML Air - A lightweight and mostly flat UI widget collection for QML
 * Copyright (C) 2014 Michael Spencer
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "ListItems" as ListItem

Widget {
    id: textField

    signal triggered

    //----- STYLE PROPERTIES -----//

    property color textColor: styleObject[style].textColor
    property color background: styleObject[style].background
    property color borderColor: style === "default" ? "#ccc" : Qt.darker(background, 1.2)
    property color borderColor_focus: style === "default" ? "#66afe9" : Qt.darker(background, 1.4)
    radius: units.gu(0.5)

    height: hidden ? edit.height : units.gu(4)
    width: units.gu(30)

    property var fontSize: "medium"

    //

    property var styleObject: {
            "default": {
                "background": "#fafafa",
                "border": "#ccc",
                "border_focus": "#66afe9",
                "textColor": theme.textColor,
                "placeholderColor": "lightgray",
                "height": "4gu",
                "width": "30gu",
                "radius": "0.5gu"
            },
            "success": {
                "textColor": "#468847",
                "background": "#dff0d8",
                "border": "$darker @background 1.2",
                "border_focus": "$darker @background 1.4"
            },
            "danger": {
                "textColor": "#b94a48",
                "background": "#f2dede",
                "border": "$darker @background 1.2",
                "border_focus": "$darker @background 1.4"
            },
            "warning": {
                "textColor": "#c09853",
                "background": "#fcf8e3",
                "border": "$darker @background 1.2",
                "border_focus": "$darker @background 1.4"
            },
            "info": {
                "textColor": "#3a87ad",
                "background": "#d9edf7",
                "border": "$darker @background 1.2",
                "border_focus": "$darker @background 1.4"
            }
        }

    function forceActiveFocus() {
        edit.forceActiveFocus()
    }

    property bool editing: edit.focus
    color: "transparent"

    RectangularGlow {
        id: glowEffect

        visible: !hidden
        opacity: editing ? 0.3 : 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        anchors.fill: parent
        glowRadius: units.gu(0.5)
        color: rect.border.color
    }

    property bool hidden: false

    Rectangle {
        id: rect
        anchors.fill: parent
        visible: !hidden

        radius: textField.radius

        border.color: editing ? borderColor_focus : borderColor
        color: background

        property bool editing: edit.focus

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    property alias text: edit.text
    property alias font: edit.font
    property alias placeholderText: placeholderLabel.text
    property alias validator: edit.validator
    property alias acceptableInput: edit.acceptableInput
    property bool hiddenEditing: false
    property alias echoMode: edit.echoMode

    Label {
        id: placeholderLabel
        opacity: 0.5
        visible: textField.text.length === 0

        color: textColor

        anchors {
            left: parent.left
            leftMargin: hidden ? units.gu(0.5) : units.gu(1)
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: units.gu(0.1)
        }
    }

    TextInput {
        id: edit
        clip: true
        color: textColor

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: hidden ? units.gu(0.5) : units.gu(1)
        }

        font.pixelSize: units.fontSize(fontSize)

        selectionColor: borderColor_focus
        selectByMouse: true

        onAccepted: triggered()
    }
}