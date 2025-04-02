#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#com.cocolog-nifty.quicktimer.icefloe
# Acrobat のAIアシスタント機能をOFFにします
#　
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "UniformTypeIdentifiers"
use scripting additions
property refMe : a reference to current application

set listProduct to {"【１】DCReade(通常)", "【２】DCReade(SandBox)", "【３】DCPro(通常)", "【４】DCPro(SandBox)"} as list

#ダイアログ選択
set strName to (name of current application) as text
if strName is "osascript" then
	tell application "SystemUIServer" to activate
else
	tell current application to activate
end if
###
set strTitle to ("選んでください") as text
set strPrompt to ("ひとつ選んでください\nAiアシスタントをOFF設定にします") as text
try
	tell application "SystemUIServer"
		#Activateは必須
		activate
		set valueResponse to (choose from list listProduct with title strTitle with prompt strPrompt default items (item 1 of listProduct) OK button name "OK" cancel button name "キャンセル" with empty selection allowed without multiple selections allowed)
	end tell
on error
	log "Error choose from list"
	return false
end try
if (class of valueResponse) is boolean then
	log "Error キャンセルしました"
	return false
else if (class of valueResponse) is list then
	if valueResponse is {} then
		log "Error 何も選んでいません"
		return false
	else
		set strResponse to (item 1 of valueResponse) as text
	end if
end if


set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
if strResponse is "【１】DCReade(通常)" then
	#【１】Acrobat Readerの場合（通常）
	set strPlistFileName to ("com.adobe.Reader.plist") as text
	set ocidPrefDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences") isDirectory:(true)
else if strResponse is "【２】DCReade(SandBox)" then
	#【２】Acrobat Readerの場合（サンドボックス）
	set strPlistFileName to ("com.adobe.Reader.plist") as text
	set ocidPrefDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Containers/com.adobe.Reader/Data/Library/Preferences") isDirectory:(true)
else if strResponse is "【３】DCPro(通常)" then
	#【３】Acrobat製品版（通常）
	set strPlistFileName to ("com.adobe.Acrobat.Pro.plist") as text
	set ocidPrefDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences") isDirectory:(true)
else if strResponse is "【４】DCPro(SandBox)" then
	#【４】Acrobat製品版（サンドボックス）
	set strPlistFileName to ("com.adobe.Acrobat.Pro.plist") as text
	set ocidPrefDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Containers/com.adobe.Acrobat.Pro/Data/Library/Preferences") isDirectory:(true)
end if
#PLISTパス
set ocidPlistFilePathURL to ocidPrefDirPathURL's URLByAppendingPathComponent:(strPlistFileName) isDirectory:(false)
#PLIST読み込み
set ocidOption to (refMe's NSDataReadingMappedIfSafe)
set listResponse to (refMe's NSData's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL) options:(ocidOption) |error|:(reference))
set ocidReadData to (item 1 of listResponse)
if ocidReadData = (missing value) then
	return "設定ファイルがありません"
end if
#PropertyListSerialization
set ocidFormat to (refMe's NSPropertyListBinaryFormat_v1_0)
set ocidOption to refMe's NSPropertyListMutableContainersAndLeaves
set listResponse to (refMe's NSPropertyListSerialization's propertyListWithData:(ocidReadData) options:(ocidOption) format:(ocidFormat) |error|:(reference))
set ocidPlistDict to (item 1 of listResponse)
#ここでPLISTのROOTがDICT
set ocidDCdict to ocidPlistDict's objectForKey:("DC")
set ocidFeatureLockdownDict to ocidDCdict's objectForKey:("FeatureLockdown")
if ocidFeatureLockdownDict = (missing value) then
	set ocidFeatureLockdownDict to refMe's NSMutableDictionary's alloc()'s init()
	#
	set ocidEnableGentechArray to refMe's NSMutableArray's alloc()'s init()
	ocidEnableGentechArray's insertObject:(0) atIndex:(0)
	ocidEnableGentechArray's insertObject:(false) atIndex:(1)
	ocidFeatureLockdownDict's setObject:(ocidEnableGentechArray) forKey:("EnableGentech")
	ocidDCdict's setObject:(ocidFeatureLockdownDict) forKey:("FeatureLockdown")
else
	set ocidEnableGentechArray to ocidFeatureLockdownDict's objectForKey:("EnableGentech")
	if ocidEnableGentechArray = (missing value) then
		set ocidEnableGentechArray to refMe's NSMutableArray's alloc()'s init()
		ocidEnableGentechArray's insertObject:(0) atIndex:(0)
		ocidEnableGentechArray's insertObject:(false) atIndex:(1)
		ocidFeatureLockdownDict's setObject:(ocidEnableGentechArray) forKey:("EnableGentech")
	else
		ocidEnableGentechArray's replaceObjectAtIndex:(0) withObject:(0)
		ocidEnableGentechArray's replaceObjectAtIndex:(1) withObject:(false)
	end if
end if
log className() of ocidPlistDict as text
log ocidPlistDict's allKeys() as list

set ocidFormat to (refMe's NSPropertyListBinaryFormat_v1_0)
set listResponse to refMe's NSPropertyListSerialization's dataWithPropertyList:(ocidPlistDict) format:(ocidFormat) options:0 |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	set ocidPlistSaveData to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	set strErrorNO to (item 2 of listResponse)'s code() as text
	set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
	current application's NSLog("■：" & strErrorNO & strErrorMes)
	return "エラーしました" & strErrorNO & strErrorMes
end if

#保存　
set ocidOption to (refMe's NSDataWritingAtomic)
set listDone to ocidPlistSaveData's writeToURL:(ocidPlistFilePathURL) options:(ocidOption) |error|:(reference)
if (item 1 of listDone) is true then
	return "正常終了"
else if (item 1 of listDone) is false then
	set strErrorNO to (item 2 of listResponse)'s code() as text
	set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
	current application's NSLog("■：" & strErrorNO & strErrorMes)
	return "エラーしました" & strErrorNO & strErrorMes
end if
