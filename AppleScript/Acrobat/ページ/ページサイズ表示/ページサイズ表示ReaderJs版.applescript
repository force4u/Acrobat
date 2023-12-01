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
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

## 		"com.adobe.Acrobat.Pro" 
##		"com.adobe.Reader" 

tell application id "com.adobe.Reader"
	##activate
	tell active doc
		tell front PDF Window
			try
				set numAllPages to count of every page
			on error
				display alert "エラー:pdfを開いていません" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 10
				return
			end try
		end tell
	end tell
end tell

#####表示中のページの回転
tell application id "com.adobe.Reader"
	##activate
	tell active doc
		tell front PDF Window
			tell front page
				set numRotation to rotation
			end tell
		end tell
	end tell
end tell


tell application id "com.adobe.Reader"
	tell active doc
		do script ("var numPageNo = this.pageNum;")
		
		##ピクセル情報からミリ情報に変換用の変数　=1/72*25.4
		do script ("var px2mm = 0.352778;")
		
		do script ("var numRotat = this.getPageRotation(numPageNo);")
		
		do script ("var MediaBoxSize = this.getPageBox(\"Media\", numPageNo);")
		do script ("var BleedBoxSize = this.getPageBox(\"Bleed\", numPageNo);")
		do script ("var TrimBoxSize = this.getPageBox(\"Trim\", numPageNo);")
		do script ("var CropBoxSize = this.getPageBox(\"Crop\", numPageNo);")
		do script ("var ArtBoxSize = this.getPageBox(\"Art\", numPageNo);")
		do script ("var BoundingBoxBoxSize = this.getPageBox(\"BBox\", numPageNo);")
		
		
		do script ("var MediaBoxSizeWidth = MediaBoxSize[2] - MediaBoxSize[0];")
		do script ("var MediaBoxSizeHeight = MediaBoxSize[1] - MediaBoxSize[3];")
		do script ("var BleedBoxSizeWidth = BleedBoxSize[2] - BleedBoxSize[0];")
		do script ("var BleedBoxSizeHeight = BleedBoxSize[1] - BleedBoxSize[3];")
		do script ("var TrimBoxSizeWidth = TrimBoxSize[2] - TrimBoxSize[0];")
		do script ("var TrimBoxSizeHeight = TrimBoxSize[1] - TrimBoxSize[3];")
		do script ("var CropBoxSizeWidth = CropBoxSize[2] - CropBoxSize[0];")
		do script ("var CropBoxSizeHeight = CropBoxSize[1] - CropBoxSize[3];")
		do script ("var ArtBoxSizeWidth = ArtBoxSize[2] - ArtBoxSize[0];")
		do script ("var ArtBoxSizeHeight = ArtBoxSize[1] - ArtBoxSize[3];")
		do script ("var BoundingBoxWidth = BoundingBoxBoxSize[2] - BoundingBoxBoxSize[0];")
		do script ("var BoundingBoxHeight = BoundingBoxBoxSize[1] - BoundingBoxBoxSize[3];")
		
		do script ("MediaSizeWidth = (Math.round(MediaBoxSizeWidth*px2mm*10))/10;")
		do script ("MediaSizeHeight = (Math.round(MediaBoxSizeHeight*px2mm*10))/10;")
		do script ("BleedSizeWidth = (Math.round(BleedBoxSizeWidth*px2mm*10))/10;")
		do script ("BleedSizeHeight = (Math.round(BleedBoxSizeHeight*px2mm*10))/10;")
		do script ("TrimSizeWidth = (Math.round(TrimBoxSizeWidth*px2mm*10))/10;")
		do script ("TrimSizeHeight = (Math.round(TrimBoxSizeHeight*px2mm*10))/10;")
		do script ("CropSizeWidth = (Math.round(CropBoxSizeWidth*px2mm*10))/10;")
		do script ("CropSizeHeight = (Math.round(CropBoxSizeHeight*px2mm*10))/10;")
		do script ("ArtSizeWidth = (Math.round(ArtBoxSizeWidth*px2mm*10))/10;")
		do script ("ArtSizeHeight = (Math.round(ArtBoxSizeHeight*px2mm*10))/10;")
		do script ("BoundingWidth = (Math.round(BoundingBoxWidth*px2mm*10))/10;")
		do script ("BoundingHeight = (Math.round(BoundingBoxHeight*px2mm*10))/10;")
		
		set numMediaWpt to do script ("MediaBoxSize[2] - MediaBoxSize[0];")
		set numMediaHpt to do script ("MediaBoxSize[1] - MediaBoxSize[3];")
		set numBleedWpt to do script ("BleedBoxSize[2] - BleedBoxSize[0];")
		set numBleedHpt to do script ("BleedBoxSize[1] - BleedBoxSize[3];")
		set numTrimWpt to do script ("TrimBoxSize[2] - TrimBoxSize[0];")
		set numTrimHpt to do script ("TrimBoxSize[1] - TrimBoxSize[3];")
		set numCropWpt to do script ("CropBoxSize[2] - CropBoxSize[0];")
		set numCropHpt to do script ("CropBoxSize[1] - CropBoxSize[3];")
		do script ("var ArtBoxSizeWidth = ArtBoxSize[2] - ArtBoxSize[0];")
		do script ("var ArtBoxSizeHeight = ArtBoxSize[1] - ArtBoxSize[3];")
		do script ("var BoundingBoxWidth = BoundingBoxBoxSize[2] - BoundingBoxBoxSize[0];")
		do script ("var BoundingBoxHeight = BoundingBoxBoxSize[1] - BoundingBoxBoxSize[3];")
		
		
		set numChkM0 to do script ("MediaBoxSize[0];")
		set numChkM3 to do script ("MediaBoxSize[3];")
		set numChkB0 to do script ("BleedBoxSize[0];")
		set numChkB3 to do script ("BleedBoxSize[3];")
		set numChkT0 to do script ("TrimBoxSize[0];")
		set numChkT3 to do script ("TrimBoxSize[3];")
		set numChkC0 to do script ("CropBoxSize[0];")
		set numChkC3 to do script ("CropBoxSize[3];")
		
		
	end tell
end tell



set numMediaWpt to ((round ((numMediaWpt) * 100)) / 100) as number
set numMediaWmm to ((round ((numMediaWpt / 2.8346) * 100)) / 100) as text
set numMediaHpt to ((round ((numMediaHpt) * 100)) / 100) as number
set numMediaHmm to ((round ((numMediaHpt / 2.8346) * 100)) / 100) as text

set numBleedWpt to ((round ((numBleedWpt) * 100)) / 100) as number
set numBleedWmm to ((round ((numBleedWpt / 2.8346) * 100)) / 100) as text
set numBleedHpt to ((round ((numBleedHpt) * 100)) / 100) as number
set numBleedHmm to ((round ((numBleedHpt / 2.8346) * 100)) / 100) as text

set numTrimWpt to ((round ((numTrimWpt) * 100)) / 100) as number
set numTrimWmm to ((round ((numTrimWpt / 2.8346) * 100)) / 100) as text
set numTrimHpt to ((round ((numTrimHpt) * 100)) / 100) as number
set numTrimHmm to ((round ((numTrimHpt / 2.8346) * 100)) / 100) as text

set numCropWpt to ((round ((numCropWpt) * 100)) / 100) as number
set numCropWmm to ((round ((numCropWpt / 2.8346) * 100)) / 100) as text
set numCropHpt to ((round ((numCropHpt) * 100)) / 100) as number
set numCropHmm to ((round ((numCropHpt / 2.8346) * 100)) / 100) as text


set strMediaText to ("MediaPT: " & numMediaWpt & "x" & numMediaHpt & "\rMediaMM: " & numMediaWmm & "x" & numMediaHmm & "\r\r") as text
set strBleedText to ("BleedPT: " & numBleedWpt & "x" & numBleedHpt & "\rBleedMM: " & numBleedWmm & "x" & numBleedHmm & "\r\r") as text
set strTrimText to ("TrimPT: " & numTrimWpt & "x" & numTrimHpt & "\rTrimMM: " & numTrimWmm & "x" & numTrimHmm & "\r\r") as text
set strCropText to ("CropPT: " & numCropWpt & "x" & numCropHpt & "\rCropMM: " & numCropWmm & "x" & numCropHmm & "\r\r") as text
set strRotationText to ("Rotation: " & numRotation & "\r") as text


set strMes to (strMediaText & strBleedText & strTrimText & strCropText & strRotationText) as text

if ((numChkM0) + (numChkM3)) ≠ 0 then
	set strMes to strMes & "表示外の領域があります（Mediaサイズ）\r" as text
end if
if ((numChkB0) + (numChkB3)) ≠ 0 then
	set strMes to strMes & "表示外の領域があります（BleedBoxサイズ）\r" as text
end if
if ((numChkT0) + (numChkT3)) ≠ 0 then
	set strMes to strMes & "表示外の領域があります（Trimサイズ）\r" as text
end if
if ((numChkC0) + (numChkC3)) ≠ 0 then
	set strMes to strMes & "表示外の領域があります（Cropサイズ）\r" as text
end if




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
set aliasIconPath to POSIX file "/System/Applications/Preview.app/Contents/Resources/AppIcon.icns" as alias
try
	set recordResponse to (display dialog strMes with title "ページサイズです" default answer strMes buttons {"クリップボードにコピー", "キャンセル", "OK"} default button "OK" cancel button "キャンセル" with icon aliasIconPath giving up after 20 without hidden answer)
	
on error
	log "エラーしました"
	return "エラーしました"
end try
if true is equal to (gave up of recordResponse) then
	return "時間切れですやりなおしてください"
end if
if "OK" is equal to (button returned of recordResponse) then
	set strResponse to (text returned of recordResponse) as text
	
	###クリップボードコピー
else if button returned of recordResponse is "クリップボードにコピー" then
	set strText to text returned of recordResponse as text
	####ペーストボード宣言
	set appPasteboard to refMe's NSPasteboard's generalPasteboard()
	set ocidText to (refMe's NSString's stringWithString:(strText))
	appPasteboard's clearContents()
	appPasteboard's setString:(ocidText) forType:(refMe's NSPasteboardTypeString)
else
	log "キャンセルしました"
	return "キャンセルしました"
end if


return

