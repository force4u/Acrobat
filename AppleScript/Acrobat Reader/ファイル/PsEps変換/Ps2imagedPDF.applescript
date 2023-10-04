#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
# com.cocolog-nifty.quicktimer.icefloe
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


property refNSString : a reference to refMe's NSString
property refNSURL : a reference to refMe's NSURL
property refNSImage : a reference to refMe's NSImage
property refPDFDocument : a reference to refMe's PDFDocument
property refPDFPage : a reference to refMe's PDFPage

###################################
#####ダイアログ
###################################a
tell application "Finder"
	##set aliasDefaultLocation to container of (path to me) as alias
	set aliasDefaultLocation to (path to desktop folder from user domain) as alias
end tell
set listChooseFileUTI to {"com.adobe.postscript"}
set strPromptText to "ファイルを選んでください" as text
set listAliasFilePath to (choose file with prompt strPromptText default location (aliasDefaultLocation) of type listChooseFileUTI with invisibles and showing package contents without multiple selections allowed) as list
###################################
#####パス処理
###################################
###エリアス
set aliasFilePath to item 1 of listAliasFilePath as alias
###UNIXパス
set strFilePath to POSIX path of aliasFilePath as text
###String
set ocidFilePath to refNSString's stringWithString:strFilePath
###NSURL
set ocidFilePathURL to refNSURL's alloc()'s initFileURLWithPath:ocidFilePath isDirectory:false
####ファイル名を取得
set ocidFileName to ocidFilePathURL's lastPathComponent()
####拡張子を取得
set ocidFileExtension to ocidFilePathURL's pathExtension()
####ファイル名から拡張子を取っていわゆるベースファイル名を取得
set ocidPrefixName to ocidFileName's stringByDeletingPathExtension
####コンテナディレクトリ
set ocidContainerDirPathURL to ocidFilePathURL's URLByDeletingLastPathComponent()


###################################
#####保存ダイアログ
###################################
###ファイル名
set strPrefixName to ocidPrefixName as text
###拡張子
###同じ拡張子の場合
##set strFileExtension to ocidFileExtension as text
###拡張子変える場合
set strFileExtension to "pdf"
###ダイアログに出すファイル名
set strDefaultName to (strPrefixName & ".output." & strFileExtension) as text
set strPromptText to "名前を決めてください"
###選んだファイルの同階層をデフォルトの場合
set aliasDefaultLocation to ocidContainerDirPathURL as alias
####デスクトップの場合
##set aliasDefaultLocation to (path to desktop folder from user domain) as alias
####ファイル名ダイアログ
####実在しない『はず』なのでas «class furl»で
set aliasSaveFilePath to (choose file name default location aliasDefaultLocation default name strDefaultName with prompt strPromptText) as «class furl»
####UNIXパス
set strSaveFilePath to POSIX path of aliasSaveFilePath as text
####ドキュメントのパスをNSString
set ocidSaveFilePath to refNSString's stringWithString:strSaveFilePath
####ドキュメントのパスをNSURLに
set ocidSaveFilePathURL to refNSURL's fileURLWithPath:ocidSaveFilePath
###拡張子取得
set strFileExtensionName to ocidSaveFilePathURL's pathExtension() as text
###ダイアログで拡張子を取っちゃった時対策
if strFileExtensionName is not strFileExtension then
	set ocidSaveFilePathURL to ocidSaveFilePathURL's URLByAppendingPathExtension:strFileExtension
end if



###################################
#####本処理
###################################

###ファイルを読み込み
set ocidNsImage to refNSImage's alloc()'s initWithContentsOfURL:ocidFilePathURL

####PDFドキュメント初期化
set ocidPdfActivDoc to refPDFDocument's alloc()'s init()

###読み込んだイメージをPDFのページとして初期化
set ocidPdfPage to refPDFPage's alloc()'s initWithImage:ocidNsImage

####最初のページに挿入する
ocidPdfActivDoc's insertPage:ocidPdfPage atIndex:0

####ファイルを保存する
set boolResponse to ocidPdfActivDoc's writeToURL:ocidSaveFilePathURL

set ocidNsImage to ""
set ocidPdfPage to ""
set ocidPdfActivDoc to ""