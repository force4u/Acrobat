#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "UniformTypeIdentifiers"

use scripting additions
property refMe : a reference to current application

try
	tell application id "com.adobe.distiller" to quit
end try
set ocidRunningApplication to refMe's NSRunningApplication
set ocidAppArray to (ocidRunningApplication's runningApplicationsWithBundleIdentifier:("com.adobe.distiller"))
###複数起動時も順番に終了
repeat with itemAppArray in ocidAppArray
	###終了
	itemAppArray's terminate()
end repeat
##１秒まって終了を確認
delay 1
##終了できない場合は強制終了
repeat with itemAppArray in ocidAppArray
	set boolTerminate to itemAppArray's terminated
	if boolTerminate = false then
		itemAppArray's forceTerminate()
	end if
end repeat
##使いたくないがしかたがない
try
do shell script "/usr/bin/killall Distiller"
end try
return
