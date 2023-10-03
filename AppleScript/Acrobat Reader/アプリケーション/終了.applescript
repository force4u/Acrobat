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

tell application id strBundleID to quit

set ocidResultsArray to refMe's NSRunningApplication's runningApplicationsWithBundleIdentifier:(strBundleID)
set numCntArray to ocidResultsArray count
if numCntArray ≠ 0 then
	set ocidRunApp to ocidResultsArray's objectAtIndex:0
	###通常終了
	set boolDone to ocidRunApp's terminate()
	####強制終了
	set boolDone to ocidRunApp's forceTerminate()
else if numCntArray = 0 then
	return "アプリケーションが未起動です"
end if

