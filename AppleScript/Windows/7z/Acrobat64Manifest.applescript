#! /usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
(*
Windows版の最新版のみ　アップデータのURLを取得します
com.cocolog-nifty.quicktimer
*)
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

property refNSNotFound : a reference to 9.22337203685477E+18 + 5807

##############################
#7zaのパス
set aliasPathToMe to (path to me) as alias
tell application "Finder"
	set aliasContainerDirPath to (container of aliasPathToMe) as alias
	set aliasBinPath to (file "7zz" of folder "bin" of folder aliasContainerDirPath) as alias
end tell
set strBinPath to (POSIX path of aliasBinPath) as text


##############################
#ダウンロードするURL
set ocidURLComponents to refMe's NSURLComponents's alloc()'s init()
ocidURLComponents's setScheme:("https")
ocidURLComponents's setHost:("armmf.adobe.com")
ocidURLComponents's setPath:("/arm-manifests/win/AcrobatDCx64Manifest3.msi")
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
#解凍先

set strDistPath to (ocidSaveDirPathURL's |path|()) as text
#コマンド実行
set strComandText to ("pushd \"" & strDistPath & "\" && \"" & strBinPath & "\" x \"" & strPkgPath & "\"") as text
log strComandText
try
	do shell script strComandText
on error
	return "7zaでエラーになりました"
end try
delay 1

##############################
#マニフェスト読み込み
#パス
set ocidFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("!_StringData") isDirectory:(false)
##############################
#NSDATAに読み込み
set ocidOption to (refMe's NSDataReadingMappedIfSafe)
set listResponse to refMe's NSData's alloc()'s initWithContentsOfURL:(ocidFilePathURL) options:(ocidOption) |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	log "initWithContentsOfURL　正常処理"
	set ocidReadData to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	log (item 2 of listResponse)'s code() as text
	log (item 2 of listResponse)'s localizedDescription() as text
	return "initWithContentsOfURL　エラーしました"
end if
##############################
#STRINGSに読み込む
set ocidReadString to refMe's NSMutableString's alloc()'s initWithData:(ocidReadData) encoding:(refMe's NSUTF8StringEncoding)
#URL取り出し用に置換
set ocidEditStrings to (ocidReadString's stringByReplacingOccurrencesOfString:("http") withString:("\nhttp"))
set ocidEditStrings to (ocidEditStrings's stringByReplacingOccurrencesOfString:(".msp") withString:(".msp\n"))
set ocidEditStrings to (ocidEditStrings's stringByReplacingOccurrencesOfString:(".msi") withString:(".msi\n"))
#リストに
set ocidTextArray to ocidEditStrings's componentsSeparatedByString:("\n")
#抽出
set appPredicate to refMe's NSPredicate's predicateWithFormat_("(SELF BEGINSWITH %@)", "https://ardownload")
set ocidPredicatedArray to ocidTextArray's filteredArrayUsingPredicate:(appPredicate)

#set appPredicate to refMe's NSPredicate's predicateWithFormat_("(SELF CONTAINS %@)", "AcroRdrDC")
#set ocidReaderArray to ocidPredicatedArray's filteredArrayUsingPredicate:(appPredicate)

set appPredicate to refMe's NSPredicate's predicateWithFormat_("(SELF CONTAINS %@)", "AcrobatDCx")
set ocidAcrobatArray to ocidPredicatedArray's filteredArrayUsingPredicate:(appPredicate)

##############################
#出力用テキスト
set ocidOutPutstring to refMe's NSMutableString's alloc()'s initWithCapacity:(0)
ocidOutPutstring's appendString:("Windows版 Acrobat 64bit版の最新パッチURL\nMSI：インストーラー\nMSP：アップデーターパッチ\nMUI：マルチリンガル対応版\nincr：差分のみアップデート版（軽量）\n\n")
ocidOutPutstring's appendString:("----+----1----+----2----+-----3----+----4----+----5----+----6----+----7\n\n")
##############################
(ocidOutPutstring's appendString:("Acrobat x64 アップデータ\n"))
(ocidOutPutstring's appendString:("\n"))
#取り出してテキストに
repeat with itemPredicatedArray in ocidAcrobatArray
	(ocidOutPutstring's appendString:(itemPredicatedArray))
	(ocidOutPutstring's appendString:("\n"))
	(ocidOutPutstring's appendString:("\n"))
end repeat
(*
ocidOutPutstring's appendString:("----+----1----+----2----+-----3----+----4----+----5----+----6----+----7\n\n")
(ocidOutPutstring's appendString:("Reader x64 アップデータ\n"))
(ocidOutPutstring's appendString:("\n"))
#取り出してテキストに
repeat with itemPredicatedArray in ocidReaderArray
	(ocidOutPutstring's appendString:(itemPredicatedArray))
	(ocidOutPutstring's appendString:("\n"))
	(ocidOutPutstring's appendString:("\n"))
end repeat
*)
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

