#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##	use AppleScript version "2.8"
use framework "Foundation"
use scripting additions
property refMe : a reference to current application

##リーダー未対応
##set strBunndleID to "com.adobe.Reader"
set strBunndleID to "com.adobe.Acrobat.Pro"

###日本語キーのレコード
set recordArgToken to {|署名|:"macpdfmAndSign", |共有|:"macpdfmAndShare", |通常|:"macpdfm"} as record
set ocidArgDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
ocidArgDict's setDictionary:(recordArgToken)
set ocidAllKeys to ocidArgDict's allKeys()
set listAllKeys to ocidAllKeys as list

#######################################
###アプリケーションの有無チェック
set boolAppExist to false as boolean
try
	tell application id strBunndleID to launch
	####起動待ち最大１０秒
	repeat 10 times
		tell application id strBunndleID
			###frontmost前面チェックして
			set boolFrontMost to (frontmost) as boolean
		end tell
		###Finderが前面に来るようならリピート終了
		if boolFrontMost is true then
			exit repeat
		else
			###Finderの起動待ち１秒
			delay 1
		end if
		###ファインダーを前面に
		tell application id strBunndleID to activate
	end repeat
	
	tell application "Finder"
		###ファイル形式でアプリケーションの場所
		set fileAppPath to (get application file id strBunndleID)
		###エイリアス形式で受け取る
		set aliasAppPath to (fileAppPath) as alias
		###ファイルの有無
		set boolAppExist to true as boolean
	end tell
on error
	set boolAppExist to false as boolean
end try
###処理分岐
if boolAppExist is true then
	log "処理継続：アプリケーションがあります"
	set strAppPath to (POSIX path of aliasAppPath) as text
else if boolAppExist is false then
	log "アプリケーションがありません"
	return "処理終了：アプリケーションがありません"
end if
#######################################
#####ダイアログを前面に
tell current application
	set strName to name as text
end tell
####スクリプトメニューから実行したら
if strName is "osascript" then
	tell application "Finder" to activate
else
	tell current application to activate
end if
###ダイアログ
try
	set listResponse to (choose from list listAllKeys with title "選んでください" with prompt "起動方法を選んでください" default items (item 2 of listAllKeys) OK button name "OK" cancel button name "キャンセル" without multiple selections allowed and empty selection allowed)
on error
	log "エラーしました"
	return "エラーしました"
end try
if listResponse is false then
	return "キャンセルしました"
end if
####日本語キーのレコードの値の取得
set strKey to (item 1 of listResponse) as text
set ocidArgValue to (ocidArgDict's valueForKey:(strKey))
set strArgValue to ocidArgValue as text
#######################################
####ダイアログを出す
set aliasFilePath to (choose file with prompt "ファイルを選んでください" default location (path to desktop from user domain) of type {"com.adobe.pdf"} with invisibles and showing package contents without multiple selections allowed) as alias
set strFilePath to (POSIX path of aliasFilePath) as text

##### コマンド整形
set strCommandText to ("/usr/bin/open -a  \"" & strAppPath & "\" -n --args \"" & strFilePath & "\" -" & strArgValue & "") as text
do shell script strCommandText
####前面に出す
tell application id strBunndleID to activate

return
