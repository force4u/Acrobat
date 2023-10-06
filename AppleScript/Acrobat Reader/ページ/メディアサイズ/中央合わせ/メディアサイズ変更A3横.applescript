#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
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
use framework "CoreGraphics"

property refMe : a reference to current application

####何が前面か
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
else if strAppTitile is "Acrobat Reader" then
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
	###ダイアログを前面に出す
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
	set aliasFile to (choose file with prompt "ファイルを選んでください" default location (path to desktop folder from user domain) of type {"com.adobe.pdf"} with invisibles and showing package contents without multiple selections allowed) as alias
	-->alias
	set strFilePath to POSIX path of aliasFile as text
end if


set ocidFilePathStr to refMe's NSString's stringWithString:strFilePath
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
set ocidFilePathURL to refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath

set ocidContainerDirURL to ocidFilePathURL's URLByDeletingLastPathComponent()
set ocidFileName to ocidFilePathURL's lastPathComponent()
set strBaseFileName to ocidFileName's stringByDeletingPathExtension() as text
set strExtensionName to ocidFilePathURL's pathExtension() as text

set strDefaultName to (strBaseFileName & ".A3." & strExtensionName) as text
set strPromptText to "名前を決めてください"
set strPromptMes to "名前を決めてください"
set aliasDefaultLocation to ocidContainerDirURL as alias
set aliasSaveFilePath to (choose file name strPromptMes default location aliasDefaultLocation default name strDefaultName with prompt strPromptText) as «class furl»

set strSaveFilePath to POSIX path of aliasSaveFilePath as text
set ocidSaveFilePathStr to refMe's NSString's stringWithString:strSaveFilePath
set ocidSaveFilePath to ocidSaveFilePathStr's stringByStandardizingPath
set ocidSaveFilePathURL to refMe's NSURL's alloc()'s initFileURLWithPath:ocidSaveFilePath
set ocdiSaveDoc to refMe's PDFDocument's alloc()'s init()


###################################
###### A3 横size
###################################
set numWpt to 1190 as integer
set numHpt to 842 as integer
#set ocidNewRect to refMe's CGRectMake(0, 0, 841.8897638, 1190.5511811)
set ocidA3Rect to refMe's CGRectMake(0, 0, numWpt, numHpt)
##########################################
###BleedBox塗り足し寸法 塗り足しサイズ（通常3mm程度）
set numBleedmm to 3 as number
##Pt換算
set numBleedPt to (numBleedmm * 2.8346456693) * 2 as integer
###################################
###### 元のPDF
###################################
set ocidActivDoc to refMe's PDFDocument's alloc()'s initWithURL:ocidFilePathURL
####ページ数を数える
set numOrgPdfPageCnt to ocidActivDoc's pageCount()
##処理ページ番号初期化
set numCntPageNo to 0 as number
###ページ数分繰り返し
repeat numOrgPdfPageCnt times
	##ページ取得
	set ocidPdfPageObj to (ocidActivDoc's pageAtIndex:numCntPageNo)
	####現在の回転を確認
	set numPageRotation to ocidPdfPageObj's |rotation|() as integer
	log numPageRotation
	###メディアサイズ＝一般的には用紙サイズ
	set ocidMediaBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxMediaBox))
	###Rect各値を取得
	set numMaxX to refMe's CGRectGetMaxX(ocidMediaBox)
	set numMaxY to refMe's CGRectGetMaxY(ocidMediaBox)
	###塗り足しサイズ
	set ocidBleedBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxBleedBox))
	set numBleedWidth to refMe's CGRectGetWidth(ocidBleedBox)
	set ocidTrimBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxTrimBox))
	set numTrimWidth to refMe's CGRectGetWidth(ocidTrimBox)
	####Cropサイズ
	set ocidCropBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxCropBox))
	set numCropWidth to refMe's CGRectGetWidth(ocidCropBox)
	set numCropHeight to refMe's CGRectGetHeight(ocidCropBox)
	####塗り足しチェック
	if numTrimWidth < numBleedWidth then
		log "BleedBox塗り足し設定済み"
		set ocidBleedRect to ocidBleedBox
	else if numTrimWidth = numBleedWidth then
		log "BleedBox塗り足し無し"
		set ocidBleedRect to refMe's CGRectMake(-(numBleedPt / 2), -(numBleedPt / 2), (numCropWidth + numBleedPt), (numCropHeight + numBleedPt))
	else
		log "BleedBoxに不具合がある"
		set ocidBleedRect to refMe's CGRectMake(-(numBleedPt / 2), -(numBleedPt / 2), (numCropWidth + numBleedPt), (numCropHeight + numBleedPt))
	end if
	
	####
	if numPageRotation = 90 then
		set numNewX to (numWpt - numMaxY) / 2 as integer
		set numNewY to (numHpt - numMaxX) / 2 as integer
		set ocidNewRect to refMe's CGRectMake(-numNewY, -numNewX, numHpt, numWpt)
		
	else if numPageRotation = 270 then
		set numNewX to (numWpt - numMaxY) / 2 as integer
		set numNewY to (numHpt - numMaxX) / 2 as integer
		set ocidNewRect to refMe's CGRectMake(-numNewY, -numNewX, numHpt, numWpt)
	else
		set numNewX to (numWpt - numMaxX) / 2 as integer
		set numNewY to (numHpt - numMaxY) / 2 as integer
		set ocidNewRect to refMe's CGRectMake(-numNewX, -numNewY, numWpt, numHpt)
		
		
	end if
	ocidPdfPageObj's setBounds:ocidNewRect forBox:(refMe's kPDFDisplayBoxMediaBox)
	ocidPdfPageObj's setBounds:ocidNewRect forBox:(refMe's kPDFDisplayBoxCropBox)
	ocidPdfPageObj's setBounds:ocidBleedRect forBox:(refMe's kPDFDisplayBoxBleedBox)
	####
	set numCntPageNo to numCntPageNo + 1 as number
	
end repeat

ocidActivDoc's writeToURL:ocidSaveFilePathURL


if strAppTitile is "プレビュー" then
	tell application "Preview"
		launch
		activate
		open (ocidSaveFilePathURL as alias)
	end tell
else if strAppTitile is "Acrobat Reader" then
	tell application id "com.adobe.Reader"
		launch
		activate
		open (ocidSaveFilePathURL as alias)
	end tell
else
	tell application "Preview"
		launch
		activate
		open (ocidSaveFilePathURL as alias)
	end tell
end if