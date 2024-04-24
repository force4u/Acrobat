#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
# テキスト系式のapplescriptだとコンパイル時に起動するのでダメ
# コンパイル済みのscpt系式で保存してください
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.5"
use framework "Foundation"
use framework "AppKit"
use scripting additions

tell application id "com.adobe.distiller" to launch

##起動待ち最大１０秒
repeat 20 times
	tell application id "com.adobe.distiller"
		set boolFrontmost to frontmost as boolean
	end tell
	if boolFrontmost is false then
		tell application id "com.adobe.distiller"
			activate
		end tell
		delay 0.5
	else if boolFrontmost is true then
		exit repeat
	end if
end repeat




(*
property refMe : a reference to current application
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationDirectory) inDomains:(refMe's NSLocalDomainMask))
set ocidApplicationDirPathURL to ocidURLsArray's firstObject()
set ocidAppFilePathURL to ocidApplicationDirPathURL's URLByAppendingPathComponent:("Adobe Acrobat DC/Acrobat Distiller.app")
set aliasFilePath to (ocidFilePathURL's absoluteURL()) as alias

tell application "Finder"
	open aliasFilePath
end tell
##

set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
appSharedWorkspace's openURLs:(ocidAppFilePathURL)


##
do shell script "/usr/bin/open -b com.adobe.distiller"



*)

