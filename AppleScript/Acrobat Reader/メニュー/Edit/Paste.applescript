#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#	com.adobe.distiller
#	com.adobe.Acrobat.Pro
#	com.adobe.Reader
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions


set strBundleID to "com.adobe.Reader"

tell application id "com.adobe.Reader"
	tell front window to activate
	try
		execute menu item "Paste" of menu "Edit" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"Paste\");")
	end try
end tell

return
{menu item "Undo" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Redo" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "endUndoGroup" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Cut" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Copy" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Paste" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Clear" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "endEditGroup" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "SelectAll" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "DeselectAll" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "endSelectGroup" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "RdrEditTextImageMenuItem" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "AddTextCmdEditMenuRdr" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "AddImageCmdEditMenuRdr" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "DeletePagesRdrMenuItem" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "RotatePagesRdrMenuItem" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "RedactInEditMenuItem" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "SelectGraphics" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Spelling:Spelling" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "LookUpWord" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "endLookUpGroup" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Find" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "FindSearch" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "SearchMoreToolsEditMenu" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "endFindGroup" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Spelling:Spelling" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Protection" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "Accessibility" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "ManageTools" of menu "編集 " of application "Adobe Acrobat Reader DC", menu item "SpecialCharacters" of menu "編集 " of application "Adobe Acrobat Reader DC"}