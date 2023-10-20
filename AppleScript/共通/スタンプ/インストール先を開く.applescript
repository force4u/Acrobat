
#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##自分環境がos12なので2.8にしているだけです
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application


set listDirName to {"JavaScripts", "Stamps", "Plug-ins"} as list

###先に必要なフォルダを作っておく
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
set ocidDcDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/DC/") isDirectory:(true)
###フォルダのアトリビュート
set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
# 777-->511 755-->493 700-->448 766-->502 
ocidAttrDict's setValue:(448) forKey:(refMe's NSFilePosixPermissions)

repeat with itemDirName in listDirName
	set ocidMkDirPathURL to (ocidDcDirPathURL's URLByAppendingPathComponent:(itemDirName) isDirectory:(true))
	set listDone to (appFileManager's createDirectoryAtURL:(ocidMkDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference))
end repeat


###ダイアログ
set strName to (name of current application) as text
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
try
	set listResponse to (choose from list listDirName with title "選んでください" with prompt "開くフォルダ選んでください" default items (item 1 of listDirName) OK button name "OK" cancel button name "キャンセル" without multiple selections allowed and empty selection allowed)
on error
	log "エラーしました"
	return "エラーしました"
end try
if listResponse is false then
	return "キャンセルしました"
end if

set strResponse to (item 1 of listResponse) as text
set ocidOpenDirPathURL to (ocidDcDirPathURL's URLByAppendingPathComponent:(strResponse) isDirectory:(true))

set aliasOpenDirPath to (ocidOpenDirPathURL's absoluteURL()) as alias
tell application "Finder"
	try
		make new Finder window to aliasOpenDirPath as alias
		set position of front window to {0, 0}
		set bounds of front window to {0, 0, 720, 240}
		set sidebar width of front window to 120
		set current view of front window to icon view
		set statusbar visible of front window to true
		set toolbar visible of front window to true
		set sidebar width of front window to 120
		set current view of front window to icon view
	end try
end tell
