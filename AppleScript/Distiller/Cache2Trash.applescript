#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#【重要】　Adobeのアプリケーションを【重要】
#一旦全て終了させてから実行してください
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

set appFileManager to refMe's NSFileManager's defaultManager()

###################################
########まずは処理するアプリケーションを終了させる
###################################
try
	tell application id "com.adobe.distiller" to quit
end try
set ocidRunningApplication to refMe's NSRunningApplication
set ocidAppArray to (ocidRunningApplication's runningApplicationsWithBundleIdentifier:("com.adobe.distiller"))
###複数起動時も順番に終了
repeat with itemAppArray in ocidAppArray
	###終了
	itemAppArray's terminate()
end repeat
##１秒まって終了を確認
delay 1
##終了できない場合は強制終了
repeat with itemAppArray in ocidAppArray
	set boolTerminate to itemAppArray's terminated
	if boolTerminate = false then
		itemAppArray's forceTerminate()
	end if
end repeat
##使いたくないがしかたがない
try
	do shell script "/usr/bin/killall Distiller"
end try
###################################
########
###################################
log doMoveToTrash("~/Library/Application Scripts/com.adobe.distiller")
log doMoveToTrash("~/Library/Caches/Acrobat")
log doMoveToTrash("~/Library/Caches/Adobe")
log doMoveToTrash("~/Library/Caches/com.adobe.Acrobat.Pro")
log doMoveToTrash("~/Library/Caches/com.adobe.distiller")
log doMoveToTrash("~/Library/Caches/com.adobe.Reader")
log doMoveToTrash("~/Library/WebKit/com.adobe.crashreporter")
log doMoveToTrash("~/Library/WebKit/com.adobe.distiller")
log doMoveToTrash("~/Library/Logs/Adobe")
log doMoveToTrash("~/Library/HTTPStorages/com.adobe.distiller")
log doMoveToTrash("~/Library/HTTPStorages/com.adobe.Acrobat.Pro")
log doMoveToTrash("~/Library/HTTPStorages/com.adobe.Reader")
##
log doMoveToTrash("~/Library/Application Support/Adobe/AcroCef/DC/Acrobat/Cache")
log doMoveToTrash("~/Library/Application Support/Adobe/AcroCef/2020/Acrobat/Cache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/Distiller DC/FontCache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/SaveAsAdobePDF DC/FontCache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/Preflight Acrobat Continuous/FontCache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/Distiller DC/Messages.log")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/BHCache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/AdobeCMapFnt22.lst")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/AdobeCMapFnt24.lst")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/AdobeSysFnt22.lst")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/AdobeSysFnt24.lst")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/JSCache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/ThumbCache")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/ToolsSearchCacheAcro")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/UserCache64.bin")
log doMoveToTrash("~/Library/Application Support/Adobe/Acrobat/DC/ProtectedView¥AdobeSysFnt22.lst")


###################################
########キャッシュNSTemporaryDirectory
###################################
### T
set ocidTempDir to (refMe's NSTemporaryDirectory())
set ocidTemporaryTPathURL to refMe's NSURL's fileURLWithPath:(ocidTempDir)
set ocidPropertiesArray to refMe's NSMutableArray's alloc()'s initWithCapacity:(0)
ocidPropertiesArray's addObject:(refMe's NSURLIsRegularFileKey)
ocidPropertiesArray's addObject:(refMe's NSURLPathKey)
ocidPropertiesArray's addObject:(refMe's NSURLNameKey)
set listResponse to appFileManager's contentsOfDirectoryAtURL:(ocidTemporaryTPathURL) includingPropertiesForKeys:(ocidPropertiesArray) options:(refMe's NSDirectoryEnumerationSkipsSubdirectoryDescendants) |error|:(reference)
log item 2 of listResponse

repeat with itemURL in (item 1 of listResponse)
	set listResourceValue to (itemURL's getResourceValue:(reference) forKey:(refMe's NSURLNameKey) |error|:(missing value))
	set ocidFileName to (item 2 of listResourceValue)
	if (ocidFileName's hasPrefix:("Acr")) = true then
		log itemURL's lastPathComponent() as text
		
	end if
end repeat

log doMoveToTrash(ocidTemporaryTPathURL's URLByAppendingPathComponent:"AdobeIDataSync")
### 
set ocidTempURL to ocidTemporaryTPathURL's URLByDeletingLastPathComponent()
### C
set ocidTemporaryCPathURL to ocidTempURL's URLByAppendingPathComponent:"C"

log doMoveToTrash(ocidTemporaryCPathURL's URLByAppendingPathComponent:"com.adobe.Acrobat.Pro")
log doMoveToTrash(ocidTemporaryCPathURL's URLByAppendingPathComponent:"com.adobe.Reader")
log doMoveToTrash(ocidTemporaryCPathURL's URLByAppendingPathComponent:"com.adobe.distiller")

###################################
########処理　ゴミ箱に入れる
###################################

to doMoveToTrash(argFilePath)
	###ファイルマネジャー初期化
	set appFileManager to refMe's NSFileManager's defaultManager()
	#########################################
	###渡された値のClassを調べてとりあえずNSURLにする
	set refClass to class of argFilePath
	if refClass is list then
		return "エラー:リストは処理しません"
	else if refClass is text then
		log "テキストパスです"
		set ocidArgFilePathStr to (refMe's NSString's stringWithString:argFilePath)
		set ocidArgFilePath to ocidArgFilePathStr's stringByStandardizingPath
		set ocidArgFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidArgFilePath)
	else if refClass is alias then
		log "エイリアスパスです"
		set strArgFilePath to (POSIX path of argFilePath) as text
		set ocidArgFilePathStr to (refMe's NSString's stringWithString:strArgFilePath)
		set ocidArgFilePath to ocidArgFilePathStr's stringByStandardizingPath
		set ocidArgFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidArgFilePath)
	else
		set refClass to (className() of argFilePath) as text
		if refClass contains "NSPathStore2" then
			log "NSPathStore2です"
			set ocidArgFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:argFilePath)
		else if refClass contains "NSCFString" then
			log "NSCFStringです"
			set ocidArgFilePath to argFilePath's stringByStandardizingPath
			set ocidArgFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidArgFilePath)
		else if refClass contains "NSURL" then
			set ocidArgFilePathURL to argFilePath
			log "NSURLです"
		end if
	end if
	#########################################
	###
	-->false
	set ocidFalse to (refMe's NSNumber's numberWithBool:false)'s boolValue
	-->true
	set ocidTrue to (refMe's NSNumber's numberWithBool:true)'s boolValue
	#########################################
	###NSURLがエイリアス実在するか？
	set ocidArgFilePath to ocidArgFilePathURL's |path|()
	set boolFileAlias to appFileManager's fileExistsAtPath:(ocidArgFilePath)
	###パス先が実在しないなら処理はここまで
	if boolFileAlias = false then
		log ocidArgFilePath as text
		log "処理中止 パス先が実在しない"
		return false
	end if
	#########################################
	###NSURLがディレクトリなのか？ファイルなのか？
	set listBoolDir to ocidArgFilePathURL's getResourceValue:(reference) forKey:(refMe's NSURLIsDirectoryKey) |error|:(reference)
	#		log (item 1 of listBoolDir)
	#		log (item 2 of listBoolDir)
	#		log (item 3 of listBoolDir)
	if (item 2 of listBoolDir) = ocidTrue then
		#########################################
		log "ディレクトリです"
		log ocidArgFilePathURL's |path| as text
		##内包リスト
		set listResult to appFileManager's contentsOfDirectoryAtURL:ocidArgFilePathURL includingPropertiesForKeys:{refMe's NSURLPathKey} options:0 |error|:(reference)
		###結果
		set ocidContentsPathURLArray to item 1 of listResult
		###リストの数だけ繰り返し
		repeat with itemContentsPathURL in ocidContentsPathURLArray
			###ゴミ箱に入れる
			set listResult to (appFileManager's trashItemAtURL:itemContentsPathURL resultingItemURL:(missing value) |error|:(reference))
		end repeat
	else
		#########################################
		log "ファイルです"
		set listBoolDir to ocidArgFilePathURL's getResourceValue:(reference) forKey:(refMe's NSURLIsAliasFileKey) |error|:(reference)
		if (item 2 of listBoolDir) = ocidTrue then
			log "エイリアスは処理しません"
			return false
		end if
		set listBoolDir to ocidArgFilePathURL's getResourceValue:(reference) forKey:(refMe's NSURLIsSymbolicLinkKey) |error|:(reference)
		if (item 2 of listBoolDir) = ocidTrue then
			log "シンボリックリンクは処理しません"
			return false
		end if
		set listBoolDir to ocidArgFilePathURL's getResourceValue:(reference) forKey:(refMe's NSURLIsSystemImmutableKey) |error|:(reference)
		if (item 2 of listBoolDir) = ocidTrue then
			log "システムファイルは処理しません"
			return false
		end if
		###ファイルをゴミ箱に入れる
		set listResult to (appFileManager's trashItemAtURL:ocidArgFilePathURL resultingItemURL:(missing value) |error|:(reference))
	end if
	return true
end doMoveToTrash
