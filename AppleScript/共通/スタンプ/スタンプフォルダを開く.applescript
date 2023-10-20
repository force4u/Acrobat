#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
(* ツールバーにある右三角▶︎をクリックしてください↑
Acrobatのスタンプフォルダを開きます
com.cocolog-nifty.quicktimer.icefloe
*)
#
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##自分環境がos12なので2.8にしているだけです
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application


set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
set ocidDcDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/DC/") isDirectory:(true)
set ocidJsDirFilePathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/DC/JavaScripts/") isDirectory:(true)
set ocidStampDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/DC/Stamps/") isDirectory:(true)

set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
# 777-->511 755-->493 700-->448 766-->502 
ocidAttrDict's setValue:(448) forKey:(refMe's NSFilePosixPermissions)
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidJsDirFilePathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidStampDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)

set strAcrobatDcDirPath to ocidDcDirPathURL's |path| as text
set strAcrobatJavaScriptsDirPath to ocidJsDirFilePathURL's |path| as text
set strAcrobatStampsDirPath to ocidStampDirPathURL's |path| as text


set aliasAcrobatJavaScriptsDirPath to (POSIX file strAcrobatJavaScriptsDirPath) as alias
set aliasAcrobatStampsDirPath to (POSIX file strAcrobatStampsDirPath) as alias
set aliasAcrobatDcDirPath to (POSIX file strAcrobatDcDirPath) as alias

tell application "Finder"
	
	make new Finder window
	tell front Finder window
		set target to aliasAcrobatStampsDirPath
		set position to {0, 0}
		set bounds to {0, 25, 720, 360}
		set current view to icon view
		set toolbar visible to true
		set statusbar visible to true
		set pathbar visible to true
		set sidebar width to 120
		
	end tell
	set selection to aliasAcrobatStampsDirPath
	
	activate
end tell
