#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
# 			com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7

use AppleScript version "2.8"
use framework "Foundation"
use framework "PDFKit"
use framework "Quartz"
use scripting additions

property refMe : a reference to current application

set appFileManager to refMe's NSFileManager's defaultManager()

############################################
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
##################################
#### 文書を開いているか？
##################################
tell application id "com.adobe.Reader"
	activate
	tell active doc
		set numAllPage to do script ("this.numPages;")
		try
			if numAllPage is "undefined" then
				error number -1708
			end if
		on error
			display alert "エラー:文書が選択されていません" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 10
			return "エラー:文書が選択されていません"
		end try
	end tell
end tell
##################################
#### パス取得
##################################
tell application id "com.adobe.Reader"
	activate
	set objAvtivDoc to active doc
	tell objAvtivDoc
		set boolMode to modified
		###変更箇所があるなら保存する
		if boolMode is true then
			save
		end if
		####ファイルエリアス取得
		set aliasFilePath to file alias as alias
	end tell
	close objAvtivDoc
end tell
#################################
#### 本処理
#################################
###パス処理
set strFilePath to (POSIX path of aliasFilePath) as text
set ocidFilePathStr to (refMe's NSString's stringWithString:strFilePath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath isDirectory:false)
##########################
####PDFファイルを格納
set ocidPDFDocument to (refMe's PDFDocument's alloc()'s initWithURL:ocidFilePathURL)
####ページ数
set numPageCnt to ocidPDFDocument's pageCount() as integer

if numPageCnt = 1 then
	log "１ページの場合は処理できない"
	return "１ページの場合は処理できない"
else
	###ページ数カウンター
	set numCntPageNo to 0 as number
	repeat numPageCnt times
		####偶数奇数判定 mod=割った時に小数点以下があるか？
		set numChkPageOddEven to (numCntPageNo mod 2) as number
		###０なら奇数
		if numChkPageOddEven = 0 then
			ocidPDFDocument's exchangePageAtIndex:(numCntPageNo) withPageAtIndex:(numCntPageNo + 1)
		else if numChkPageOddEven = 1 then
			###０なら奇数処理は奇数ページで行い偶数ページは操作しない
			log "偶数ページ"
		end if
		set numCntPageNo to numCntPageNo + 1 as number
	end repeat
end if
#################################
#####保存する
#################################
ocidPDFDocument's writeToURL:(ocidFilePathURL)
delay 1
#################################
#####アクロバットで開く
#################################
tell application id "com.adobe.Reader"
	activate
	open aliasFilePath
end tell



return