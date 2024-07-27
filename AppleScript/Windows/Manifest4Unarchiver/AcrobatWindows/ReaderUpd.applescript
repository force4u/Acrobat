#! /usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
(*
Windows版のアップデータのURLを全部取得します
出力テキストの下部が新しいバージョンになります
*)
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

property refNSNotFound : a reference to 9.22337203685477E+18 + 5807

##############################
#
#呼び出し用のDICT
set ocidURLDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
#対象のアプリケーションのUTI
set listUTI to {"cx.c3.theunarchiver", "com.macpaw.site.theunarchiver"} as list
#UTIからアプリケーションのインストール先を求める
repeat with itemUTI in listUTI
	#バンドル取得
	set ocidAppBundle to (refMe's NSBundle's bundleWithIdentifier:(itemUTI))
	if ocidAppBundle is (missing value) then
		set appNSWorkspace to refMe's NSWorkspace's sharedWorkspace()
		#ワークスペースからURL取得
		set ocidAppBundlePathURL to (appNSWorkspace's URLForApplicationWithBundleIdentifier:(itemUTI))
	else
		##バンドル取れているならそのままURL
		set ocidAppBundleStr to ocidAppBundle's bundlePath()
		set ocidAppBundlePath to ocidAppBundleStr's stringByStandardizingPath
		set ocidAppBundlePathURL to (refMe's NSURL's fileURLWithPath:ocidAppBundlePath)
	end if
	##URLがあった場合はDICTに登録する
	if ocidAppBundlePathURL is not (missing value) then
		(ocidURLDict's setObject:(ocidAppBundlePathURL) forKey:(itemUTI))
	end if
end repeat
#取得したURLの数を数える
set ocidAllKeyArray to ocidURLDict's allKeys()
set numCntKey to (ocidAllKeyArray's |count|()) as integer
if numCntKey = 0 then
	return "unarchiveが見つかりませんでした"
end if



##############################
#ダウンロードするURL
set ocidURLComponents to refMe's NSURLComponents's alloc()'s init()
ocidURLComponents's setScheme:("https")
ocidURLComponents's setHost:("armmf.adobe.com")
ocidURLComponents's setPath:("/arm-manifests/win/SCUP/ReaderCatalog-DC.cab")
set ocidURL to ocidURLComponents's |URL|()
log ocidURL's absoluteString() as text
set ocidFileName to ocidURL's lastPathComponent()
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
set ocidSaveFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:(ocidFileName) isDirectory:(false)

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
set aliasPkgFilePath to (ocidSaveFilePathURL's absoluteURL()) as alias
set strBundleID to (ocidAllKeyArray's firstObject()) as text
tell application id strBundleID to open file aliasPkgFilePath

delay 1

##############################
#マニフェスト読み込み
set ocidExtractDirPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("ReaderCatalog-DC") isDirectory:(true)
#XMLパス
set ocidXmlFilePathURL to ocidExtractDirPathURL's URLByAppendingPathComponent:("Reader_Catalog.xml") isDirectory:(false)

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
set ocidOption to (refMe's NSXMLNodePreserveAll) + (refMe's NSXMLDocumentTidyXML)
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
ocidOutPutstring's appendString:("Windows版 ReaderのパッチURL\n\n")
ocidOutPutstring's appendString:("----+----1----+----2----+-----3----+----4----+----5----+----6----+----7\n\n")
##############################
#XML解析
#ROOT
set ocidRootElement to ocidXMLDoc's rootElement()
set ocidPackageArray to ocidRootElement's elementsForName:("smc:SoftwareDistributionPackage")
#set ocidPackageItems to ocidPackageArray's firstObject()
set numCntArray to ocidPackageArray's |count|()

repeat with itemIntNo from (numCntArray - 1) to 0 by -1
	
	set itemPackageArray to (ocidPackageArray's objectAtIndex:(itemIntNo))
	
	#
	set ocidLocalizedArray to (itemPackageArray's elementsForName:("sdp:LocalizedProperties"))
	set ocidLocalized to ocidLocalizedArray's firstObject()
	set ocidTitleArray to (ocidLocalized's elementsForName:("sdp:Title"))
	set ocidLocalized to (ocidTitleArray's firstObject())'s stringValue()
	(ocidOutPutstring's appendString:(ocidLocalized as text))
	(ocidOutPutstring's appendString:("\n"))
	#
	set ocidItemArray to (itemPackageArray's elementsForName:("sdp:InstallableItem"))
	set ocidInstallItem to ocidItemArray's firstObject()
	set ocidFileElementArray to (ocidInstallItem's elementsForName:("sdp:OriginFile"))
	set ocidFileElementItem to ocidFileElementArray's firstObject()
	set ocidURI to (ocidFileElementItem's attributeForName:("OriginUri"))'s stringValue()
	(ocidOutPutstring's appendString:(ocidURI as text))
	(ocidOutPutstring's appendString:("\n\n"))
	#
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
	log "正常処理"
else if (boolDone) is false then
	return "エラーしました"
end if

##############################
#ゴミ箱に入れる
set listDone to (appFileManager's trashItemAtURL:(ocidExtractDirPathURL) resultingItemURL:(ocidExtractDirPathURL) |error|:(reference))
if (item 1 of listDone) is true then
	log "trashItemAtURL 正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "trashItemAtURL エラーしました"
end if