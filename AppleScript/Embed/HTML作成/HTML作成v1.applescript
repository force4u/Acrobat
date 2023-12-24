#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#APIキーは
#	https://developer.adobe.com/console/projects
#から取得
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "UniformTypeIdentifiers"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application
set appFileManager to refMe's NSFileManager's defaultManager()


set numW to 720
set numH to 360

####################
## APIキー
####################
property strMes : ("PDF Embed APIのAPI Keyを入力してください ") as text
###任意項目
property strBundleID : ("acrobatservices.adobe.com") as text
set strKeyName to ("APIKey") as text
####設定ファイル
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationSupportDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidApplicationSupportDirPathURL to ocidURLsArray's firstObject()
set ocidPreferencesDirPathURL to ocidApplicationSupportDirPathURL's URLByAppendingPathComponent:("com.cocolog-nifty.quicktimer")
#フォルダ作成
set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
ocidAttrDict's setValue:(493) forKey:(refMe's NSFilePosixPermissions)
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidPreferencesDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
#設定ファイルパス
set ocidPreferencesFileBasePathURL to ocidPreferencesDirPathURL's URLByAppendingPathComponent:(strBundleID)
set ocidPlistFilePathURL to ocidPreferencesFileBasePathURL's URLByAppendingPathExtension:("plist")
##
set listPlistDict to refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL) |error|:(reference)
set ocidPlistDict to (item 1 of listPlistDict)
if ocidPlistDict = (missing value) then
	log "設定ファイルが見つかりません"
	###ダイアログを出す
	set ocidValue to doSetTextDialogue(strBundleID)
	##新規で設定ファイルを作成する
	set ocidPlistDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
	ocidPlistDict's setValue:(ocidValue) forKey:(strKeyName)
	set ocidFormat to (refMe's NSPropertyListXMLFormat_v1_0)
	set listPlistData to refMe's NSPropertyListSerialization's dataWithPropertyList:(ocidPlistDict) format:(ocidFormat) options:0 |error|:(reference)
	set ocidPlistData to (item 1 of listPlistData)
	#保存
	set listDone to ocidPlistData's writeToURL:(ocidPlistFilePathURL) options:0 |error|:(reference)
else
	log "設定ファイルから設定を読み込みます"
	set listPlistDict to refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL) |error|:(reference)
	set ocidPlistDict to (item 1 of listPlistDict)
	set ocidValue to ocidPlistDict's valueForKey:(strKeyName)
	if ocidValue = (missing value) then
		log "設定ファイルに値が見つかりません"
		###ダイアログを出す
		set ocidValue to doSetTextDialogue(strBundleID)
		ocidPlistDict's setValue:(ocidValue) forKey:(strKeyName)
		set ocidFormat to (refMe's NSPropertyListXMLFormat_v1_0)
		set listPlistData to refMe's NSPropertyListSerialization's dataWithPropertyList:(ocidPlistDict) format:(ocidFormat) options:0 |error|:(reference)
		set ocidPlistData to (item 1 of listPlistData)
		#保存
		set listDone to ocidPlistData's writeToURL:(ocidPlistFilePathURL) options:0 |error|:(reference)
	end if
end if
###設定項目の戻り
set strApiKey to ocidValue as text
####################
## テンプレート
####################
set listTemplates to {"full", "inline", "linghtbox", "size"} as list
###ダイアログ
set strName to (name of current application) as text
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
set listResponse to (choose from list listTemplates with title "選んでください" with prompt "テンプレートを選んでください" default items (item 1 of listTemplates) OK button name "OK" cancel button name "キャンセル" without multiple selections allowed and empty selection allowed) as list
if (item 1 of listResponse) is false then
	return "キャンセルしました"
end if
set strTemplateName to (item 1 of listResponse) as text
set aliasPathToMe to (path to me) as alias
set strFilePath to (POSIX path of aliasPathToMe) as text
set ocidFilePathStr to refMe's NSString's stringWithString:(strFilePath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidFilePath) isDirectory:false)
set ocidContainerDir to ocidFilePathURL's URLByDeletingLastPathComponent()
set strSubPath to ("Templates/" & strTemplateName & ".html") as text
set ocidTemplatesPathURL to ocidContainerDir's URLByAppendingPathComponent:(strSubPath)

####################
## PDF URL
####################
set ocidIconPathURL to doGetAppIconPathURL("com.apple.Preview")
set aliasIconPath to (ocidIconPathURL's absoluteURL()) as alias
set strDefaultAnswer to doGetPasteboard()
try
	set recordResponse to (display dialog "PDFのURLをhttpsから" with title "入力してください" default answer strDefaultAnswer buttons {"OK", "キャンセル"} default button "OK" cancel button "キャンセル" with icon aliasIconPath giving up after 20 without hidden answer)
on error
	log "エラーしました"
	return "エラーしました"
end try
if true is equal to (gave up of recordResponse) then
	return "時間切れですやりなおしてください"
end if
if "OK" is equal to (button returned of recordResponse) then
	set strResponseURL to (text returned of recordResponse) as text
else
	log "キャンセルしました"
	return "キャンセルしました"
end if
###NSStringに格納
set ocidPDFResponse to (refMe's NSString's stringWithString:(strResponseURL))
###タブと改行を除去しておく
set ocidPdfUrlM to refMe's NSMutableString's alloc()'s initWithCapacity:(0)
ocidPdfUrlM's appendString:(ocidPDFResponse)
##改行除去
set ocidPdfUrlM to ocidPdfUrlM's stringByReplacingOccurrencesOfString:("\n") withString:("")
set ocidPdfUrlM to ocidPdfUrlM's stringByReplacingOccurrencesOfString:("\r") withString:("")
##タブ除去
set ocidPDFURLstr to ocidPdfUrlM's stringByReplacingOccurrencesOfString:("\t") withString:("")
###
set ocidPDFURLstr to ocidPdfUrlM's stringByReplacingOccurrencesOfString:("blob:") withString:("")
###
set ocidPDFURL to refMe's NSURL's alloc()'s initWithString:(ocidPDFURLstr)
set strPdfURL to ocidPDFURL's absoluteString() as text
set strPdfFileName to (ocidPDFURL's lastPathComponent()) as text

####################
## HTML生成
####################
set listReadStrings to refMe's NSString's alloc()'s initWithContentsOfURL:(ocidTemplatesPathURL) encoding:(refMe's NSUTF8StringEncoding) |error|:(reference)
set ocidReadStrings to (item 1 of listReadStrings)
set ocidReadHTML to refMe's NSMutableString's alloc()'s initWithCapacity:(0)
ocidReadHTML's setString:(ocidReadStrings)
log ocidReadHTML as text
##
set ocidReadHTML to ocidReadHTML's stringByReplacingOccurrencesOfString:("<YOUR_CLIENT_ID>") withString:(strApiKey)
set ocidReadHTML to ocidReadHTML's stringByReplacingOccurrencesOfString:("<YOUR_PDF_URL>") withString:(strPdfURL)
set ocidReadHTML to ocidReadHTML's stringByReplacingOccurrencesOfString:("<YOUR_PDF_FILENAME>") withString:(strPdfFileName)
set ocidReadHTML to ocidReadHTML's stringByReplacingOccurrencesOfString:("<VIEW_HEIGH>") withString:(numH)
set ocidReadHTML to ocidReadHTML's stringByReplacingOccurrencesOfString:("<VIEW_WIDTH>") withString:(numW)
####################
## 保存
####################
##デスクトップ
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSDesktopDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidDesktopDirPathURL to ocidURLsArray's firstObject()
##
set strSubPath to ("" & strTemplateName & ".html") as text
set ocidSaveFilePathURL to ocidDesktopDirPathURL's URLByAppendingPathComponent:(strSubPath)
##
set listDone to ocidReadHTML's writeToURL:(ocidSaveFilePathURL) atomically:(true) encoding:(refMe's NSUTF8StringEncoding) |error|:(reference)



####################
## クリップボードテキスト取出
####################
to doGetPasteboard(argDefaultText)
	if argMesText = (missing value) then
		set strMesText to argMesText as text
	else
		set strMesText to "" as text
	end if
	## クリップボードの中身取り出し
	set ocidPasteboard to refMe's NSPasteboard's generalPasteboard()
	set ocidPastBoardTypeArray to ocidPasteboard's types
	###テキストがあれば
	set boolContain to ocidPastBoardTypeArray's containsObject:"public.utf8-plain-text"
	if boolContain = true then
		###値を格納する
		tell application "Finder"
			set strPasteboardString to (the clipboard as text) as text
		end tell
		###Finderでエラーしたら
	else
		set boolContain to ocidPastBoardTypeArray's containsObject:"NSStringPboardType"
		if boolContain = true then
			set ocidPasteboardString to ocidPasteboard's readObjectsForClasses:({refMe's NSString}) options:(missing value)
			set strPasteboardString to ocidPasteboardString as text
		else
			set strPasteboardString to (strMesText) as text
		end if
	end if
	return strPasteboardString
end doGetPasteboard

####################
## ダイアログ
####################
to doSetTextDialogue(strBundleID)
	set strDefaultAnswer to doGetPasteboard()
	###ダイアログ
	tell current application
		set strName to name as text
	end tell
	####スクリプトメニューから実行したら
	if strName is "osascript" then
		tell application "Finder" to activate
	else
		tell current application to activate
	end if
	##
	set ocidIconPathURL to doGetAppIconPathURL(strBundleID)
	set aliasIconPath to (ocidIconPathURL's absoluteURL()) as alias
	set recordResult to (display dialog strMes with title "入力してください" default answer strDefaultAnswer buttons {"OK", "キャンセル"} default button "OK" with icon aliasIconPath giving up after 20 without hidden answer) as record
	if "OK" is equal to (button returned of recordResult) then
		set strReturnedText to (text returned of recordResult) as text
	else if (gave up of recordResult) is true then
		return "時間切れです"
	else
		return "キャンセル"
	end if
	###NSStringに格納
	set ocidResponseText to (refMe's NSString's stringWithString:(strReturnedText))
	###タブと改行を除去しておく
	set ocidResponseTextM to refMe's NSMutableString's alloc()'s initWithCapacity:(0)
	ocidResponseTextM's appendString:(ocidResponseText)
	##改行除去
	set ocidResponseTextM to ocidResponseTextM's stringByReplacingOccurrencesOfString:("\n") withString:("")
	set ocidResponseTextM to ocidResponseTextM's stringByReplacingOccurrencesOfString:("\r") withString:("")
	##タブ除去
	set ocidResponseTextM to ocidResponseTextM's stringByReplacingOccurrencesOfString:("\t") withString:("")
	##
	return ocidResponseTextM
end doSetTextDialogue

####################
## アイコンURL取得
####################
to doGetAppIconPathURL(argBundleID)
	set strBundleID to argBundleID as text
	set ocidAppPathURL to doGetAppPathURL(strBundleID)
	if ocidAppPathURL is false then
		log "アプリケーションが見つかりませんでした"
		set strIconPath to ("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/FinderIcon.icns") as text
		set ocidIconPathStr to refMe's NSString's stringWithString:(strIconPath)
		set ocidIconPath to ocidIconPathStr's stringByStandardizingPath()
		set ocidIconPathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidIconPath) isDirectory:false)
		return ocidIconPathURL
	end if
	###アイコン名をPLISTから取得
	set ocidPlistPathURL to ocidAppPathURL's URLByAppendingPathComponent:("Contents/Info.plist") isDirectory:false
	set ocidPlistDict to refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistPathURL)
	set strIconFileName to (ocidPlistDict's valueForKey:("CFBundleIconFile")) as text
	###ICONのURLにして
	set strPath to ("Contents/Resources/" & strIconFileName) as text
	set ocidIconFilePathURL to ocidAppPathURL's URLByAppendingPathComponent:(strPath) isDirectory:false
	###拡張子の有無チェック
	set strExtensionName to (ocidIconFilePathURL's pathExtension()) as text
	if strExtensionName is "" then
		set ocidIconFilePathURL to ocidIconFilePathURL's URLByAppendingPathExtension:"icns"
	end if
	###ICONファイルが実際にあるか？チェック
	set appFileManager to refMe's NSFileManager's defaultManager()
	set boolExists to appFileManager's fileExistsAtPath:(ocidIconFilePathURL's |path|)
	###ICONがみつかない時
	if boolExists is false then
		return ocidFinderIconPathURL
	else
		return ocidIconFilePathURL
	end if
end doGetAppIconPathURL

####################
## アプリケーションURL取得
####################
to doGetAppPathURL(argBundleID)
	set strBundleID to argBundleID as text
	set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
	##バンドルIDからアプリケーションのURLを取得
	set ocidAppBundle to (refMe's NSBundle's bundleWithIdentifier:(argBundleID))
	if ocidAppBundle ≠ (missing value) then
		set ocidAppPathURL to ocidAppBundle's bundleURL()
	else if ocidAppBundle = (missing value) then
		set ocidAppPathURL to (appSharedWorkspace's URLForApplicationWithBundleIdentifier:(argBundleID))
	end if
	##予備（アプリケーションのURL）
	if ocidAppPathURL = (missing value) then
		tell application "Finder"
			try
				set aliasAppApth to (application file id strBundleID) as alias
				set strAppPath to (POSIX path of aliasAppApth) as text
				set strAppPathStr to refMe's NSString's stringWithString:(strAppPath)
				set strAppPath to strAppPathStr's stringByStandardizingPath()
				set ocidAppPathURL to refMe's NSURL's alloc()'s initFileURLWithPath:(strAppPath) isDirectory:true
			on error
				log "アプリケーションが見つかりませんでした"
				return false
			end try
		end tell
	end if
	return ocidAppPathURL
end doGetAppPathURL
