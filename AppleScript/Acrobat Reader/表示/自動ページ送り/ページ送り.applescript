#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

property refMe : a reference to current application

set appFileManager to refMe's NSFileManager's defaultManager()


set numDelayTIme to 1.2 as number

tell application id "com.adobe.Reader"
	activate
	tell active doc
		set strResponse to (do script ("app.response({cQuestion: \"ページ送り間隔秒指定(小数点以下２桁ぐらいまでなら可)\",cTitle: \"数値入力してください\",cDefault: \"" & numDelayTIme & "\",cLabel: \"数値入力:\"});"))
	end tell
end tell
###戻り値 NULLならキャンセル
if strResponse is "null" then
	return "キャンセルしました"
end if
#######################
#####全角入力対策
#######################
##可変テキスト
set ocidResponseText to refMe's NSMutableString's alloc()'s initWithCapacity:0
##戻り値をセット
ocidResponseText's setString:strResponse
###半角変換の設定
set ocidTransFrom to refMe's NSStringTransformFullwidthToHalfwidth
###レンジ取得
set ocidRange to ocidResponseText's rangeOfString:strResponse
###変換
ocidResponseText's applyTransform:ocidTransFrom |reverse|:false range:ocidRange updatedRange:(missing value)
###変換値をテキストに戻す
try
	set strResponseText to ocidResponseText as text
	set numDelayTIme to strResponseText as number
on error
	return "数値以外の値が来ました"
end try


tell application id "com.adobe.Reader"
	activate
	tell active doc
		set numCntAllPage to (count every page) as number
	end tell
end tell



repeat numCntAllPage times
	tell application id "com.adobe.Reader"
		tell active doc
			tell front PDF Window
				set numNowPage to page number as integer
			end tell
		end tell
		if numCntAllPage = numNowPage then
			tell active doc
				tell front PDF Window
					set page number to 1
				end tell
			end tell
			log "最後のページまで行ったら終わり"
			exit repeat
		else
			delay 0.5
			tell active doc
				tell front PDF Window
					set page number to (numNowPage + 1)
				end tell
			end tell
		end if
	end tell
	delay numDelayTIme
end repeat

