import QtQuick 2.4
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import Cyber.FileManager 1.0

Menu {
    id: contextMenu
    modal: true

    // Init status
    onVisibleChanged: {
        if (visible) {
            var indexes = selection.selectedIndexes();

            if (indexes.length >= 2) {
                // Does not support renaming of multiple files.
                renameAction.enabled = false

                // If a folder is selected, open terminal options.
                var enableTerminalAction = false
                for (var i = 0; i < indexes.length; ++i) {
                    if (folderModel.get(indexes[i], FolderListModel.FileIsDirRole)) {
                        enableTerminalAction = true
                        break
                    }
                }
                openInTerminal.visible = enableTerminalAction
            } else {
                openInTerminal.visible = folderModel.get(indexes[0], FolderListModel.FileIsDirRole)
                renameAction.enabled = true
            }
        }
    }

    MenuItem {
        id: openAction
        text: qsTr("Open")

        onTriggered: {
            // TODO: Multi
            var indexes = selection.selectedIndexes()
            for (var i = 0; i < indexes.length; ++i) {
                folderModel.openIndex(indexes[i])
                break;
            }
        }
    }

    MenuItem {
        id: openWithAction
        text: qsTr("Open With")
        enabled: true

        onTriggered: {
            var indexes = selection.selectedIndexes();
            var urls = []
            for (var i = 0; i < indexes.length; ++i) {
                urls.push(folderModel.get(indexes[i], FolderListModel.FilePathRole))
            }

            if (urls.length > 0) {
                // openWithDialog.urls = urls
                // openWithDialog.open()
                console.log(urls)
            }
        }
    }

    MenuItem {
        id: openInTerminal
        text: qsTr("Open in Terminal")
        visible: false

        onTriggered: {
            var indexes = selection.selectedIndexes()
            for (var i = 0; i < indexes.length; ++i) {
                folderModel.openTerminal(folderModel.get(indexes[i], FolderListModel.FilePathRole))
            }
        }
    }

    MenuItem {
        id: cutAction
        text: qsTr("Cut")
    }

    MenuItem {
        id: copyAction
        text: qsTr("Copy")
    }

    MenuItem {
        id: deleteAction
        text: qsTr("Delete")
    }

    MenuSeparator { }

    MenuItem {
        id: renameAction
        text: qsTr("Rename")
    }

    MenuSeparator { }

    MenuItem {
        id: properties
        text: qsTr("Properties")
    }
}
