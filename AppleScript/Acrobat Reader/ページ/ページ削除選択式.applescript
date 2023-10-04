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
use framework "PDFKit"
use framework "Quartz"
use scripting additions

property refMe : a reference to current application


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
			tell current application
				set strName to name as text
			end tell
			####スクリプトメニューから実行したら
			if strName is "osascript" then
				tell application "Finder"
					activate
				end tell
			else
				tell current application
					activate
				end tell
			end if
			display alert "エラー:文書が選択されていません" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 10
			return "エラー:文書が選択されていません"
		end try
	end tell
end tell
#######################
#####Acraobatでの削除ページ指定
#######################
tell application id "com.adobe.Reader"
	activate
	##ファイルパス
	tell active doc
		set aliasFilePath to file alias
	end tell
	##開いているファイルのページ数
	tell active doc
		set numCntAllPage to (count every page) as integer
	end tell
	##表示中のページ番号
	tell active doc
		tell front PDF Window
			set numNowPage to page number as integer
		end tell
	end tell
end tell
#######################
set ocidArrayM to refMe's NSMutableArray's alloc()'s initWithCapacity:(0)
repeat with itemIntNo from 1 to (numCntAllPage as integer) by 1
	(ocidArrayM's addObject:(itemIntNo))
end repeat
set listArrayM to ocidArrayM as list
#####ダイアログを前面に
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
	set strTitle to "選んでください" as text
	set strPrompt to "削除するページを選んでください（複数可）" as text
	set listResponse to (choose from list listArrayM with title strTitle with prompt strPrompt default items (item numNowPage of listArrayM) OK button name "OK" cancel button name "キャンセル" with multiple selections allowed without empty selection allowed) as list
on error
	log "エラーしました"
	return "エラーしました"
	error "エラーしました" number -200
end try
if listResponse = {} then
	log "何も選択していない"
	return "何も選択していない"
else if (item 1 of listResponse) is false then
	return "キャンセルしました"
	error "キャンセルしました" number -200
end if
##################################
####一旦閉じる
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
	end tell
	close objAvtivDoc
end tell

#######################
#####降順処理用に並び替える
#######################
set ocidPageNoArray to refMe's NSMutableArray's alloc()'s initWithCapacity:0
ocidPageNoArray's setArray:(listResponse)
###逆順
set ocidDescriptor to refMe's NSSortDescriptor's sortDescriptorWithKey:(missing value) ascending:false
set ocidSortArray to ocidPageNoArray's sortedArrayUsingDescriptors:{ocidDescriptor}

#######################
#####本処理
#######################
####パス
set strFilePath to (POSIX path of aliasFilePath) as text
set ocidFilePathStr to refMe's NSString's stringWithString:strFilePath
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
set ocidFilePathURL to refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath

####PDFファイルを格納
set ocidPDFDocument to refMe's PDFDocument's alloc()'s initWithURL:ocidFilePathURL
set listPageNo to ocidSortArray as list
###削除するページ数
set numCntDelPege to (count of listPageNo) as integer
###リスト取得用のカウンタ
set numChkListNo to 1 as integer
###リストの数だけ繰り返し
repeat numCntDelPege times
	###削除するページ番号取得
	set numDelPage to (item numChkListNo of listPageNo) as integer
	###0スタートの数値のためマイナス１
	set numDelPageJs to numDelPage - 1 as integer
	###対象ページ削除
	ocidPDFDocument's removePageAtIndex:numDelPageJs
	###リスト取得用数値のカウントアップ
	set numChkListNo to numChkListNo + 1 as integer
end repeat

#################################
#####保存する　削除したので保存して
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

