#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
# テキスト系式のapplescriptだとコンパイル時に起動するのでダメ
# コンパイル済みのscpt系式で保存してください
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "UniformTypeIdentifiers"

use scripting additions
property refMe : a reference to current application


tell application id "com.adobe.distiller" to quit

##ファイルパスの格納用のリスト
set ocidFilePathURLArray to refMe's NSMutableArray's alloc()'s initWithCapacity:(0)
#ファイル収集のオプション（非表示無視）
set ocidOption to (refMe's NSDirectoryEnumerationSkipsHiddenFiles)
#収集するキー（パスと名前）
set ocidKeysArray to refMe's NSMutableArray's alloc()'s initWithCapacity:(0)
ocidKeysArray's addObject:(refMe's NSURLPathKey)
ocidKeysArray's addObject:(refMe's NSURLNameKey)
######
#収集するパス
set listDirPath to {"Adobe/Adobe PDF/Settings", "Adobe/Adobe PDF/Extras"}
#ローカルドメインの収集
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationSupportDirectory) inDomains:(refMe's NSLocalDomainMask))
set ocidLocalAppSupDirPathURL to ocidURLsArray's firstObject()
#収集して
repeat with itemDirPath in listDirPath
	set ocidChkDirPathURL to (ocidLocalAppSupDirPathURL's URLByAppendingPathComponent:(itemDirPath) isDirectory:(true))
	set lisrResponse to (appFileManager's contentsOfDirectoryAtURL:(ocidChkDirPathURL) includingPropertiesForKeys:(ocidKeysArray) options:(ocidOption) |error|:(reference))
	if (item 2 of lisrResponse) = (missing value) then
		set ocidGetFilePathURLArray to (item 1 of lisrResponse)
	else if (item 2 of lisrResponse) ≠ (missing value) then
		log (item 2 of lisrResponse)'s localizedDescription() as text
	end if
	##リストに追加
	(ocidFilePathURLArray's addObjectsFromArray:(ocidGetFilePathURLArray))
end repeat
######
#ユーザードメインの収集
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationSupportDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLocalAppSupDirPathURL to ocidURLsArray's firstObject()
#収集して
repeat with itemDirPath in listDirPath
	set ocidChkDirPathURL to (ocidLocalAppSupDirPathURL's URLByAppendingPathComponent:(itemDirPath) isDirectory:(true))
	set lisrResponse to (appFileManager's contentsOfDirectoryAtURL:(ocidChkDirPathURL) includingPropertiesForKeys:(ocidKeysArray) options:(ocidOption) |error|:(reference))
	if (item 2 of lisrResponse) = (missing value) then
		set ocidGetFilePathURLArray to (item 1 of lisrResponse)
	else if (item 2 of lisrResponse) ≠ (missing value) then
		log (item 2 of lisrResponse)'s localizedDescription() as text
	end if
	##リストに追加
	(ocidFilePathURLArray's addObjectsFromArray:(ocidGetFilePathURLArray))
end repeat
######
##ファイル名とパスのレコードを作成
set ocidName2URLDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
repeat with itemFilePathURL in ocidFilePathURLArray
	set ocidFileName to itemFilePathURL's lastPathComponent()
	(ocidName2URLDict's setObject:(itemFilePathURL) forKey:(ocidFileName))
end repeat
######
##ファイル名だけのリスト
set ocidAllKeys to ocidName2URLDict's allKeys()
##ソート
set ocidFileNameArray to ocidAllKeys's sortedArrayUsingSelector:("localizedStandardCompare:")
set listFileNameArray to ocidFileNameArray as list
#最小ファイルサイズが何番目か？
set numIndex to ocidFileNameArray's indexOfObject:("Smallest File Size.joboptions")
set numIndex to (numIndex + 1) as integer
##################
#ダイアログ
set strName to (name of current application) as text
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
###
set strTitle to ("選んでください") as text
set strPrompt to ("ジョブオプションを選んでください") as text
try
	set listResponse to (choose from list listFileNameArray with title strTitle with prompt strPrompt default items (item numIndex of listFileNameArray) OK button name "OK" cancel button name "キャンセル" without multiple selections allowed and empty selection allowed) as list
on error
	log "エラーしました"
	return "エラーしました"
end try
if (item 1 of listResponse) is false then
	return "キャンセルしましたA"
else if (item 1 of listResponse) is "キャンセル" then
	return "キャンセルしましたB"
else
	set strResponse to (item 1 of listResponse) as text
end if
##
set ocidChooseFilePathURL to ocidName2URLDict's objectForKey:(strResponse)
set strChooseFilePath to ocidChooseFilePathURL's |path| as text
set strAdobePDFSettingsPath to strChooseFilePath as text

###ダイアログ
set strName to (name of current application) as text
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSDesktopDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidDesktopDirPathURL to ocidURLsArray's firstObject()
set aliasDefaultLocation to (ocidDesktopDirPathURL's absoluteURL()) as alias

set listUTI to {"com.adobe.encapsulated-postscript"}
set strMes to ("ファイルを選んでください") as text
set strPrompt to ("ファイルを選んでください") as text
try
	###　ファイル選択時
	set aliasFilePath to (choose file strMes with prompt strPrompt default location (aliasDefaultLocation) of type listUTI with invisibles and showing package contents without multiple selections allowed) as alias
on error
	log "エラーしました"
	return "エラーしました"
end try

set strPsFilePath to (POSIX path of aliasFilePath) as text
set ocidFilePathStr to refMe's NSString's stringWithString:(strPsFilePath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidFilePath) isDirectory:false)
set ocidContainerDirPathURL to ocidFilePathURL's URLByDeletingLastPathComponent()
set strDestinationPath to ocidContainerDirPathURL's |path| as text


tell application "Acrobat Distiller" to launch
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

tell application "Acrobat Distiller"
	Distill sourcePath strPsFilePath destinationPath strDestinationPath adobePDFSettingsPath strAdobePDFSettingsPath
end tell

return
tell application "Acrobat Distiller"
	quit
end tell
