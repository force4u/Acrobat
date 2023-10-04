#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions


property refMe : a reference to current application
property refNSNotFound : a reference to 9.22337203685477E+18 + 5807

set appFileManager to refMe's NSFileManager's defaultManager()
set appShardWorkspace to refMe's NSWorkspace's sharedWorkspace()

###リーダーの場合
set strUTI to "com.adobe.Reader" as text
######Proの場合はこちら
###set strUTI to "com.adobe.Acrobat.Pro" as text

####ダイアログで使うデフォルトロケーション
set ocidUserDesktopPath to (appFileManager's URLsForDirectory:(refMe's NSDesktopDirectory) inDomains:(refMe's NSUserDomainMask))
set aliasDefaultLocation to ocidUserDesktopPath as alias
###アプリケーション限定
set listUTI to {"com.apple.localized-pdf-bundle", "net.sourceforge.skim-app.pdfd"}

####ダイアログを出す
set listFilePath to (choose file with prompt "ファイルを選んでください" default location (aliasDefaultLocation) of type listUTI with invisibles and multiple selections allowed without showing package contents) as list

###アプリケーションが開くURLリストの初期化
set ocidFilePathURLArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:0)


repeat with itemFilePath in listFilePath
	set strFilePath to POSIX path of itemFilePath as text
	####拡張子取得
	tell application "Finder"
		set strExtension to (name extension of itemFilePath) as text
	end tell
	if strExtension is "lpdf" then
		set ocidFilePathURL to doGetLpdfPath(strFilePath)
		
	else if strExtension is "pdfd" then
		set ocidFilePathStr to (refMe's NSString's stringWithString:strFilePath)
		set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
		##拡張子をとってから
		set ocidBasePath to ocidFilePath's stringByDeletingPathExtension()
		###ラストパス＝ファイル名（バンドルなのでフォルダ名）
		set ocidDirName to ocidBasePath's lastPathComponent()
		###拡張子を追加した開くファイル名
		set ocidFileName to (ocidDirName's stringByAppendingPathExtension:"pdf")
		set ocidResourcesPath to (ocidFilePath's stringByAppendingPathComponent:ocidFileName)
		set ocidFilePathURL to (refMe's NSURL's fileURLWithPath:ocidResourcesPath)
	end if
	
	###URLをリストに格納して＝開くファイル
	(ocidFilePathURLArray's insertObject:ocidFilePathURL atIndex:0)
	
end repeat





###UTIからアプリケーションのインストール先パス
set ocidAppBundle to (refMe's NSBundle's bundleWithIdentifier:strUTI)
if ocidAppBundle is not (missing value) then
	set ocidAppBundleStr to ocidAppBundle's bundlePath()
	set ocidAppBundlePath to ocidAppBundleStr's stringByStandardizingPath
	set ocidAppBundlePathURL to (refMe's NSURL's fileURLWithPath:ocidAppBundlePath)
else
	set appNSWorkspace to refMe's NSWorkspace's sharedWorkspace()
	set ocidAppBundlePathURL to (appNSWorkspace's URLForApplicationWithBundleIdentifier:strUTI)
end if
###オープン設定
set ocidWorkspaceOpenConfiguration to refMe's NSWorkspaceOpenConfiguration
set ocidOpenConfiguration to ocidWorkspaceOpenConfiguration's configuration()
ocidOpenConfiguration's setHides:(false as boolean)
ocidOpenConfiguration's setActivates:(true as boolean)
ocidOpenConfiguration's setRequiresUniversalLinks:(false as boolean)
ocidOpenConfiguration's setCreatesNewApplicationInstance:(false as boolean)
###アプリ指定で開く
appShardWorkspace's openURLs:ocidFilePathURLArray withApplicationAtURL:ocidAppBundlePathURL configuration:ocidOpenConfiguration completionHandler:(missing value)




to doGetLpdfPath(argFilePath)
	####ドキュメントのパスをNSString
	set ocidFilePathStr to (refMe's NSString's stringWithString:strFilePath)
	set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
	##拡張子をとってから
	set ocidBasePath to ocidFilePath's stringByDeletingPathExtension()
	###ラストパス＝ファイル名（バンドルなのでフォルダ名）
	set ocidDirName to ocidBasePath's lastPathComponent()
	###拡張子を追加した開くファイル名
	set ocidFileName to (ocidDirName's stringByAppendingPathExtension:"pdf")
	###Resourcesパスを追加して
	set ocidResourcesPath to (ocidFilePath's stringByAppendingPathComponent:"Contents/Resources")
	###Resourcesフォルダの中身をリストにします
	set listResults to (appFileManager's contentsOfDirectoryAtPath:ocidResourcesPath |error|:(reference))
	set ocidPathArray to item 1 of listResults
	###Japanese.lprojがあるか？確認して
	set numSeachResults to (ocidPathArray's indexOfObject:"Japanese.lproj")
	###なければEnglish.lprojを指定
	if numSeachResults is refNSNotFound then
		log "見つかりませんでした"
		set openPath to "English.lproj" as text
	else
		log numSeachResults & "番目です"
		set openPath to "Japanese.lproj" as text
	end if
	###Japanese.lprojをパスに追加して
	set ocidLprojPath to (ocidResourcesPath's stringByAppendingPathComponent:openPath)
	###ファイル名を追加して
	set ocidOpenFilePath to (ocidLprojPath's stringByAppendingPathComponent:ocidFileName)
	###URLに
	set ocidFilePathURL to (refMe's NSURL's fileURLWithPath:ocidOpenFilePath)
	return ocidFilePathURL
end doGetLpdfPath