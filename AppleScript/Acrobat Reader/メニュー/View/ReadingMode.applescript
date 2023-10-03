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
		execute menu item "ReadingMode" of menu "View" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"ReadingMode\");")
	end try
end tell

return
{menu item "Rotate" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "GoTo" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "PageLayout" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "ZoomSubMenu" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "endGoToGroup" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "CollectionViewGroup" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "ToolsActions" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "ShowHideSubMenu" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "DisplayTheme" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "AppInAV2UI" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "ReadingMode" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "FullScreenMode" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "endFullScreenGroup" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "Annots:ReviewTracker" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "" of menu "表示" of application "Adobe Acrobat Reader DC", menu item "ReadAloud" of menu "表示" of application "Adobe Acrobat Reader DC"}