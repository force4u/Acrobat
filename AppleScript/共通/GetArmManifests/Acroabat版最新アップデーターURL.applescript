#! /usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
(*
従来版のAcrobat 製品版の
最新アップデーターのURLを取得します
SCA版を利用の場合はこちらを
https://quicktimer.cocolog-nifty.com/icefloe/2024/06/post-d64536.html
com.cocolog-nifty.quicktimer.icefloe *)
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

property refNSNotFound : a reference to 9.22337203685477E+18 + 5807


##############################
#ダウンロードするURL
set ocidURLComponents to refMe's NSURLComponents's alloc()'s init()
ocidURLComponents's setScheme:"https"
ocidURLComponents's setHost:"armmf.adobe.com"
ocidURLComponents's setPath:"/arm-manifests/mac/AcrobatDC/acrobat/AcrobatManifest.arm"
set ocidURLStrings to ocidURLComponents's |URL|'s absoluteString()
set ocidURL to refMe's NSURL's alloc()'s initWithString:(ocidURLStrings)
log ocidURL's absoluteString() as text

##############################
#起動時に削除される項目にダウンロード
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidTempDirURL to appFileManager's temporaryDirectory()
set ocidUUID to refMe's NSUUID's alloc()'s init()
set ocidUUIDString to ocidUUID's UUIDString
set ocidSaveDirPathURL to ocidTempDirURL's URLByAppendingPathComponent:(ocidUUIDString) isDirectory:(true)
#フォルダを作っておく
set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
ocidAttrDict's setValue:(511) forKey:(refMe's NSFilePosixPermissions)
set listDone to appFileManager's createDirectoryAtURL:(ocidSaveDirPathURL) withIntermediateDirectories:(true) attributes:(ocidAttrDict) |error|:(reference)
if (item 1 of listDone) is true then
	log "createDirectoryAtURL 正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "createDirectoryAtURL エラーしました"
end if
#保存パス
set strSaveFileName to "AcrobatManifest.pkg" as text
set ocidSaveFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:(strSaveFileName) isDirectory:(false)

##############################
#NSDATAでダウンロード
set ocidOption to (refMe's NSDataReadingMappedIfSafe)
set listResponse to refMe's NSData's alloc()'s initWithContentsOfURL:(ocidURL) options:(ocidOption) |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	log "正常処理"
	set ocidReadData to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	log (item 2 of listResponse)'s code() as text
	log (item 2 of listResponse)'s localizedDescription() as text
	return "エラーしました"
end if

##############################
#保存
set ocidOption to (refMe's NSDataWritingAtomic)
set listDone to ocidReadData's writeToURL:(ocidSaveFilePathURL) options:(ocidOption) |error|:(reference)
if (item 1 of listDone) is true then
	log "正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "エラーしました"
end if
##############################
#PKG解凍
set strPkgPath to (ocidSaveFilePathURL's |path|()) as text
#解凍先
set ocidDistDirPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("UnArchived") isDirectory:(true)
set strDistPath to (ocidDistDirPathURL's |path|()) as text
#コマンド実行
set strComandText to ("/usr/sbin/pkgutil  --expand  \"" & strPkgPath & "\" \"" & strDistPath & "\"") as text
log strComandText
try
	do shell script strComandText
on error
	return "pkgutilでエラーになりました"
end try

##############################
#マニフェスト読み込み
#XMLパス
set ocidXmlFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("UnArchived/ASSET/AcrobatManifest.xml") isDirectory:(true)
##############################
#NSDATAに読み込み
set ocidOption to (refMe's NSDataReadingMappedIfSafe)
set listResponse to refMe's NSData's alloc()'s initWithContentsOfURL:(ocidXmlFilePathURL) options:(ocidOption) |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	log "initWithContentsOfURL　正常処理"
	set ocidReadData to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	log (item 2 of listResponse)'s code() as text
	log (item 2 of listResponse)'s localizedDescription() as text
	return "initWithContentsOfURL　エラーしました"
end if
##############################
#XMLに読み込む
set ocidOption to (refMe's NSXMLNodePreserveAll) + (refMe's NSXMLDocumentTidyHTML)
set listResponse to refMe's NSXMLDocument's alloc()'s initWithData:(ocidReadData) options:(ocidOption) |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	log "initWithData　正常処理"
	set ocidXMLDoc to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	log (item 2 of listResponse)'s code() as text
	log (item 2 of listResponse)'s localizedDescription() as text
	log "initWithData　エラー 警告がありました"
	set ocidXMLDoc to (item 1 of listResponse)
end if
##############################
#出力用テキスト
set ocidOutPutstring to refMe's NSMutableString's alloc()'s initWithCapacity:(0)
ocidOutPutstring's appendString:("従来版 Acrobatの最新パッチURL\n\n")
set strSetInfoStr to ("Patch_Incr:差分パッチ\nPatch_Cumulative:累積パッチ\ndInstaller_Full:新規インストーラー\ndropXXXX:公開日別") as text
ocidOutPutstring's appendString:(strSetInfoStr)
ocidOutPutstring's appendString:("\n")
##############################
#XML解析
#ROOT
set ocidRootElement to ocidXMLDoc's rootElement()
set ocidActionItemsArray to ocidRootElement's elementsForName:("DownloadActionItems")
set ocidActionItems to ocidActionItemsArray's firstObject()
set ocidItemArray to (ocidActionItems's elementsForName:("dItem"))
repeat with itemArray in ocidItemArray
	(ocidOutPutstring's appendString:("----+----1----+----2----+-----3----+----4----+----5----+----6----+----7"))
	(ocidOutPutstring's appendString:("\n"))
	set ocidID to (itemArray's attributeForName:("id"))'s stringValue()
	(ocidOutPutstring's appendString:(ocidID))
	(ocidOutPutstring's appendString:("\n"))
	#URL
	set ocidHost to (itemArray's attributeForName:("httpURLBase"))'s stringValue()
	set ocidPath to (itemArray's attributeForName:("URL"))'s stringValue()
	set ocidLastPath to (itemArray's attributeForName:("fileName"))'s stringValue()
	set ocidPkgURL to (refMe's NSURL's alloc()'s initWithString:(ocidHost))
	set ocidPkgURL to (ocidPkgURL's URLByAppendingPathComponent:(ocidPath))
	set ocidPkgURL to (ocidPkgURL's URLByAppendingPathComponent:(ocidLastPath))
	set ocidSetURL to ocidPkgURL's absoluteString()
	(ocidOutPutstring's appendString:(ocidSetURL))
	(ocidOutPutstring's appendString:("\n"))
	#	log (itemArray's attributeForName:("signingEntity"))'s stringValue as text
	#	log (itemArray's attributeForName:("hashValue"))'s stringValue as text
	#PKGのファイルサイズ
	set ocidFileSizeStr to (itemArray's attributeForName:("size"))'s stringValue()
	set ocidFileSizeDec to (refMe's NSDecimalNumber's alloc()'s initWithString:(ocidFileSizeStr))
	set ocidThousandDec to (refMe's NSDecimalNumber's alloc()'s initWithString:("1000000"))
	set ocidMBDec to (ocidFileSizeDec's decimalNumberByDividingBy:(ocidThousandDec))
	set ocidFormatter to refMe's NSNumberFormatter's alloc()'s init()
	(ocidFormatter's setRoundingMode:(refMe's NSNumberFormatterRoundFloor))
	(ocidFormatter's setNumberStyle:(refMe's NSNumberFormatterDecimalStyle))
	(ocidFormatter's setMaximumFractionDigits:(2))
	set ocidMBstr to (ocidFormatter's stringFromNumber:(ocidMBDec))
	(ocidOutPutstring's appendString:(ocidMBstr))
	(ocidOutPutstring's appendString:(" MB"))
	(ocidOutPutstring's appendString:("\n"))
	
end repeat


##############################
#テキスト保存
set ocidSaveTextFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("AcrobatSCAManifest.txt") isDirectory:(false)
set listDone to ocidOutPutstring's writeToURL:(ocidSaveTextFilePathURL) atomically:(true) encoding:(refMe's NSUTF8StringEncoding) |error|:(reference)
if (item 1 of listDone) is true then
	log "writeToURL 正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "writeToURL エラーしました"
end if

##############################
#開く
set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
set boolDone to appSharedWorkspace's openURL:(ocidSaveTextFilePathURL)

if (boolDone) is true then
	return "正常処理"
else if (boolDone) is false then
	return "エラーしました"
end if

