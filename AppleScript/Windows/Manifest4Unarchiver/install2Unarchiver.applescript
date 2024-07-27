#! /usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
# Unarchiverをユーザーアプリケーションフォルダ内にコピーインストール
#	com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##自分環境がos12なので2.8にしているだけです
use AppleScript version "2.8"
use framework "Foundation"
use framework "UniformTypeIdentifiers"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application


##############################
#ダウンロードするURL
set ocidURLComponents to refMe's NSURLComponents's alloc()'s init()
ocidURLComponents's setScheme:"https"
ocidURLComponents's setHost:"dl.devmate.com"
ocidURLComponents's setPath:"/com.macpaw.site.theunarchiver/TheUnarchiver.dmg"
set ocidURLStrings to ocidURLComponents's |URL|'s absoluteString()
set ocidURL to refMe's NSURL's alloc()'s initWithString:(ocidURLStrings)
set ocidFileName to ocidURL's lastPathComponent()

##########################
#ゴミ箱に入れる
set listChkPath to {"/Applications/The Unarchiver.app", "/Applications/Utilities/The Unarchiver.app", "~/Applications/The Unarchiver.app", "~/Applications/Utilities/The Unarchiver.app", "~/Library/Containers/cx.c3.theunarchiver", "~/Library/Containers/com.macpaw.site.theunarchiver"} as list

repeat with itemChkPath in listChkPath
	set strFilePath to (itemChkPath) as text
	set ocidFilePathStr to (refMe's NSString's stringWithString:(strFilePath))
	set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
	set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidFilePath) isDirectory:false)
	set appFileManager to refMe's NSFileManager's defaultManager()
	set listDone to (appFileManager's trashItemAtURL:(ocidFilePathURL) resultingItemURL:(ocidFilePathURL) |error|:(reference))
	if (item 1 of listDone) is true then
		log "正常処理"
	else if (item 2 of listDone) ≠ (missing value) then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
	end if
	
end repeat

##########################
#ユーザーユーティリティ
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidApplicationDirPathURL to ocidURLsArray's firstObject()
set ocidUtilitiesDirPathURL to ocidApplicationDirPathURL's URLByAppendingPathComponent:("Utilities") isDirectory:(true)
#フォルダ作って
set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
ocidAttrDict's setValue:(448) forKey:(refMe's NSFilePosixPermissions)
set listDone to appFileManager's createDirectoryAtURL:(ocidUtilitiesDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
if (item 1 of listDone) is true then
	log "createDirectoryAtURL 正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "createDirectoryAtURL エラーしました"
end if
#localized
set ocidNullText to refMe's NSString's stringWithString:("")
set ocidLocalizedPathURL to ocidUtilitiesDirPathURL's URLByAppendingPathComponent:(".localized") isDirectory:(false)
set listDone to ocidNullText's writeToURL:(ocidLocalizedPathURL) atomically:(true) encoding:(refMe's NSUTF8StringEncoding) |error|:(reference)
if (item 1 of listDone) is true then
	log "createDirectoryAtURL 正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "writeToURL エラーしました"
end if
set ocidDistAppFilePathURL to ocidUtilitiesDirPathURL's URLByAppendingPathComponent:("The Unarchiver.app") isDirectory:(true)



##########################
#起動時に削除される項目にダウンロード

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


##########################
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
#保存先
set ocidSaveFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:(ocidFileName) isDirectory:(false)
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
#マウントポイント
#保存先
set ocidMountPointPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("MountPoint") isDirectory:(true)
#フォルダを作っておく
set listDone to appFileManager's createDirectoryAtURL:(ocidMountPointPathURL) withIntermediateDirectories:(true) attributes:(ocidAttrDict) |error|:(reference)
if (item 1 of listDone) is true then
	log "createDirectoryAtURL 正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "createDirectoryAtURL エラーしました"
end if
##############################
#ディスクイメージマウント
set strMountPointPath to (ocidMountPointPathURL's |path|()) as text
set strSaveFilePath to (ocidSaveFilePathURL's |path|()) as text
set strCommandText to ("/usr/bin/hdiutil attach \"" & strSaveFilePath & "\" -noverify -nobrowse -noautoopen -mountpoint \"" & strMountPointPath & "\"") as text
log strCommandText
try
	do shell script strCommandText
on error
	return "hdiutil attach エラーしました"
end try

##############################
#
set ocidDmgAppPathURL to ocidMountPointPathURL's URLByAppendingPathComponent:("The Unarchiver.app") isDirectory:(true)

set appFileManager to refMe's NSFileManager's defaultManager()
set listDone to (appFileManager's copyItemAtURL:(ocidDmgAppPathURL) toURL:(ocidDistAppFilePathURL) |error|:(reference))
if (item 1 of listDone) is true then
	log "正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	set strErrorNO to (item 2 of listDone)'s code() as text
	set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
	refMe's NSLog("■：" & strErrorNO & strErrorMes)
	return "エラーしました" & strErrorNO & strErrorMes
end if


##############################
#ディスクイメージ デタッチ
set strCommandText to ("/usr/bin/hdiutil detach \"" & strMountPointPath & "\"  -force") as text
log strCommandText
try
	do shell script strCommandText
on error
	return "hdiutil detach エラーしました"
end try

##############################
#起動
set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
set boolDone to appSharedWorkspace's openURL:(ocidDistAppFilePathURL)

delay 1
##############################
#終了
tell application id "com.macpaw.site.theunarchiver" to quit
