#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

set numDelayTIme to 1.2 as number


set numRepeatTimes to 10 as integer

tell application id "com.adobe.Reader"
	activate
	tell active doc
		set numCntAllPage to (count every page) as integer
	end tell
end tell

repeat numRepeatTimes times
	
	repeat numCntAllPage times
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
			else
				delay 0.5
				tell active doc
					tell front PDF Window
						set page number to (numNowPage + 1)
					end tell
				end tell
			end if
		end tell
		delay numDelayTIme
	end repeat
	
end repeat