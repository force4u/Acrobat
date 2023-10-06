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
	set aliasFile to (choose file with prompt "ファイルを選んでください" default location (path to desktop folder from user domain) of type {"com.adobe.pdf"} with invisibles and showing package contents without multiple selections allowed) as alias
	-->alias
	set strFilePath to POSIX path of aliasFile
end if

####ドキュメントのパスをNSString
set ocidFilePath to refMe's NSString's stringWithString:strFilePath
####ドキュメントのパスをNSURLに
set ocidNSUrlPath to refMe's NSURL's fileURLWithPath:ocidFilePath
####PDFファイルを格納
set ocidPDFDocument to refMe's PDFDocument's alloc()'s initWithURL:ocidNSUrlPath
###################################
###ページの回転が全ページ同じかチェック
set numOrgPdfPageCnt to ocidPDFDocument's pageCount()
###１ページ目のページオブジェクト
set ocidPdfPageObj to (ocidPDFDocument's pageAtIndex:0)
####１ページ目の回転を確認
set numFirstPageRotation to (ocidPdfPageObj's |rotation|()) as integer
###比較用のページ番号
set numCntPageNo to 1 as integer
###
repeat (numOrgPdfPageCnt - 1) times
	###ページオブジェクト
	set ocidPdfPageObj to (ocidPDFDocument's pageAtIndex:(numCntPageNo))
	###ページの回転
	set numPageRotation to (ocidPdfPageObj's |rotation|()) as integer
	###1ページ目の回転と違っているページがあれば処理終了
	if numPageRotation ≠ numFirstPageRotation then
		return "ページ個別に回転方向が違うページがあるので処理できません"
	end if
	###カウントアップ
	set numCntPageNo to (numCntPageNo + 1) as integer
end repeat

log "全ページ同じ回転方向を確認しました"
###################################
###前処理で取得したページの回転
set numPageRotation to numFirstPageRotation as integer
####ページ数を数える
set numOrgPdfPageCnt to ocidPDFDocument's pageCount()
####最後のページから逆順に処理する（0ベースページ数なので１引く）
set numCntPageNo to 0 as number
####ページ数だけ繰り返し
repeat numOrgPdfPageCnt times
	#####ページをocidPdfPageObjに格納
	set ocidPdfPageObj to (ocidPDFDocument's pageAtIndex:numCntPageNo)
	--> ocidPdfPageObjにPDF書類の各ページが順番に入ります
	#####ocidPdfPageObjの各種サイズを取得
	###メディアサイズ＝一般的には用紙サイズ
	set ocidListPDFMediaBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxMediaBox))
	#### CGRect
	(*
https://developer.apple.com/documentation/corefoundation/cgrect
{{origin-x,origin-y},{size-w,size-h}}
↑このようにorigin=起点情報のリスト
と
幅と高さのsize情報のリストの２要素もったリスト
-->２つのリストを内包したリスト形式になります
*)
	#####################
	### メディアサイズ=用紙サイズの起点を取得（基本0,0なはず）
	set numOriginX to (item 1 of (item 1 of ocidListPDFMediaBox) as list) as number
	set numOriginY to (item 2 of (item 1 of ocidListPDFMediaBox) as list) as number
	### メディアサイズ=用紙サイズの縦横を取得 ptサイズ
	set numMediaWPt to (item 1 of (item 2 of ocidListPDFMediaBox) as list) as number
	set numMediaHPt to (item 2 of (item 2 of ocidListPDFMediaBox) as list) as number
	#####################
	###  塗りたしがあるようなデータは処理せず止める
	### not イコールは /= と入力すると　≠　になるよ
	if numOriginX ≠ 0 then
		return "メディア原点Xが０以外"
	end if
	if numOriginY ≠ 0 then
		return "メディア原点Yが０以外"
	end if
	log "x" & numOriginX
	log "y: " & numOriginY
	log "w: " & numMediaWPt
	log "h: " & numMediaHPt
	log "r: " & numPageRotation
	#####################
	(*
1 mm = 2.8346456693 point
1 point0.3527777778 mm
*)
	## 変更後のサイズサイズ
	if numPageRotation = 0 then
		set strSaveWPt to (numMediaWPt * 2) as number
		set strSaveHPt to (numMediaHPt) as number
	else if numPageRotation = 180 then
		set strSaveWPt to (numMediaWPt * 2) as number
		set strSaveHPt to (numMediaHPt) as number
		##
	else if numPageRotation = 90 then
		set strSaveWPt to (numMediaWPt) as number
		set strSaveHPt to (numMediaHPt * 2) as number
	else if numPageRotation = 270 then
		set strSaveWPt to (numMediaWPt) as number
		set strSaveHPt to (numMediaHPt * 2) as number
	end if
	
	
	#############################################
	set listSaveMediaBoxDimention to {{numOriginX, numOriginY}, {strSaveWPt, strSaveHPt}} as list
	set ocidPdfDimention to refMe's NSArray's arrayWithArray:(listSaveMediaBoxDimention)
	
	#############################################
	###↑ここで決めたメディアサイズのサイズの値
	set numPdfDimentionWPt to (item 1 of (item 2 of ocidPdfDimention) as list) as number
	set numPdfDimentionHPt to (item 2 of (item 2 of ocidPdfDimention) as list) as number
	###差分を計算
	set numDiffwPt to (numPdfDimentionWPt - numMediaWPt) as number
	set numDiffhPt to (numPdfDimentionHPt - numMediaHPt) as number
	###
	if numPageRotation = 0 then
		set listDiffMediaBoxDimention to {{-numDiffwPt, -numDiffhPt}, {numPdfDimentionWPt, numPdfDimentionHPt}} as list
	else if numPageRotation = 180 then
		set listDiffMediaBoxDimention to {{0, 0}, {numPdfDimentionWPt, numPdfDimentionHPt}} as list
		##
	else if numPageRotation = 90 then
		set listDiffMediaBoxDimention to {{-numDiffwPt, -numDiffhPt}, {numPdfDimentionWPt, numPdfDimentionHPt}} as list
	else if numPageRotation = 270 then
		set listDiffMediaBoxDimention to {{0, 0}, {numPdfDimentionWPt, numPdfDimentionHPt}} as list
	end if
	
	set ocidPdfDimentionDiff to refMe's NSArray's arrayWithArray:listDiffMediaBoxDimention
	#############################################
	###MediaBox
	###メディアサイズ＝一般的には用紙サイズ
	ocidPdfPageObj's setBounds:ocidPdfDimentionDiff forBox:(refMe's kPDFDisplayBoxMediaBox)
	##########################################
	### Crop
	###トリミングサイズ=表示サイズ=可視領域
	-->あくまでも『画面表示』されるエリアの指定で他の値とは別
	-->通常印刷されるエリアはこれ=等落としサイズが望ましい
	ocidPdfPageObj's setBounds:ocidPdfDimentionDiff forBox:(refMe's kPDFDisplayBoxCropBox)
	#######################################
	####ここでMediaBox用紙サイズは変更済み
	#######################################
	###変更後のMediaBox用紙サイズを再取得
	set ocidListPDFMediaBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxMediaBox))
	set numPdfMediaBoxDimentionWPt to (item 1 of (item 2 of ocidListPDFMediaBox) as list) as number
	set numPdfMediaBoxDimentionHPt to (item 2 of (item 2 of ocidListPDFMediaBox) as list) as number
	##########################################
	###TrimBox
	###立落としサイズ（仕上がりサイズ）
	set ocidListPDFTrimBox to (ocidPdfPageObj's boundsForBox:(refMe's kPDFDisplayBoxTrimBox))
	#############################################
	### メディアサイズ=用紙サイズの起点を取得（基本0,0なはず）
	set numOriginTrimBoxX to (item 1 of (item 1 of ocidListPDFTrimBox) as list) as number
	set numOriginTrimBoxY to (item 2 of (item 1 of ocidListPDFTrimBox) as list) as number
	### メディアサイズ=用紙サイズの縦横を取得 ptサイズ
	set numTrimBoxWPt to (item 1 of (item 2 of ocidListPDFTrimBox) as list) as number
	set numTrimBoxHPt to (item 2 of (item 2 of ocidListPDFTrimBox) as list) as number
	##########################################
	###BleedBox
	###塗り足しサイズ（通常3mm程度）
	###塗り足し寸法
	set numBleedmm to 3 as number
	##Pt換算
	set numBleedmmPt to (numBleedmm * 2.8346456693) as number
	###メディアサイズー塗り足しサイズ➗2(余白は左右あるからね）=片方の余白
	set strOriginBleedBoxX to (numOriginTrimBoxX - numBleedmmPt) as number
	set strOriginBleedBoxY to (numOriginTrimBoxY - numBleedmmPt) as number
	###Trimサイズ=仕上がり寸法に塗り足しを足す
	set numBleedwPt to numTrimBoxWPt + (numBleedmmPt * 2) as number
	set numBleedhPt to numTrimBoxHPt + (numBleedmmPt * 2) as number
	set listDiffBleedBoxDimention to {{strOriginBleedBoxX, strOriginBleedBoxY}, {numBleedwPt, numBleedhPt}} as list
	set ocidPdfBleedBoxDimention to refMe's NSArray's arrayWithArray:listDiffBleedBoxDimention
	###塗り足しサイズを設定
	ocidPdfPageObj's setBounds:ocidPdfBleedBoxDimention forBox:(refMe's kPDFDisplayBoxBleedBox)
	
	
	
	#####ページカウントアップ
	set numCntPageNo to numCntPageNo + 1 as number
end repeat

####保存
ocidPDFDocument's writeToURL:(ocidNSUrlPath)

tell application id "com.adobe.Reader"
	launch
	activate
	open (ocidNSUrlPath as alias)
end tell