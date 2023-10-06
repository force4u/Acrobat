#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#	
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.6"
use framework "Foundation"
use framework "Quartz"
use framework "QuartzCore"
use framework "PDFKit"
use framework "AppKit"
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

##################################
#### ページ数を数える
##################################
tell application id "com.adobe.Reader"
	set objActDoc to active doc
	tell objActDoc
		set numAllPageNo to (count each page) as integer
	end tell
end tell

##################################
#### ファイルパス
##################################
tell application id "com.adobe.Reader"
	set objActDoc to active doc
	tell objActDoc
		set aliasFilePath to file alias as alias
	end tell
end tell
set strFilePath to (POSIX path of aliasFilePath) as text
set ocidFilePathStr to refMe's NSString's stringWithString:strFilePath
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
set ocidFilePathURL to refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath

#######################################
#### ページ順に回転を調べてlistPageRotationに格納
#######################################
set listPageRotation to {} as list
set numCntPage to 1 as integer
repeat numAllPageNo times
	tell application id "com.adobe.Reader"
		tell front PDF Window
			tell page numCntPage
				set numRotation to rotation as integer
			end tell
		end tell
	end tell
	copy numRotation to end of listPageRotation
	set numCntPage to numCntPage + 1 as integer
end repeat

##################################
#### とりあえず保存が必要なら保存
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

##################################
#### 本処理
##################################
####読み込み
set ocidPDFDocument to refMe's PDFDocument's alloc()'s initWithURL:ocidFilePathURL
####念の為ページ数
set numAllPage to (ocidPDFDocument's pageCount()) as integer
####ページカウンター
set numChkPage to 1 as number
set numChkPageJs to numChkPage - 1 as number


####ページ数だけ繰り返し
repeat numAllPage times
	###ページオブジェクトを取得
	set ocidPdfPage to (ocidPDFDocument's pageAtIndex:numChkPageJs)
	###元のページ回転を取得
	set numChgRotation to (item numChkPage of listPageRotation) as integer
	###ページ回転設定する
	ocidPdfPage's setRotation:numChgRotation
	####カウントアップ
	set numChkPage to numChkPage + 1 as number
	set numChkPageJs to numChkPageJs + 1 as number
end repeat

#####保存
ocidPDFDocument's writeToURL:(ocidFilePathURL)



##################################
#### 保存済みファイルを開く
##################################
tell application id "com.adobe.Reader"
	open aliasFilePath
end tell
