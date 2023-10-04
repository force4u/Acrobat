#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "PDFKit"
use framework "Quartz"
use scripting additions

property refMe : a reference to current application

tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowHideArticles\");")
end tell
delay 0.5
tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowHideNavigationPane\");")
end tell
delay 0.5
tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowHideMenuBar\");")
end tell
delay 0.5
tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowHideModelTree\");")
end tell
delay 0.5
tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowHideOptCont\");")
end tell
delay 0.5
tell application id "com.adobe.Reader"
	do script ("app.execMenuItem(\"ShowHideFileAttachment\");")
end tell
delay 0.5
tell application id "com.adobe.Reader"
	do script "app.execMenuItem(\"Maximize\");"
	do script "var boolDone = app.execMenuItem(\"ShowHideThumbnails\");"
	do script ""
end tell