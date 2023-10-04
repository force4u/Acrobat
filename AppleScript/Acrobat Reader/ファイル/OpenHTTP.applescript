#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#	com.adobe.Acrobat.Pro
#	com.adobe.Reader
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

property refMe : a reference to current application

################################
######ペーストボードを取得
################################
set ocidPasteboard to refMe's NSPasteboard's generalPasteboard()
####タイプを取得
set ocidPastBoardTypeArray to ocidPasteboard's types
####テキストが含まれていない場合
set boolContain to ocidPastBoardTypeArray's containsObject:(refMe's NSStringPboardType)
if boolContain is false then
	log "URLがテキストで取得できそうもありません"
	set strURL to "https://"
else
	#####テキストで取得できそうな場合
	set ocidPasteboardArray to ocidPasteboard's readObjectsForClasses:({refMe's NSString}) options:(missing value)
	set ocidPasteboardStrings to (ocidPasteboardArray's objectAtIndex:0) as text
	set strPasteboardStrings to ocidPasteboardStrings as text
	####ペーストボードの中身がURLならデフォルトの値として用意する
	if strPasteboardStrings starts with "http" then
		set strURL to strPasteboardStrings
	else
		set strURL to "https://"
	end if
end if
################################
######アイコンパス
################################
set strBundleID to "com.adobe.Reader"
###
set ocidAppBundle to refMe's NSBundle's bundleWithIdentifier:(strBundleID)
if ocidAppBundle is not (missing value) then
	set ocidAppBundlePathStr to ocidAppBundle's bundlePath()
	set ocidAppBundlePath to ocidAppBundlePathStr's stringByStandardizingPath
	set ocidAppBundlePathURL to refMe's NSURL's alloc()'s initFileURLWithPath:ocidAppBundlePath isDirectory:false
	set ocidIconPathURL to ocidAppBundlePathURL's URLByAppendingPathComponent:"Contents/Resources/ACR_App.icns" isDirectory:false
else
	set appNSWorkspace to refMe's NSWorkspace's sharedWorkspace()
	set ocidAppBundlePathURL to appNSWorkspace's URLForApplicationWithBundleIdentifier:(strBundleID)
	set ocidIconPathURL to ocidAppBundlePathURL's URLByAppendingPathComponent:"Contents/Resources/ACR_App.icns" isDirectory:false
end if

log ocidIconPathURL's |path| as text

################################
######ダイアログ
################################

set aliasIconPath to (ocidIconPathURL's absoluteURL()) as alias

set strDefaultAnswer to strURL as text
try
	set recordResponse to (display dialog "PDFを開きます" with title "URL" default answer strDefaultAnswer buttons {"OK", "キャンセル"} default button "OK" cancel button "キャンセル" with icon aliasIconPath giving up after 30 without hidden answer)
on error
	log "エラーしました"
	return "エラーしました"
	error number -128
end try
if true is equal to (gave up of recordResponse) then
	return "時間切れですやりなおしてください"
	error number -128
end if
if "OK" is equal to (button returned of recordResponse) then
	set strResponse to (text returned of recordResponse) as text
else
	log "エラーしました"
	return "エラーしました"
	error number -128
end if
###########
if strResponse is "https://" then
	return "キャンセルしました"
else
	set strURL to strResponse as text
	###オプション追加
	set strURL to strResponse & "?pagemode=thumbs" as text
end if

################################
###### ファイルを開く
################################
tell application id "com.adobe.Reader"
	launch
	activate
	do script "var strURL = \"" & strURL & "\";"
	do script "var strEncURL = encodeURI(strURL);"
	do script "app.openDoc({ cPath: strEncURL, cFS: \"CHTTP\" });"
end tell



