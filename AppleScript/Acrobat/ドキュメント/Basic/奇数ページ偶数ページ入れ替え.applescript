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
###########################
###修正の有無
tell application "Adobe Acrobat"
	activate
	tell active doc
		set boolMod to modified as boolean
	end tell
	###修正あるなら上書き保存しておく
	if boolMod is true then
		##	tell active doc to save
	end if
end tell

###########################
###前面ドキュメントのページ数
tell application "Adobe Acrobat"
	activate
	tell active doc
		set numCntAllPage to (count of every page) as integer
	end tell
end tell
###########################
###処理は１ページ目から１ページおきに
set numNowPage to 1 as integer
###実際の処理はページ数の半分
set numRepeatTime to (round of (numCntAllPage / 2) rounding down) as integer
###実際の処理はページ数の半分繰り返し
repeat numRepeatTime times
	tell application "Adobe Acrobat"
		tell active doc
			tell front PDF Window
				move page numNowPage to after page (numNowPage + 1)
			end tell
		end tell
	end tell
	set numNowPage to numNowPage + 2
end repeat

return
