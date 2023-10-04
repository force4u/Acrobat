#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
#  com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##自分環境がos12なので2.8にしているだけです
use AppleScript version "2.8"
use framework "Foundation"
use scripting additions

property refMe : a reference to current application

##OSのバージョンを取得
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidSystemPathArray to (appFileManager's URLsForDirectory:(refMe's NSCoreServiceDirectory) inDomains:(refMe's NSSystemDomainMask))
set ocidCoreServicePathURL to ocidSystemPathArray's firstObject()
set ocidPlistFilePathURL to ocidCoreServicePathURL's URLByAppendingPathComponent:("SystemVersion.plist")
set ocidPlistDict to refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL)
set strOSversion to (ocidPlistDict's valueForKey:("ProductVersion")) as text
set numOSversion to strOSversion as number
if numOSversion ≥ 14 then
	return "OS13までの機能です"
end if

#############################
###AcrobatPPDの有無を確認
#############################
set ocidUserPathArray to (appFileManager's URLsForDirectory:(refMe's NSUserDirectory) inDomains:(refMe's NSLocalDomainMask))
set ocidUserPathURL to ocidUserPathArray's objectAtIndex:0
set ocidPPDFilePathURL to ocidUserPathURL's URLByAppendingPathComponent:"Shared/Library/Printers/PPDs/Contents/Resources/Acrobat/ADPDF9J.PPD" isDirectory:true
set boolFileExists to (appFileManager's fileExistsAtPath:(ocidPPDFilePathURL's |path|()) isDirectory:false)

############PPDファイル
if boolFileExists is true then
	log "PPDはインストール済み"
	set strPPDsFilePath to ocidPPDFilePathURL's |path|() as text
else
	log "AcrobatPPDは未インストールなので標準PPDを使用"
	set strPPDsFilePath to "/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd" as text
end if

#############################
#####ファイル選択ダイアログ
#############################
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
###ダイアログのデフォルト
set ocidUserDesktopPath to (appFileManager's URLsForDirectory:(refMe's NSDesktopDirectory) inDomains:(refMe's NSUserDomainMask))
set aliasDefaultLocation to ocidUserDesktopPath as alias
tell application "Finder"
	
end tell
set listChooseFileUTI to {"com.adobe.postscript"}
set strPromptText to "ファイルを選んでください" as text
set listAliasFilePath to (choose file with prompt strPromptText default location (aliasDefaultLocation) of type listChooseFileUTI with invisibles and multiple selections allowed without showing package contents) as list



repeat with itemAliasFilePath in listAliasFilePath
	###エイリアス
	set aliasFilePath to itemAliasFilePath as alias
	###パステキスト
	set strFilePath to (POSIX path of aliasFilePath) as text
	####入力ファイルパス確定
	set strInputFilePath to strFilePath as text
	###パス
	set ocidFilePath to (refMe's NSString's stringWithString:strFilePath)
	###NSURL
	set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath)
	###ファイル名
	set ocidFileName to ocidFilePathURL's lastPathComponent()
	###拡張子を取ったベースファイル名
	set strBaseFileName to ocidFileName's stringByDeletingPathExtension() as text
	####入力ファイルの１階層上のフォルダURL
	set ocidContainerDirPathURL to ocidFilePathURL's URLByDeletingLastPathComponent()
	####ディレクトリのURLコンポーネント
	set strContainerDirPath to ocidContainerDirPathURL's |path|() as text
	
	####出力ファイル名
	set strNewFileName to (strBaseFileName & ".pdf") as text
	####ディレクトリのURLコンポーネント
	set ocidNewFilePathURL to (ocidContainerDirPathURL's URLByAppendingPathComponent:strNewFileName)
	####ファイルの有無チェック
	set boolFileExist to (ocidNewFilePathURL's checkResourceIsReachableAndReturnError:(missing value)) as boolean
	###すでに同名ファイルがある場合は日付時間入りのファイル名
	if boolFileExist is true then
		####日付情報の取得
		set ocidDate to refMe's NSDate's |date|()
		###日付のフォーマットを定義
		set ocidNSDateFormatter to refMe's NSDateFormatter's alloc()'s init()
		(ocidNSDateFormatter's setDateFormat:"yyyyMMdd-hhmm")
		set ocidDateAndTime to (ocidNSDateFormatter's stringFromDate:ocidDate)
		set strDateAndTime to ocidDateAndTime as text
		####ファイル名に日付を入れる
		set strNewFilePath to (strContainerDirPath & "/" & strBaseFileName & "." & strDateAndTime & ".pdf") as text
	else
		####出力ファイルパス
		set strNewFilePath to (strContainerDirPath & "/" & strNewFileName & "") as text
	end if
	################################################
	####コマンドパス	
	set strBinPath to "/usr/sbin/cupsfilter"
	#####コマンド整形
	set strCommandText to ("\"" & strBinPath & "\" -f \"" & strInputFilePath & "\" -m \"application/pdf\" -p \"" & strPPDsFilePath & "\" -e -t \"" & strBaseFileName & "\"  > \"" & strNewFilePath & "\"")
	####ターミナルで開く
	tell application "Terminal"
		launch
		activate
		set objWindowID to (do script "\n\n")
		delay 1
		do script strCommandText in objWindowID
	end tell
end repeat


