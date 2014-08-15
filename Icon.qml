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

Widget {
    id: widget
    property string name
    property bool rotate: widget.name.match(/.*-rotate/) !== null

    property alias color: text.color
    property var size

    color: "transparent"

    width: text.width
    height: text.height

    mouseEnabled: false
    property bool shadow: false

    property var icons: {
        "power": "",
        "shopping-cart": "",
        "envelope-o": "",
        "grid": "",
        "check-circle": "",
        "check-square-o": "",
        "circle": "",
        "exclamation-triangle": "",
        "calendar": "",
        "github": "",
        "file": "",
        "clock": "",
        "bookmark-o": "",
        "user": "",
        "comments-o": "",
        "check": "",
        "ellipse-h": "",
        "ellipse-v": "",
        "save": "",
        "smile-o": "",
        "spinner": "",
        "square-o": "",
        "times": "",
        "times-circle": "",
        "plus": "",
        "bell-o": "",
        "bell": "",
        "chevron-left": "",
        "chevron-right": "",
        "chevron-down": "",
        "cog": "",
        "minus": "",
        "dashboard": "",
        "calendar-empty": "",
        "calendar": "",
        "bars":"",
        "inbox": "",
        "list": "",
        "long-list": "",
        "comment": "",
        "download": "",
        "tasks": "",
        "bug": "",
        "code-fork": "",
        "clock-o": "",
        "pencil-square-o":"",
        "check-square-o":"",
        "picture-o":"",
        "trash": "",
        "code": "",
        "users": "",
        "exchange": ""
    }

    property alias weight: text.font.weight

    FontLoader { id: fontAwesome; source: Qt.resolvedUrl("FontAwesome.otf") }

    Text {
        id: text
        anchors.centerIn: parent

        property string name: widget.name.match(/.*-rotate/) !== null ? widget.name.substring(0, widget.name.length - 7) : widget.name

        font.family: fontAwesome.name
        font.weight: Font.Light
        text: widget.icons.hasOwnProperty(name) ? widget.icons[name] : ""
        color: theme.textColor
        style: shadow ? Text.Raised : Text.Normal
        styleColor: Qt.rgba(0,0,0,0.5)
        font.pixelSize: units.fontSize(widget.size)

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        NumberAnimation on rotation {
            running: widget.rotate
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 1100
        }
    }
}