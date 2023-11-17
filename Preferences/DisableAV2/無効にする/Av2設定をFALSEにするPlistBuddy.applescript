#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
(*
前提
Adobe Acrobat　Acrobat Reader
アプリケーションを終了させてから
１０秒程度経過してから
実行してください
*)
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "UniformTypeIdentifiers"
use scripting additions
property refMe : a reference to current application

set listBundleID to {"com.adobe.Acrobat.Pro", "com.adobe.Reader"} as list

###アプリケーションが起動しているか
set ocidRunningApplication to refMe's NSRunningApplication
repeat with itemBundleID in listBundleID
	set ocidAppArray to (ocidRunningApplication's runningApplicationsWithBundleIdentifier:(itemBundleID))
	set itemAppArray to ocidAppArray's firstObject()
	if itemAppArray is (missing value) then
		log "アプリケーションが起動していませんので処理します"
	else
		display alert "エラー:アプリケーションを終了させてください" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 2
		return "エラー:アプリケーションが起動しています終了させてから実行してください"
	end if
end repeat


##パス製品版
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
########################################################
##PLISTへのパス　まずは　製品版
set ocidPlistFilePathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences/com.adobe.Acrobat.Pro.plist")
set strPlistFilePathURL to (ocidPlistFilePathURL's |path|()) as text

###内容の確認
#IPMEnableAV2AcrobatNewUser
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:IPMEnableAV2AcrobatNewUser:0\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
log strResponse
#IPMEnableAV2AcrobatNewUser
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:IPMEnableAV2AcrobatNewUser:1\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
if strResponse is "true" then
	log "IPMEnableAV2AcrobatNewUser：現在の設定はYES TRUEです FALSEに変更します"
	###値変更
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Set:DC:AVGeneral:IPMEnableAV2AcrobatNewUser:1 bool false\" \"" & strPlistFilePathURL & "\"") as text
	set strResponse to (do shell script strCommandText) as text
else if strResponse is "false" then
	log "IPMEnableAV2AcrobatNewUser：現在の設定はNO FALSEです"
end if
#EnableAV2
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:EnableAV2:0\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
log strResponse
#EnableAV2
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:EnableAV2:1\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
if strResponse is "true" then
	log "EnableAV2：現在の設定はYES TRUEです FALSEに変更します"
	###値変更
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Set:DC:AVGeneral:EnableAV2:1 bool false\" \"" & strPlistFilePathURL & "\"") as text
	set strResponse to (do shell script strCommandText) as text
else if strResponse is "false" then
	log "EnableAV2：現在の設定はNO FALSEです"
end if

#EnableAV2Enterprise
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:FeatureLockDown:EnableAV2Enterprise\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
if strResponse is "true" then
	log "EnableAV2Enterprise：現在の設定はYES TRUEです FALSEに変更します"
	###値変更
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Set:DC:FeatureLockDown:EnableAV2Enterprise bool false\" \"" & strPlistFilePathURL & "\"") as text
	set strResponse to (do shell script strCommandText) as text
else if strResponse is "false" then
	log "EnableAV2Enterprise：現在の設定はNO FALSEです"
end if

set strCommandText to ("/usr/libexec/PlistBuddy -c \"Save\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text



########################################################
##パス無償版
set ocidPlistFilePathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences/com.adobe.Reader.plist")
set strPlistFilePathURL to (ocidPlistFilePathURL's |path|()) as text

###内容の確認
#IPMEnableAV2ReaderNewUser
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:IPMEnableAV2ReaderNewUser:0\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
log strResponse
#IPMEnableAV2ReaderNewUser
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:IPMEnableAV2ReaderNewUser:1\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
if strResponse is "true" then
	log "IPMEnableAV2ReaderNewUser：現在の設定はYES TRUEです FALSEに変更します"
	###値変更
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Set:DC:AVGeneral:IPMEnableAV2ReaderNewUser:1 bool false\" \"" & strPlistFilePathURL & "\"") as text
	set strResponse to (do shell script strCommandText) as text
else if strResponse is "false" then
	log "IPMEnableAV2ReaderNewUser：現在の設定はNO FALSEです"
end if
#EnableAV2
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:EnableAV2:0\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
log strResponse
#EnableAV2
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:AVGeneral:EnableAV2:1\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
if strResponse is "true" then
	log "EnableAV2：現在の設定はYES TRUEです FALSEに変更します"
	###値変更
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Set:DC:AVGeneral:EnableAV2:1 bool false\" \"" & strPlistFilePathURL & "\"") as text
	set strResponse to (do shell script strCommandText) as text
else if strResponse is "false" then
	log "EnableAV2：現在の設定はNO FALSEです"
end if

#EnableAV2Enterprise
set strCommandText to ("/usr/libexec/PlistBuddy -c \"Print:DC:FeatureLockDown:EnableAV2Enterprise\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text
if strResponse is "true" then
	log "EnableAV2Enterprise：現在の設定はYES TRUEです FALSEに変更します"
	###値変更
	set strCommandText to ("/usr/libexec/PlistBuddy -c \"Set:DC:FeatureLockDown:EnableAV2Enterprise bool false\" \"" & strPlistFilePathURL & "\"") as text
	set strResponse to (do shell script strCommandText) as text
else if strResponse is "false" then
	log "EnableAV2Enterprise：現在の設定はNO FALSEです"
end if

set strCommandText to ("/usr/libexec/PlistBuddy -c \"Save\" \"" & strPlistFilePathURL & "\"") as text
set strResponse to (do shell script strCommandText) as text


return


