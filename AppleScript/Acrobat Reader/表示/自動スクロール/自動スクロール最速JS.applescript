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
	activate
	do script ("app.execMenuItem(\"AutoScroll\");")
	tell application "System Events"
		keystroke 9
	end tell
end tell

