#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#	com.adobe.distiller
#	com.adobe.Acrobat.Pro
#	com.adobe.Reader
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
#####Acraobatでのページ指定
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
##################################
####変更箇所は保存
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
	###close objAvtivDoc
end tell
#######################
#####本処理
#######################
####入力PDFパス
set strFilePath to (POSIX path of aliasFilePath) as text
set ocidFilePathStr to refMe's NSString's stringWithString:strFilePath
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
set ocidFilePathURL to refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath
set ocidContainerDirURL to ocidFilePathURL's URLByDeletingLastPathComponent()

####PDFファイルを格納
set ocidActiveDoc to refMe's PDFDocument's alloc()'s initWithURL:ocidFilePathURL
###対象のページを取り出して
set ocidExtractPage to ocidActiveDoc's pageAtIndex:(numNowPage - 1)
###メタデータも取り出し
set ocidActiveDocAttrDict to ocidActiveDoc's documentAttributes()

####################################
###新しいPDFドキュメントを作成して
set ocidSaveDoc to refMe's PDFDocument's alloc()'s init()
###取り出したページを挿入
ocidSaveDoc's insertPage:ocidExtractPage atIndex:0

####################################
###メタデータも移す
set ocidSetAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0

if (ocidActiveDocAttrDict's valueForKey:"Author") is not missing value then
	ocidSetAttrDict's setValue:(ocidActiveDocAttrDict's valueForKey:"Author") forKey:"Author"
end if
if (ocidActiveDocAttrDict's valueForKey:"Title") is not missing value then
	ocidSetAttrDict's setValue:(ocidActiveDocAttrDict's valueForKey:"Title") forKey:"Title"
end if
if (ocidActiveDocAttrDict's valueForKey:"Subject") is not missing value then
	ocidSetAttrDict's setValue:(ocidActiveDocAttrDict's valueForKey:"Subject") forKey:"Subject"
end if
if (ocidActiveDocAttrDict's valueForKey:"Keywords") is not missing value then
	ocidSetAttrDict's setValue:(ocidActiveDocAttrDict's valueForKey:"Keywords") forKey:"Keywords"
end if

set ocidSaveDoc's documentAttributes to ocidSetAttrDict

###########################
###元PDFのファイル名
set ocidFileName to ocidFilePathURL's lastPathComponent()
###拡張子をとったベースファイル名
set strBaseFileName to (ocidFileName's stringByDeletingPathExtension()) as text
###ページ番号をゼロサプレス
set strZeroAdd to ("000" & numNowPage) as text
set strPageNo to (text -3 through -1 of strZeroAdd) as text
###保存ファイル名
set strSaveFileName to (strBaseFileName & "." & strZeroAdd & ".pdf") as text
set ocidSaveFilePathURL to ocidContainerDirURL's URLByAppendingPathComponent:strSaveFileName isDirectory:false

#################################
#####保存
#################################
ocidSaveDoc's writeToURL:(ocidSaveFilePathURL)
delay 1
set aliasSaveFilePathURL to ocidSaveFilePathURL as alias
set strSaveFilePath to (ocidSaveFilePathURL's |path|()) as text
#################################
#####アクロバットで開く
#################################
##JSで開いてエラーならASで開く
tell application id "com.adobe.Reader"
	activate
	try
		do script "app.openDoc(\"" & strSaveFilePath & "\");"
	on error
		open file aliasSaveFilePathURL
	end try
end tell

