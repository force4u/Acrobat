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
		execute menu item "CollectionRemoveSplit" of menu "Window" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"CollectionRemoveSplit\");")
	end try
end tell

return
{menu item "NewWindow" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "Maximize" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "endMacWindowGroup" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "IdleManagerSnapshot" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "Cascade" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "Tile" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "endWindowLayoutGroup" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "MinimizeAllWindows" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "Minimize" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "CollectionSplitHorizontal" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "CollectionSplitVertical" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC", menu item "CollectionRemoveSplit" of menu "ウィンドウ" of application "Adobe Acrobat Reader DC"}