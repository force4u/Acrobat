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
use framework "AppKit"
use scripting additions

property refMe : a reference to current application


tell current application
	set strName to name as text
end tell
####スクリプトメニューから実行したら
if strName is "osascript" then
	tell application "Finder"
		set strScript to "set listMenu to {} as list\rtell application id \"com.adobe.Reader\"\rset listItem to every menu item of menu \"Acrobat\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"Apple\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"File\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"Edit\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"View\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"SignMenu\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"Window\" as list\rcopy listItem to end of listMenu\rset listItem to every menu item of menu \"Help\" as list\rcopy listItem to end of listMenu\rlog listMenu\rreturn listMenu\rend tell\r"
		tell application "Script Editor"
			activate
			make new document with properties {text:strScript}
		end tell
	end tell
else
	tell current application
		activate
		set listMenu to {} as list
		tell application id "com.adobe.Reader"
			set listItem to every menu item of menu "Acrobat" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "Apple" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "File" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "Edit" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "View" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "SignMenu" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "Window" as list
			copy listItem to end of listMenu
			set listItem to every menu item of menu "Help" as list
			copy listItem to end of listMenu
			log listMenu
			return listMenu
		end tell
	end tell
end if




