#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#	com.adobe.distiller
#	com.adobe.Acrobat.Pro
#	com.adobe.Reader
(*
USE
https://github.com/sveinbjornt/osxiconutils
*)
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

set appFileManager to refMe's NSFileManager's defaultManager()



####################################
###アイコンのパス
set strIconFilePath to "/Applications/Adobe Acrobat DC/Adobe Acrobat.app/Contents/Resources/ACP_App.icns" as text

####################################
####エイリアスが作られる場所 デスクトップ
set ocidHomeDirUrl to appFileManager's homeDirectoryForCurrentUser()
set ocidDesktopFilePathURL to ocidHomeDirUrl's URLByAppendingPathComponent:"Desktop"

################################################
####パス
################################################

set strItemPath to "/Applications/Adobe Acrobat DC/Adobe Acrobat.app" as text
####################################
####エイリアスの元ファイル
####################################
set ocidFilePathStr to (refMe's NSString's stringWithString:strItemPath)
set ocidFilePath to ocidFilePathStr's stringByStandardizingPath
set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:ocidFilePath isDirectory:false)
set ocidDirName to ocidFilePathURL's lastPathComponent()
set ocidDeskTopAliasFilePath to ocidDirName's stringByDeletingPathExtension()

###デスクトップにフォルダ名を追加してエリアスのパスに
set ocidAddAliasFilePathURL to (ocidDesktopFilePathURL's URLByAppendingPathComponent:ocidDeskTopAliasFilePath)
set strAddAliasFilePathURL to ocidAddAliasFilePathURL's |path|() as text

####################################
#### エイリアスを作る
####################################
set listBookMarkNSData to (ocidFilePathURL's bookmarkDataWithOptions:(refMe's NSURLBookmarkCreationSuitableForBookmarkFile) includingResourceValuesForKeys:{refMe's NSURLCustomIconKey} relativeToURL:(missing value) |error|:(reference))
set ocdiBookMarkData to (item 1 of listBookMarkNSData)
set listResults to (refMe's NSURL's writeBookmarkData:ocdiBookMarkData toURL:ocidAddAliasFilePathURL options:(refMe's NSURLBookmarkCreationSuitableForBookmarkFile) |error|:(reference))

####################################
#### アイコンを付与
####################################
tell application "Finder"
	set aliasIconFilePath to (path to me) as alias
	set aliiasContainerDirPath to container of aliasIconFilePath as alias
end tell
set strIconPath to (POSIX path of aliiasContainerDirPath) as text
set strBinPath to (strIconPath & "bin/seticon") as text
set strCommandText to ("\"" & strBinPath & "\" \"" & strIconFilePath & "\" \"" & strAddAliasFilePathURL & "\"") as text
do shell script strCommandText

return
