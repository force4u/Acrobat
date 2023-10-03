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
		execute menu item "OnlineSupport" of menu "Help" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"OnlineSupport\");")
	end try
end tell

return
{menu item "LearnApp" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "RestartTour" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "OnlineSupport" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "Welcome" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "LearnProduct" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "endUsingGroup" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "Updates" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "" of menu "ヘルプ" of application "Adobe Acrobat Reader DC", menu item "" of menu "ヘルプ" of application "Adobe Acrobat Reader DC"}