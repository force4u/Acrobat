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
#####################
###全面ウィンドウチェック
tell application "Adobe Acrobat"
	###ウィンドウの数
	set numCntWin to (count of PDF Window) as integer
end tell
if numCntWin = 0 then
	log "ウィンドウがありません"
	###ダイアログ
	set strName to (name of current application) as text
	if strName is "osascript" then
		tell application "Finder" to activate
	else
		tell current application to activate
	end if
	display alert "エラー:pdfを開いていません" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 10
	return "ウィンドウがありませんPDFを開いてね"
end if
#####################
###本処理
tell application "Adobe Acrobat"
	activate
	tell active doc
		set aliasFilePath to file alias as alias
	end tell
end tell
set strFilePath to POSIX path of aliasFilePath as text
