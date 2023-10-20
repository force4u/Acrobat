#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
(*
バックアップデータ
１：上書き
２：日付を入れる等して個別データ完全
３：差分のみバックアップする　等がありますが
これは、２の日付を入れた個別データ完全バックアップです
*)
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##自分環境がos12なので2.8にしているだけです
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application
######################
##書類フォルダ
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSDocumentDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidDocumentDirPathURL to ocidURLsArray's firstObject()
set ocidMkDirPathURL to ocidDocumentDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/Stamps/") isDirectory:(true)
###フォルダを作っておく
###フォルダのアトリビュート
set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
# 777-->511 755-->493 700-->448 766-->502 
ocidAttrDict's setValue:(493) forKey:(refMe's NSFilePosixPermissions)
set listDone to (appFileManager's createDirectoryAtURL:(ocidMkDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference))
###保存先となるパス
set strDateNo to doGetDateNo({"yyyyMMdd", 1}) as text
set ocidSaveDirPathURL to (ocidMkDirPathURL's URLByAppendingPathComponent:(strDateNo) isDirectory:(true))
######################
###スタンプフォルダ
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
set ocidDcDirPathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/DC/") isDirectory:(true)
set ocidStampDirPathURL to (ocidDcDirPathURL's URLByAppendingPathComponent:("Stamps") isDirectory:(true))

######################
###ファイルコピー
set listDone to appFileManager's copyItemAtURL:(ocidStampDirPathURL) toURL:(ocidSaveDirPathURL) |error|:(reference)
###　ファイルのコピーに失敗した場合のエラー表示
if (item 1 of listDone) is false then
	set ocidNSErrorData to (item 2 of listDone)
	log "エラーコード：" & ocidNSErrorData's code() as text
	log "エラードメイン：" & ocidNSErrorData's domain() as text
	log "Description:" & ocidNSErrorData's localizedDescription() as text
	log "FailureReason:" & ocidNSErrorData's localizedFailureReason() as text
	return "コピーに失敗しました"
end if

######################
###保存先を開く
set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
set boolDone to appSharedWorkspace's selectFile:(ocidSaveDirPathURL's |path|()) inFileViewerRootedAtPath:(ocidMkDirPathURL's |path|())
###エラーしたらFinderで開く
if boolDone is false then
	set aliasOpenDirPath to (ocidMkDirPathURL's absoluteURL()) as alias
	tell application "Finder"
		open folder aliasOpenDirPath
	end tell
	return "エラーしました"
end if



################################
# 日付 doGetDateNo(argDateFormat,argCalendarNO)
# argCalendarNO 1 NSCalendarIdentifierGregorian 西暦
# argCalendarNO 2 NSCalendarIdentifierJapanese 和暦
################################
to doGetDateNo({argDateFormat, argCalendarNO})
	##渡された値をテキストで確定させて
	set strDateFormat to argDateFormat as text
	set intCalendarNO to argCalendarNO as integer
	###日付情報の取得
	set ocidDate to current application's NSDate's |date|()
	###日付のフォーマットを定義（日本語）
	set ocidFormatterJP to current application's NSDateFormatter's alloc()'s init()
	###和暦　西暦　カレンダー分岐
	if intCalendarNO = 1 then
		set ocidCalendarID to (current application's NSCalendarIdentifierGregorian)
	else if intCalendarNO = 2 then
		set ocidCalendarID to (current application's NSCalendarIdentifierJapanese)
	else
		set ocidCalendarID to (current application's NSCalendarIdentifierISO8601)
	end if
	set ocidCalendarJP to current application's NSCalendar's alloc()'s initWithCalendarIdentifier:(ocidCalendarID)
	set ocidTimezoneJP to current application's NSTimeZone's alloc()'s initWithName:("Asia/Tokyo")
	set ocidLocaleJP to current application's NSLocale's alloc()'s initWithLocaleIdentifier:("ja_JP_POSIX")
	###設定
	ocidFormatterJP's setTimeZone:(ocidTimezoneJP)
	ocidFormatterJP's setLocale:(ocidLocaleJP)
	ocidFormatterJP's setCalendar:(ocidCalendarJP)
	# ocidFormatterJP's setDateStyle:(current application's NSDateFormatterNoStyle)
	# ocidFormatterJP's setDateStyle:(current application's NSDateFormatterShortStyle)
	# ocidFormatterJP's setDateStyle:(current application's NSDateFormatterMediumStyle)
	# ocidFormatterJP's setDateStyle:(current application's NSDateFormatterLongStyle)
	ocidFormatterJP's setDateStyle:(current application's NSDateFormatterFullStyle)
	###渡された値でフォーマット定義
	ocidFormatterJP's setDateFormat:(strDateFormat)
	###フォーマット適応
	set ocidDateAndTime to ocidFormatterJP's stringFromDate:(ocidDate)
	###テキストで戻す
	set strDateAndTime to ocidDateAndTime as text
	return strDateAndTime
end doGetDateNo
