/***************************************************************************
 *   Copyright (C) 2014 by Eike Hein <hein@kde.org>                        *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0

import org.kde.plasma.plasmoid 2.0

import org.kde.plasma.private.folder 0.1 as Folder

Item {
    id: configExperimental

    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_pressToMove: pressToMove.checked
    property alias cfg_pressToHandle: pressToHandle.checked

    GroupBox {
        id: behaviorGroupBox

        visible: ("containmentType" in plasmoid)

        Layout.fillWidth: true

        title: "Behavior" /* Intentionally not i18n'd. */

        flat: true

        ColumnLayout {
            Layout.fillWidth: true

            CheckBox {
                id: pressToMove

                text: "Press and hold applets to move" /* Intentionally not i18n'd. */
            }

            CheckBox {
                anchors.left: parent.left
                anchors.leftMargin: 25

                id: pressToHandle

                enabled: pressToMove.checked

                text: "Press and hold to reveal handle" /* Intentionally not i18n'd. */
            }
        }
    }
}