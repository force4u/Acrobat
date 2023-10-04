#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

tell application id "com.adobe.Reader"
	do script "app.execMenuItem(\"Maximize\");"
	do script "var boolDone = app.execMenuItem(\"ShowHideThumbnails\");"
	do script ""
end tell

