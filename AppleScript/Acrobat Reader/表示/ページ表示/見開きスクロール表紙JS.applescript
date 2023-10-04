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

set strBundleID to "com.adobe.Reader"




tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"TwoColumns\");")
end tell
tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowCoverPage\");")
end tell