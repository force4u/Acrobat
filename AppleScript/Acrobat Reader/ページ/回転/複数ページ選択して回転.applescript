#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions
use framework "AppKit"
use framework "Quartz"
use framework "QuartzCore"

property refMe : a reference to current application

###################################
###
tell application "System Events"
	set strAppTitile to title of (front process whose frontmost is true)
end tell

if strAppTitile is "プレビュー" then
	tell application "Preview"
		tell document 1
			set strFilePath to path as text
			close
		end tell
	end tell
else if strAppTitile contains "Acrobat Reader" then
	tell application id "com.adobe.Reader"
		activate
		##ファイルパス
		tell active doc
			set aliasFilePath to file alias
		end tell
	end tell
	set strFilePath to (POSIX path of aliasFilePath) as text
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
		close objAvtivDoc
	end tell
else
	set aliasFile to (choose file with prompt "ファイルを選んでください" default location (path to desktop folder from user domain) of type {"com.adobe.pdf"} with invisibles and showing package contents without multiple selections allowed) as alias
	-->alias
	set strFilePath to POSIX path of aliasFile
end if
#######################
###パスをNSURLに
set ocidFilePathStr to refMe's NSString's stringWithString:(strFilePath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidFilePath) isDirectory:false)
#######################
###PDFファイルを格納
set ocidPDFDocument to refMe's PDFDocument's alloc()'s initWithURL:(ocidFilePathURL)
###総ページ数
set numOrgPdfPageCnt to ocidPDFDocument's pageCount()
###格納用のリスト
set ocidPageNOArrayM to refMe's NSMutableArray's alloc()'s initWithCapacity:(0)
###ページ数分繰り返し
repeat with itemIntNo from 1 to (numOrgPdfPageCnt as integer) by 1
	###ページ番号をリストに格納していく
	(ocidPageNOArrayM's addObject:(itemIntNo))
end repeat
set listPageNO to ocidPageNOArrayM as list



##############################
###ダイアログを前面に出す
tell current application
	set strName to name as text
end tell
###スクリプトメニューから実行したら
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
###
set strTitle to "選んでください" as text
set strPrompt to "処理する『ページ番号』選んでください\n⌘押しながら選択\n⇧押しながら選択ができます\n⌘+aで全部選択もできます" as text
try
	set listResponse to (choose from list listPageNO with title strTitle with prompt strPrompt default items (item 1 of listPageNO) OK button name "OK" cancel button name "キャンセル" with multiple selections allowed without empty selection allowed) as list
	if (item 1 of listResponse) is false then
		log "キャンセル"
		return "キャンセル"
	end if
on error
	log "エラーしました"
	return "エラーしました"
end try
set listPageNO to listResponse as list

##############################
###ダイアログを前面に出す
tell current application
	set strName to name as text
end tell
###スクリプトメニューから実行したら
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
###
set listRotation to {"0", "90", "180", "270"}
set strTitle to "選んでください" as text
set strPrompt to "ページの回転を選んでください\n時計回りです\n270は版時計回りで−90度になります\n【特殊】0を指定すると回転０をセットしてページの天地向きになります" as text
try
	set listResponse to (choose from list listRotation with title strTitle with prompt strPrompt default items (item 1 of listRotation) OK button name "OK" cancel button name "キャンセル" without multiple selections allowed and empty selection allowed) as list
	if (item 1 of listResponse) is false then
		log "キャンセル"
		return "キャンセル"
	end if
on error
	log "エラーしました"
	return "エラーしました"
end try
set numSetRotation to (item 1 of listResponse) as integer
##############################
###選択されたページに対して処理
repeat with itemPageNO in listPageNO
	set numPageNoOc to (itemPageNO - 1) as integer
	##############################
	###ここにページ毎の処理を記述
	set ocidActivPage to (ocidPDFDocument's pageAtIndex:(numPageNoOc))
	##今の回転を元に　設定する回転を決める
	set numRotation to (ocidActivPage's |rotation|()) as integer
	
	if numSetRotation = 0 then
		set numNewRotation to 0 as integer
	else if numSetRotation = 90 then
		if numRotation = 0 then
			set numNewRotation to 90 as integer
		else if numRotation = 90 then
			set numNewRotation to 180 as integer
		else if numRotation = 180 then
			set numNewRotation to 270 as integer
		else if numRotation = 270 then
			set numNewRotation to 0 as integer
		end if
	end if
	if numSetRotation = 270 then
		if numRotation = 0 then
			set numNewRotation to 270 as integer
		else if numRotation = 90 then
			set numNewRotation to 0 as integer
		else if numRotation = 180 then
			set numNewRotation to 90 as integer
		else if numRotation = 270 then
			set numNewRotation to 180 as integer
		end if
	end if
	if numSetRotation = 180 then
		if numRotation = 0 then
			set numNewRotation to 180 as integer
		else if numRotation = 90 then
			set numNewRotation to 270 as integer
		else if numRotation = 180 then
			set numNewRotation to 0 as integer
		else if numRotation = 270 then
			set numNewRotation to 90 as integer
		end if
	end if
	#################################
	###ページ回転設定する
	(ocidActivPage's setRotation:(numNewRotation))
	
end repeat
#################################
###処理が終わったら保存
set ocidOption to (missing value)
set listDone to ocidPDFDocument's writeToURL:(ocidFilePathURL) withOptions:(ocidOption)

delay 1

#################################
###アクロバットで開く
(*
open option
https://quicktimer.cocolog-nifty.com/icefloe/2023/03/post-bcc393.html
*)
set numNowPage to 1 as text
set aliasFilePath to (ocidFilePathURL's absoluteURL()) as alias
set strOptionText to "page=" & numNowPage & "&zoom=top&view=Fit&pagemode=thumbs" as text
tell application id "com.adobe.Reader"
	activate
	tell front PDF Window
		open aliasFilePath options strOptionText
		##				open file aliasFilePath
	end tell
	tell active doc
		tell front PDF Window
			set page number to numNowPage
		end tell
	end tell
end tell

