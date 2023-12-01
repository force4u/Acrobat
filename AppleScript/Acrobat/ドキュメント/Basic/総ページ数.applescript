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
############ここまで定型

tell application "Adobe Acrobat"
	tell active doc
		log (count of every page)
		
		tell front PDF Window
			####ページ数

			set numAllPages to count of every page
						log numAllPages
		end tell
	end tell
end tell


