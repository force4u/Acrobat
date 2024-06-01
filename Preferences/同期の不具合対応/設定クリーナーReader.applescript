#! /usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
# AcrobatReader 設定ファイルクリーナー
# 同期で文字化けした？を削除します
# 実施後　同期をOFFにしてください
#
# Acrobatを終了した状態で実行してください
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application

##ファイルパス
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
set ocidPlistFilePathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences/com.adobe.Reader.plist") isDirectory:(false)
##NSDATA
set ocidOption to (refMe's NSDataReadingMappedIfSafe)
set listResponse to refMe's NSData's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL) options:(ocidOption) |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	log "正常処理"
	set ocidPlistData to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	log (item 2 of listResponse)'s code() as text
	log (item 2 of listResponse)'s localizedDescription() as text
	return "エラーしました"
end if
##NSDICT propertyListWithData
set ocidXmlPlist to (refMe's NSPropertyListBinaryFormat_v1_0)
set ocidPlistSerial to (refMe's NSPropertyListSerialization)
set ocidOption to (refMe's NSPropertyListMutableContainersAndLeaves)
set listResponse to ocidPlistSerial's propertyListWithData:(ocidPlistData) options:(ocidOption) format:(ocidXmlPlist) |error|:(reference)
if (item 2 of listResponse) = (missing value) then
	log "正常処理"
	set ocidPlistDict to (item 1 of listResponse)
else if (item 2 of listResponse) ≠ (missing value) then
	log (item 2 of listResponse)'s code() as text
	log (item 2 of listResponse)'s localizedDescription() as text
	return "エラーしました"
end if
##################
##本処理：再帰処理
doChkDict(ocidPlistDict)
##################
##保存
set listDone to ocidPlistDict's writeToURL:(ocidPlistFilePathURL) |error|:(reference)
if (item 1 of listDone) is true then
	log "正常終了"
else if (item 1 of listDone) is false then
	return "保存に失敗しました"
end if

##################
##同期設定ファイルをゴミ箱に入れる
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationSupportDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidApplicatioocidupportDirPathURL to ocidURLsArray's firstObject()
set ocidUserPrefsDirPathURL to ocidApplicatioocidupportDirPathURL's URLByAppendingPathComponent:("Adobe/Acrobat/DC/Acrobat/PrefSync/Preferences/UserPrefs_Prod") isDirectory:(true)
##
set listDone to (appFileManager's trashItemAtURL:(ocidUserPrefsDirPathURL) resultingItemURL:(ocidUserPrefsDirPathURL) |error|:(reference))
if (item 1 of listDone) is true then
	log "正常処理"
else if (item 2 of listDone) ≠ (missing value) then
	log (item 2 of listDone)'s code() as text
	log (item 2 of listDone)'s localizedDescription() as text
	return "エラーしました"
end if



########################
###DICTの処理　サブルーチン
to doChkDict(argObjDictionay)
	##ALLキーを取得して
	set ocidAllKeyArray to argObjDictionay's allKeys()
	##キーの数だけ繰り返し
	repeat with itemKey in ocidAllKeyArray
		##キーの値を取得して
		set ocidItemObject to (argObjDictionay's objectForKey:(itemKey))
		##クラスの名前を取得
		set strClassName to ocidItemObject's className() as text
		##クラスがArrayならArrayのサブルーチンに渡す
		if strClassName contains "Array" then
			doChkArray(ocidItemObject)
			##クラスがDictならDictのサブルーチンに渡す
		else if strClassName contains "Dictionary" then
			doChkDict(ocidItemObject)
			##クラスがテキストStringの場合だけ
		else if strClassName contains "String" then
			##値をテキストにして
			set strValue to ocidItemObject as text
			##?があれば削除する
			if strValue contains "?" then
				(ocidItemObject's setValue:("") forKey:(itemKey))
			end if
		end if
	end repeat
end doChkDict

########################
###Arrayの処理サブルーチン
to doChkArray(argObjectArray)
	##Arrayの数を数えて
	set numCntArray to argObjectArray's |count|() as integer
	##Arrayの数だけ繰り返し
	repeat with itemNo from 0 to (numCntArray - 1) by 1
		##Arrayを取得して
		set itemArray to (argObjectArray's objectAtIndex:(itemNo))
		##クラス名を取得
		set strClassName to itemArray's className() as text
		##クラスがArrayならArrayのサブルーチンに渡す
		if strClassName contains "Array" then
			doChkArray(ocidItemObject)
			##クラスがDictならDictのサブルーチンに渡す
		else if strClassName contains "Dictionary" then
			doChkDict(itemArray)
			##クラスがテキストStringの場合だけ
		else if strClassName contains "String" then
			##値をテキストにして
			set strValue to itemArray as text
			##?があれば削除する
			if strValue contains "?" then
				(argObjectArray's setObject:("") atIndexedSubscript:(itemNo))
			end if
		end if
	end repeat
	
end doChkArray