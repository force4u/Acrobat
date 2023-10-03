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
		execute menu item "HideOthers" of menu "Apple" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"HideOthers\");")
	end try
end tell

return
{menu item "About" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "AboutAdobeExtensions" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "GeneralPrefs" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "Accessibility" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "Services" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "HideAcrobat" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "HideOthers" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "ShowAllApps" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "" of menu "Acrobat" of application "Adobe Acrobat Reader DC", menu item "Quit" of menu "Acrobat" of application "Adobe Acrobat Reader DC"}