#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
# ファイルをpyファイルに渡すだけの補助スクリプト
#
#
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

property refMe : a reference to current application

####################################
tell application "Finder"
	set aliasPathToMe to (path to me) as alias
end tell
###収集するコンテンツのディレクトリURL
set strPathToMe to (POSIX path of aliasPathToMe) as text
set strPathToMeStr to refMe's NSString's stringWithString:(strPathToMe)
set ocidPathToMe to strPathToMeStr's stringByStandardizingPath()
set ocidPathToMeURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidPathToMe) isDirectory:false)
set ocidContainerDirURL to ocidPathToMeURL's URLByDeletingLastPathComponent()
set ocidBinDirPathURL to ocidContainerDirURL's URLByAppendingPathComponent:("bin") isDirectory:true
###コンテンツを収集する　第一階層のみ
set appFileManager to refMe's NSFileManager's defaultManager()
##不可視ファイルを除く
set ocidOption to (refMe's NSDirectoryEnumerationSkipsHiddenFiles)
##パスURLとファイル名を収集
set ocidForKey to refMe's NSArray's alloc()'s initWithArray:({(refMe's NSURLPathKey), (refMe's NSURLNameKey)})
set listFilePathURL to appFileManager's contentsOfDirectoryAtURL:(ocidBinDirPathURL) includingPropertiesForKeys:{ocidForKey} options:(ocidOption) |error|:(reference)
set ocidFilePathURLArray to (item 1 of listFilePathURL)
##
set ocidFileNameDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
repeat with itemFilePathURL in ocidFilePathURLArray
	set ocidFileName to itemFilePathURL's lastPathComponent()
	(ocidFileNameDict's setValue:(itemFilePathURL) forKey:(ocidFileName))
end repeat
set listFileName to (ocidFileNameDict's allKeys()) as list

###ダイアログを前面に出す
tell current application
	set strName to name as text
end tell
####スクリプトメニューから実行したら
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
try
	set listResponse to (choose from list listFileName with title "選んでください" with prompt "実行するプログラムは？選んでください" default items (item 1 of listFileName) OK button name "OK" cancel button name "キャンセル" without multiple selections allowed and empty selection allowed) as list
on error
	log "エラーしました"
	return "エラーしました"
end try
if (item 1 of listResponse) is false then
	return "キャンセルしました"
end if
###ダイアログの戻り値
set strFileName to (item 1 of listResponse) as text
###レコードから取り出す
set ocidFilePathURL to ocidFileNameDict's valueForKey:(strFileName)

set strPythonBinPath to ocidFilePathURL's |path| as text

####スクリプトメニューから実行したら
tell current application
	set strName to name as text
end tell
if strName is "osascript" then
	tell application "Finder"
		activate
	end tell
else
	tell current application
		activate
	end tell
end if
####UTIリスト PDFのみ
set listUTI to {"com.adobe.pdf"}
set aliasDefaultLocation to (path to desktop folder from user domain) as alias
####ダイアログを出す
set aliasFilePath to (choose file with prompt "PDFファイルを選んでください" default location (aliasDefaultLocation) of type listUTI with invisibles and showing package contents without multiple selections allowed) as alias
####PDFのパス
set strFilePath to POSIX path of aliasFilePath
set ocidFilePathStr to (refMe's NSString's stringWithString:strFilePath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath isDirectory:false)
set strFilePath to (ocidFilePathURL's |path|()) as text


#################################
set strCommandText to ("\"" & strPythonBinPath & "\" \"" & strFilePath & "\"") as text
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script strCommandText in objWindowID
	delay 2
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	set theWid to get the id of window 1
	delay 1
	close front window saving no
end tell

