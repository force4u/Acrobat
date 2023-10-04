#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7

use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "Quartz"
use framework "PDFKit"
use scripting additions
property refMe : a reference to current application


tell application "System Events"
	tell current user
		set strAccountName to name as text
		log strAccountName
		set strFullName to full name as text
	end tell
end tell
##################################
#### 現在のページ番号を取得する
##################################
###リダーの場合はこちら
tell application id "com.adobe.Reader"
	activate
	set objAvtivDoc to active doc
	tell objAvtivDoc
		set aliasFilePath to file alias as alias
	end tell
	tell front PDF Window
		set numPageNo to page number as integer
	end tell
end tell
##############################
#####ダイアログを前面に
##############################
tell current application
	set strName to name as text
end tell
####スクリプトメニューから実行したら
if strName is "osascript" then
	tell application "Finder" to activate
	set boolAlert to doDisplayAlert(numPageNo) as boolean
else
	tell current application to activate
	set boolAlert to doDisplayAlert(numPageNo) as boolean
end if
if boolAlert is true then
	log "処理を実行します"
	tell application id "com.adobe.Reader"
		activate
		set objAvtivDoc to active doc
		tell objAvtivDoc
			set boolMode to modified
			###変更箇所があるなら保存する
			if boolMode is true then
				save
			end if
		end tell
	end tell
else
	return "処理を中止します。"
end if
##############################
#####パス処理
##############################
set strFilePath to POSIX path of aliasFilePath as text
set ocidFilePathStr to refMe's NSString's stringWithString:(strFilePath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidFilePath) isDirectory:false)
##############################
#####処理開始前にPDFを一旦閉じる
##############################
tell application id "com.adobe.Reader"
	activate
	set objAvtivDoc to active doc
	tell objAvtivDoc
		close saving yes
	end tell
end tell

##############################
#####PDF処理
##############################
####ドキュメントの初期化
set ocdiActivDoc to refMe's PDFDocument's alloc()'s initWithURL:(ocidFilePathURL)
###指定したページ番号のPDFpageを取得
set ocidPDFPage to ocdiActivDoc's pageAtIndex:(numPageNo - 1)
###指定したページ番号の後に↑のPDFページを挿入↓
ocdiActivDoc's insertPage:(ocidPDFPage) atIndex:(numPageNo - 1)
####保存
############################
(ocdiActivDoc's writeToURL:(ocidFilePathURL))
delay 1

#################################
#####アクロバットで開く
#################################
tell application id "com.adobe.Reader"
	activate
	##	open file aliasFilePath
	do script "app.openDoc(\"" & strFilePath & "\");"
end tell
##############################
#####ダイアログ
##############################
on doDisplayAlert(argPageNo)
	set strAlertMes to (argPageNo & "ページ目を\r" & argPageNo & "ページの後に\r複製します") as text
	try
		set recordResponse to (display alert ("【選んでください】\r" & strAlertMes) buttons {"OK", "NG", "キャンセル"} default button "OK" cancel button "キャンセル" as informational giving up after 10) as record
	on error
		
		log "キャンセルしました。処理を中止します。"
		return false
	end try
	if true is equal to (gave up of recordResponse) then
		log "時間切れです。処理を中止します。"
		return false
	end if
	###ダイアログの戻り値を取得
	set strBottonName to (button returned of recordResponse) as text
	###OKの場合のみ戻り値を出す
	if "OK" is equal to (strBottonName) then
		return true
	else if "NG" is equal to (strBottonName) then
		log "NGを確認しました。処理を中止します。"
		return false
	else
		log "キャンセルしました。処理を中止します。"
		return false
	end if
	
end doDisplayAlert