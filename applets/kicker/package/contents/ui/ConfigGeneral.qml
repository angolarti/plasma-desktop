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
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

import org.kde.plasma.private.kicker 0.1 as Kicker

Item {
    id: configGeneral

    width: childrenRect.width
    height: childrenRect.height

    property bool isDash: (plasmoid.pluginName == "org.kde.plasma.kickerdash")

    property string cfg_icon: plasmoid.configuration.icon
    property bool cfg_useCustomButtonImage: plasmoid.configuration.useCustomButtonImage
    property string cfg_customButtonImage: plasmoid.configuration.customButtonImage

    property alias cfg_appNameFormat: appNameFormat.currentIndex
    property alias cfg_limitDepth: limitDepth.checked
    property alias cfg_alphaSort: alphaSort.checked

    property alias cfg_recentOrdering: recentOrdering.currentIndex
    property alias cfg_showRecentApps: showRecentApps.checked
    property alias cfg_showRecentDocs: showRecentDocs.checked
    property alias cfg_showRecentContacts: showRecentContacts.checked

    property alias cfg_useExtraRunners: useExtraRunners.checked
    property alias cfg_alignResultsToBottom: alignResultsToBottom.checked

    ColumnLayout {
        anchors.left: parent.left

        RowLayout {
            spacing: units.smallSpacing

            Label {
                text: i18n("Icon:")
            }

            Button {
                id: iconButton
                Layout.minimumWidth: previewFrame.width + units.smallSpacing * 2
                Layout.maximumWidth: Layout.minimumWidth
                Layout.minimumHeight: previewFrame.height + units.smallSpacing * 2
                Layout.maximumHeight: Layout.minimumWidth

                KQuickAddons.IconDialog {
                    id: iconDialog
                    onIconNameChanged: {
                        cfg_customButtonImage = iconName || cfg_icon || "start-here-kde"
                        cfg_useCustomButtonImage = true;
                    }
                }

                // just to provide some visual feedback, cannot have checked without checkable enabled
                checkable: true
                onClicked: {
                    checked = Qt.binding(function() { // never actually allow it being checked
                        return iconMenu.status === PlasmaComponents.DialogStatus.Open
                    })

                    iconMenu.open(0, height)
                }

                PlasmaCore.FrameSvgItem {
                    id: previewFrame
                    anchors.centerIn: parent
                    imagePath: plasmoid.location === PlasmaCore.Types.Vertical || plasmoid.location === PlasmaCore.Types.Horizontal
                            ? "widgets/panel-background" : "widgets/background"
                    width: units.iconSizes.large + fixedMargins.left + fixedMargins.right
                    height: units.iconSizes.large + fixedMargins.top + fixedMargins.bottom

                    PlasmaCore.IconItem {
                        anchors.centerIn: parent
                        width: units.iconSizes.large
                        height: width
                        source: cfg_useCustomButtonImage ? cfg_customButtonImage : cfg_icon
                    }
                }
            }

            // QQC Menu can only be opened at cursor position, not a random one
            PlasmaComponents.ContextMenu {
                id: iconMenu
                visualParent: iconButton

                PlasmaComponents.MenuItem {
                    text: i18nc("@item:inmenu Open icon chooser dialog", "Choose...")
                    icon: "document-open-folder"
                    onClicked: iconDialog.open()
                }
                PlasmaComponents.MenuItem {
                    text: i18nc("@item:inmenu Reset icon to default", "Clear Icon")
                    icon: "edit-clear"
                    onClicked: {
                        cfg_useCustomButtonImage = false;
                    }
                }
            }
        }

        GroupBox {
            Layout.fillWidth: true

            title: i18n("Behavior")

            flat: true

            ColumnLayout {
                RowLayout {
                    Label {
                        text: i18n("Show applications as:")
                    }

                    ComboBox {
                        id: appNameFormat

                        Layout.fillWidth: true

                        model: [i18n("Name only"), i18n("Description only"), i18n("Name (Description)"), i18n("Description (Name)")]
                    }
                }

                CheckBox {
                    id: limitDepth

                    visible: !isDash

                    text: i18n("Flatten menu to a single level")
                }

                CheckBox {
                    id: alphaSort

                    text: i18n("Sort alphabetically")
                }
            }
        }

        GroupBox {
            Layout.fillWidth: true

            title: i18n("Categories")

            flat: true

            ColumnLayout {
                RowLayout {
                    Label {
                        text: i18n("Show:")
                    }

                    ComboBox {
                        id: recentOrdering

                        Layout.fillWidth: true

                        model: [i18n("Recently used"), i18n("Often used")]
                    }
                }

                CheckBox {
                    id: showRecentApps

                    text: recentOrdering.currentIndex == 0
                            ? i18n("Show recent applications")
                            : i18n("Show often used applications")
                }

                CheckBox {
                    id: showRecentDocs

                    text: recentOrdering.currentIndex == 0
                            ? i18n("Show recent documents")
                            : i18n("Show often used documents")
                }

                CheckBox {
                    id: showRecentContacts

                    text: recentOrdering.currentIndex == 0
                            ? i18n("Show recent contacts")
                            : i18n("Show often used contacts")
                }
            }
        }

        GroupBox {
            Layout.fillWidth: true

            title: i18n("Search")

            flat: true

            ColumnLayout {
                CheckBox {
                    id: useExtraRunners

                    text: i18n("Expand search to bookmarks, files and emails")
                }

                CheckBox {
                    id: alignResultsToBottom

                    visible: !isDash

                    text: i18n("Align search results to bottom")
                }
            }
        }
    }
}
