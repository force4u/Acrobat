#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
(*
com.cocolog-nifty.quicktimer.icefloe
詳細
https://helpx.adobe.com/jp/enterprise/kb/mpip-support-acrobat.html
*)
#
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##自分環境がos12なので2.8にしているだけです
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions


property refMe : a reference to current application


set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirURL to ocidURLsArray's firstObject()
set ocidPlistFilePathURL to ocidLibraryDirURL's URLByAppendingPathComponent:("Preferences/com.adobe.Acrobat.Pro.plist")
set strFilePath to ocidPlistFilePathURL's |path| as text

try
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Delete :DC:MicrosoftAIP:ShowDMB\" \"" & strFilePath & "\"") as text
	do shell script strCommandText
	log "設定済みの値を一旦削除しました"
on error
	log "初回作成です"
end try

set strCommandText to ("/usr/libexec/PlistBuddy -c \"Add :DC:MicrosoftAIP:ShowDMB array\" \"" & strFilePath & "\"") as text
do shell script strCommandText

set strCommandText to ("/usr/libexec/PlistBuddy -c \"Add :DC:MicrosoftAIP:ShowDMB:item1 bool true\" \"" & strFilePath & "\"") as text
do shell script strCommandText

set strCommandText to ("/usr/libexec/PlistBuddy -c \"Add :DC:MicrosoftAIP:ShowDMB:item0 integer 0\" \"" & strFilePath & "\"") as text
do shell script strCommandText


set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print  :DC:MicrosoftAIP:ShowDMB:item1\" \"" & strFilePath & "\"") as text
set strResult to (do shell script strCommandText) as text


set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print :DC:MicrosoftAIP:ShowDMB:item0\" \"" & strFilePath & "\"") as text
set strResult to (do shell script strCommandText) as text




set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSLocalDomainMask))
set ocidLibraryDirURL to ocidURLsArray's firstObject()
set ocidPlistFilePathURL to ocidLibraryDirURL's URLByAppendingPathComponent:("Preferences/com.adobe.Acrobat.Pro.plist")
set strFilePath to ocidPlistFilePathURL's |path| as text



set strCommandText to ("/usr/bin/sudo /usr/bin/touch  \"" & strFilePath & "\"") as text
do shell script strCommandText with administrator privileges
try
	set strCommandText to ("/usr/bin/sudo /usr/libexec/PlistBuddy -c \"Delete :DC:FeatureLockdown:bMIPLabelling\" \"" & strFilePath & "\"") as text
	do shell script strCommandText with administrator privileges
	log "設定済みの値を一旦削除しました"
on error
	log "初回作成です"
end try

set strCommandText to ("/usr/bin/sudo /usr/libexec/PlistBuddy -c \"Add :DC:FeatureLockdown:bMIPLabelling bool true\" \"" & strFilePath & "\"") as text
do shell script strCommandText with administrator privileges


set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print :DC:FeatureLockdown:bMIPLabelling\" \"" & strFilePath & "\"") as text
set strResult to (do shell script strCommandText) as text

