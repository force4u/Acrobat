#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions


set numRepeatTimes to 300 as integer


tell application id "com.adobe.Reader"
	activate
	tell active doc
		set numCntAllPage to (count every page) as integer
	end tell
end tell

tell application id "com.adobe.Reader"
	activate
	do script ("app.execMenuItem(\"AutoScroll\");")
	tell application "System Events"
		keystroke 5
	end tell
end tell
set numChkPageNextNo to 0 as integer

repeat numRepeatTimes times
	tell application id "com.adobe.Reader"
		tell active doc
			tell front PDF Window
				set numNowPage to page number as integer
			end tell
		end tell
		if numCntAllPage = numNowPage then
			tell active doc
				tell front PDF Window
					set page number to 1
				end tell
			end tell
		else if numCntAllPage = (numNowPage + 1) then
			delay 0.5
			tell active doc
				tell front PDF Window
					set page number to (numNowPage + 1)
				end tell
			end tell
		else if numNowPage = 1 then
			do script ("app.execMenuItem(\"AutoScroll\");")
			tell application "System Events"
				keystroke 5
			end tell
		else if 2 = numChkPageNextNo then
			delay 1
			tell front PDF Window
				set page number to 1
			end tell
			
		end if
	end tell
	set numChkPageNextNo to numNowPage
	delay 1
end repeat
