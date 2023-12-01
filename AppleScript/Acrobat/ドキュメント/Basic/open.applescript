#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#	com.adobe.Acrobat.Pro
#	com.adobe.Reader
#
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

set aliasFilePath to (choose file)

####元ファイルを開く
tell application "Adobe Acrobat"
	activate
	set objActivDoc to open aliasFilePath
end tell

return

set aliasFilePath to (choose file)
set strFilePath to (POSIX path of aliasFilePath) as text
do shell script "open -b com.adobe.Acrobat.Pro \"" & strFilePath & "\""

