#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#com.cocolog-nifty.quicktimer.icefloe
(*
swiftDialogが未インストールの場合
/Users/ユーザー名/Library/Application Support/Dialog
に
swiftDialogをインストールしいます
swiftDialog
https://github.com/swiftDialog/swiftDialog
*)
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "UniformTypeIdentifiers"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application


##########################
#設定項目　swiftDialog
property strDMGURL : a reference to ("https://github.com/swiftDialog/swiftDialog/releases/download/v2.5.5/swiftDialog.dmg") as text
property strCurrentVersion : a reference to ("2.5.5") as text
property strBundleID : a reference to ("au.csiro.dialog") as text

##########################
#設定開始
set ocidPrefDict to refMe's NSMutableDictionary's alloc()'s init()
#設定作成【bannerimage】
#【J】OSバージョンチェック
set numVerNo to doChkOsVer() as number
if numVerNo ≥ 15 then
	ocidPrefDict's setValue:("/System/Library/Desktop Pictures/.wallpapers/Sequoia Sunrise/Sequoia Sunrise Thumbnail.png") forKey:("bannerimage")
else if numVerNo ≥ 14 then
	ocidPrefDict's setValue:("/System/Library/Desktop Pictures/.thumbnails/Sonoma Light.heic") forKey:("bannerimage")
else if numVerNo ≥ 13 then
	ocidPrefDict's setValue:("/System/Library/Desktop Pictures/.thumbnails/Ventura Graphic Light.heic") forKey:("bannerimage")
else if numVerNo ≥ 12 then
	ocidPrefDict's setValue:("/System/Library/Desktop Pictures/.thumbnails/Monterey Graphic Light.heic") forKey:("bannerimage")
else
	#【K】エラーアラート
	return doExecAlert("swiftDialogにはOS12以上が必要です")
end if
#設定作成
ocidPrefDict's setValue:(true) forKey:("moveable")
ocidPrefDict's setValue:(false) forKey:("ontop")
ocidPrefDict's setValue:(false) forKey:("windowbuttons")
ocidPrefDict's setValue:(false) forKey:("blurscreen")

#設定作成【position】
#[topleft | left | bottomleft | top | center/centre | bottom | topright | right | bottomright]
ocidPrefDict's setValue:("topleft") forKey:("position")

#コマンドログファイルCOMMANDFILE_PATHは自動付与されるのでこのまま
ocidPrefDict's setValue:("«COMMANDFILE_PATH»") forKey:("commandfile")
#設定項目【timer】
#ocidPrefDict's setValue:(10) forKey:("timer")

#####################
#外観　サイズ
#ocidPrefDict's setValue:(true) forKey:("small")
#ocidPrefDict's setValue:(true) forKey:("big")
#ocidPrefDict's setValue:(true) forKey:("mini")
ocidPrefDict's setValue:(720) forKey:("width")
ocidPrefDict's setValue:(420) forKey:("height")

#バナーサイズ
ocidPrefDict's setValue:("72") forKey:("bannerheight")
ocidPrefDict's setValue:("Python3 pipインストール") forKey:("bannertitle")

#設定作成【appearance】　light　dark
ocidPrefDict's setValue:("light") forKey:("appearance")

#設定作成【title】
ocidPrefDict's setValue:("Python3 pipインストール") forKey:("title")
#設定作成【titlefont】
ocidPrefDict's setValue:("name=HiraMaruProN-W4, colour=#6EC9C4,weight=bold,size=36,shadow=1") forKey:("titlefont")

#設定作成【subtitle】※通知用なので使われない
ocidPrefDict's setValue:("インストール処理") forKey:("subtitle")

#設定作成【message】
ocidPrefDict's setValue:("pip PyMuPDF fitzをインストールします<br>実行後にターミナルが起動します") forKey:("message")
#設定作成【messageposition】
#[top | centre | center | bottom]
ocidPrefDict's setValue:("top") forKey:("messageposition")
#設定作成【messagealignment】
#[left | centre | center | right]
ocidPrefDict's setValue:("left") forKey:("messagealignment")
#設定作成【messagefont】
ocidPrefDict's setValue:("name=HiraMaruProN-W4,size=12") forKey:("messagefont")

#設定作成【icon】
ocidPrefDict's setValue:("computer") forKey:("icon")

#設定作成【button1text】
ocidPrefDict's setValue:("終了") forKey:("button1text")
ocidPrefDict's setValue:(false) forKey:("button1disabled")
ocidPrefDict's setValue:("キャンセル") forKey:("button2text")
ocidPrefDict's setValue:(false) forKey:("button2disabled")
#	right left center stack
ocidPrefDict's setValue:("right") forKey:("buttonstyle")

#####################
#設定作成【listitem】
#wait, success, fail, error, pending or progress
set ocidSubArray to refMe's NSMutableArray's alloc()'s init()
set ocidSubDict to refMe's NSMutableDictionary's alloc()'s init()
ocidSubDict's setValue:("Python3インストールチェック") forKey:("title")
ocidSubDict's setValue:(0) forKey:("index")
ocidSubDict's setValue:("pending") forKey:("status")
ocidSubDict's setValue:("処理待ち") forKey:("statustext")
ocidSubDict's setValue:("SF=desktopcomputer.and.arrow.down,colour=green") forKey:("icon")
ocidSubArray's addObject:(ocidSubDict)
ocidPrefDict's setValue:(ocidSubArray) forKey:("listitem")


#####################
#設定作成【checkboxstyle】
set ocidSubArray to refMe's NSMutableArray's alloc()'s init()
#
set ocidSubDict to refMe's NSMutableDictionary's alloc()'s init()
ocidSubDict's setValue:("pip アップデート") forKey:("label")
ocidSubDict's setValue:("Checkbox01") forKey:("name")
ocidSubDict's setValue:(true) forKey:("checked")
ocidSubDict's setValue:(false) forKey:("disabled")
ocidSubArray's addObject:(ocidSubDict)
#
set ocidSubDict to refMe's NSMutableDictionary's alloc()'s init()
ocidSubDict's setValue:("PyMuPDFアップデート") forKey:("label")
ocidSubDict's setValue:("Checkbox02") forKey:("name")
ocidSubDict's setValue:(true) forKey:("checked")
ocidSubDict's setValue:(false) forKey:("disabled")
ocidSubArray's addObject:(ocidSubDict)
#
set ocidSubDict to refMe's NSMutableDictionary's alloc()'s init()
ocidSubDict's setValue:("fitzアップデート") forKey:("label")
ocidSubDict's setValue:("Checkbox03") forKey:("name")
ocidSubDict's setValue:(true) forKey:("checked")
ocidSubDict's setValue:(false) forKey:("disabled")
ocidSubArray's addObject:(ocidSubDict)
#
ocidPrefDict's setValue:(ocidSubArray) forKey:("checkbox")
#
set ocidSubDict to refMe's NSMutableDictionary's alloc()'s init()
ocidSubDict's setValue:("switch") forKey:("style")
ocidSubDict's setValue:("mini") forKey:("size")
ocidPrefDict's setValue:(ocidSubDict) forKey:("checkboxstyle")

#####################
#設定作成【helpmessage】
ocidPrefDict's setValue:("個人・デバイスを特定できる情報もあります<br>SNS等に公開する場合は内容に留意ください<br>[詳しくはこちら](https://quicktimer.cocolog-nifty.com/icefloe/2025/01/post-9204e0.html)") forKey:("helpmessage")
#設定作成【infobutton】
ocidPrefDict's setValue:(true) forKey:("infobutton")
ocidPrefDict's setValue:("詳しい情報") forKey:("infobuttontext")
ocidPrefDict's setValue:("https://account.apple.com/account/manage/section/devices") forKey:("infobuttonaction")
ocidPrefDict's setValue:(true) forKey:("quitoninfo")
#【A】ディスク残を求める
set strDislLeft to doGetDiskLeft()
#設定作成【infobox】
ocidPrefDict's setValue:("{osversion} {osname}<br>{computermodel}<br>Disk: " & strDislLeft & "") forKey:("infobox")



#設定ここまで
##########################
#【B】JSON作成
set listResponse to doMakeJsonFiile(ocidPrefDict)
if listResponse is false then
	return doExecAlert("JSON設定ファイルの作成に失敗しました")
end if
set strJsonFilePath to (item 1 of listResponse) as text
set strLogFilePath to (item 2 of listResponse) as text
set ocidJsonSaveDirPathURL to (item 3 of listResponse)
set ocidLogFilePathURL to (item 4 of listResponse)

##########################
#ここから　swiftDialog
##########################
#【C】インストール済みチェック
# Launch Services Registerの値
set listResponse to doChkInstall(strBundleID)
if listResponse is false then
	#【K】エラーアラート
	return doExecAlert("インストールに失敗しました")
else
	set ocidAppPathURL to (item 1 of listResponse)
	set ocidExecPathURL to (item 2 of listResponse)
end if
##########################
#判定
if ocidAppPathURL is (missing value) then
	#【D】インストール
	set ocidResponse to doInstallSwiftDialog(strDMGURL)
	if ocidResponse is false then
		#【K】エラーアラート
		return doExecAlert("swiftDialogのインストールに失敗しました")
	else
		set ocidAppPathURL to ocidResponse
		set ocidExecPathURL to ocidAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
	end if
else
	log ocidAppPathURL's |path|() as text
	log ocidExecPathURL's |path|() as text
end if
##########################
#【E】バージョン・インストール確認
set listResponse to doChkVersion(ocidAppPathURL, strDMGURL)
if listResponse is false then
	#【K】エラーアラート
	return doExecAlert("バージョンの確認に失敗しました")
else
	set ocidAppPathURL to (item 1 of listResponse)
	set ocidExecPathURL to (item 2 of listResponse)
end if
##########################
#コマンド整形
set strBinPath to ocidExecPathURL's |path|() as text
set strCommandText to ("\"" & strBinPath & "\" --jsonfile \"" & strJsonFilePath & "\" & sleep 0.2") as text
log "\r" & strCommandText & "\r"

##########################
#タスク　実行
set appTermTask to refMe's NSTask's alloc()'s init()
appTermTask's setLaunchPath:("/bin/zsh")
#コマンドのオプションのArray
set ocidArgumentsArray to refMe's NSMutableArray's alloc()'s init()
ocidArgumentsArray's addObject:("-c")
ocidArgumentsArray's addObject:(strCommandText)
#コマンドセットして準備完了
appTermTask's setArguments:(ocidArgumentsArray)
#標準出力
set ocidOutPut to refMe's NSPipe's pipe()
appTermTask's setStandardOutput:(ocidOutPut)
#エラー出力
set ocidError to refMe's NSPipe's pipe()
appTermTask's setStandardError:(ocidError)
#実行ディレクトリJSONのある場所にする
appTermTask's setCurrentDirectoryURL:(ocidJsonSaveDirPathURL)
log "コマンド開始 Dialog"
set listDoneReturn to appTermTask's launchAndReturnError:(reference)
if (item 1 of listDoneReturn) is (false) then
	log "エラーコード：" & (item 2 of listDoneReturn)'s code() as text
	log "エラードメイン：" & (item 2 of listDoneReturn)'s domain() as text
	log "Description:" & (item 2 of listDoneReturn)'s localizedDescription() as text
	log "FailureReason:" & (item 2 of listDoneReturn)'s localizedFailureReason() as text
end if
#PID
set numTaskPID to appTermTask's processIdentifier()
#################################▼▼
#################################▼▼
delay 1
set strLogText to ("listitem: title : Python3インストールチェック, status : wait, statustext : チェック中\nbutton1: disable") as text
set strResponse to doWriteLogFile(strLogText, ocidLogFilePathURL)
if strResponse is false then
	return "更新失敗"
end if


delay 3
#PyPath
set strCommandText to ("/usr/bin/which python3") as text
set strResponse to doZshShellScript(strCommandText)

if strResponse is false then
	#実行ボタンをdisable
	#message更新
	set strLogText to ("button1: disable\nmessage: python3が利用可能ではありません<br>サポートまでご連絡ください<br>[詳しくはこちら](https://quicktimer.cocolog-nifty.com/icefloe/2024/09/post-84bace.html)") as text
	set strResponse to doWriteLogFile(strLogText, ocidLogFilePathURL)
	if strResponse is false then
		return "更新失敗"
	end if
else
	set strPyBinPath to strResponse as text
	#infobox更新
	set strLogText to ("infobox: {osversion} {osname}<br>{computermodel}<br>python: " & strPyBinPath & "\nlistitem: title : Python3インストールチェック, status : success, statustext : OK " & strPyBinPath & "\nbutton1: enable") as text
	set strResponse to doWriteLogFile(strLogText, ocidLogFilePathURL)
	if strResponse is false then
		return "更新失敗"
	end if
	set strResponse to doZshShellScript("/bin/mkdir -p $HOME/Library/Caches/pip")
	set strResponse to doZshShellScript("/bin/chmod 777 $HOME/Library/Caches/pip")
	set strResponse to doZshShellScript("/bin/mkdir -p $HOME/Library/Python/3.9/lib/python/site-packages")
	set strResponse to doZshShellScript("/bin/chmod 755 $HOME/Library/Python/3.9/lib/python/site-packages")
	
end if

#タイトル更新
set strLogText to ("title: 選んでください") as text
set strResponse to doWriteLogFile(strLogText, ocidLogFilePathURL)
if strResponse is false then
	return "更新失敗"
end if
#################################▲▲
#################################▲▲
#終了待ち
appTermTask's waitUntilExit()
log "コマンド終了 Dialog"
#################################
#戻り値チェック
set numReturnNo to appTermTask's terminationStatus() as integer
#戻り値による後処理分岐
if numReturnNo = 0 then
	log "正常終了のエラー番号"
	#標準出力を呼び出して
	set ocidOutPutData to ocidOutPut's fileHandleForReading()
	#標準出力データを読み出し
	set listResponse to ocidOutPutData's readDataToEndOfFileAndReturnError:(reference)
	if (item 1 of listDoneReturn) is (false) then
		#【K】エラーアラート
		return doExecAlert("標準出力の展開に失敗しました")
	end if
	set ocidStdOut to (item 1 of listResponse)
	#テキストにする
	set ocidStdOut to refMe's NSString's alloc()'s initWithData:(ocidStdOut) encoding:(refMe's NSUTF8StringEncoding)
	#コード０で戻り値が空なら
	if (ocidStdOut as text) is "" then
		log "ウィンドウ左上の閉じるボタンでClose"
		log "または"
		log "ログファイルから終了コマンドを受け取りました"
		return "ウィンドウ左上の閉じるボタンでClose または　ログファイルから終了コマンドを受け取りました"
	end if
else if numReturnNo = 2 then
	log "ボタン２を選択(キャンセル)"
	return "終了しました"
else if numReturnNo = 3 then
	log "ボタン３(infoボタン)を選択"
	return "終了しました"
else if numReturnNo = 5 then
	log "logファイルから終了コードをうけ取りました"
	return "終了しました"
else if numReturnNo = 10 or numErrorNo = 5 then
	#【K】ユーザーが終了したのでここで終わり
	return doExecAlert("ダイアログをコマンド(⌘Q)で終了しました\rまた後で実行してください")
else if numReturnNo = 30 then
	#【K】次に進めないエラーなのでここまで
	return doExecAlert("入力に誤りがありました")
else if numReturnNo = 201 or numErrorNo = 202 then
	#【K】次に進めないエラーなのでここまで
	return doExecAlert("必要なファイルが見つかりませんでした")
else if numReturnNo < 0 then
	#【K】システムエラーの場合はここで終了
	return doExecAlert("システムエラー（エラーコードが負の値）\r\rhttps://quicktimer.cocolog-nifty.com/icefloe/files/applescript_error_no.html\r\rです")
else
	log "コマンド Dialogでエラーになりました"
	set ocidErrorData to ocidError's fileHandleForReading()
	set listResponse to ocidErrorData's readDataToEndOfFileAndReturnError:(reference)
	set ocidErrorOutData to (item 1 of listResponse)
	#【K】Dialogエラー
	return doExecAlert("エラー終了しました")
end if


##############################
#今回は使わない
#正常戻り値を加工 JSONの場合
if strCommandText contains " --json " then
	#【F】戻り値を加工 JSON
	set ocidJsonObject to doMakeJson2Dict(ocidStdOut)
	set strClassName to ocidJsonObject's className() as text
	#たぶんDICT形式のみだと思うのだが念のため
	if strClassName contains "Dictionary" then
		set ocidResponseDict to ocidJsonObject
	else if strClassName contains "Array" then
		set ocidResponseArray to ocidJsonObject
	end if
else
	#正常戻り値を加工 テキストの場合 DICT
	#【G】テキスト戻り値をDICTに
	set listResponse to doMakeText2Dict(ocidStdOut)
	set recordResponse to (item 1 of listResponse) as record
	set ocidResponseDict to (item 2 of listResponse)
end if
set ocidAllValueArray to ocidResponseDict's allValues()
set boolContainBlankValue to ocidAllValueArray's containsObject:("")
if boolContainBlankValue is true then
	#【K】エラー終了
	return doExecAlert("未選択・未入力の項目がありましたので終了します")
end if
##########################
#戻り値確認
log ocidResponseDict as record
log ocidResponseDict's allKeys() as list
log ocidResponseDict's allValues() as list

##########################
#戻り値で処理
set boolPip to (ocidResponseDict's valueForKey:("Checkbox01")) as boolean
set boolMuPDF to (ocidResponseDict's valueForKey:("Checkbox02")) as boolean
set boolFitz to (ocidResponseDict's valueForKey:("Checkbox03")) as boolean

if boolPip is true then
	set strCommandText to ("\"" & strPyBinPath & "\" -m pip install --upgrade --user pip") as text
	doExecTerminal(strCommandText)
end if
if boolMuPDF is true then
	set strCommandText to ("\"" & strPyBinPath & "\" -m pip install --user pymupdf") as text
	doExecTerminal(strCommandText)
	set strCommandText to ("\"" & strPyBinPath & "\" -m pip install --upgrade --user pymupdf") as text
	doExecTerminal(strCommandText)
end if
if boolFitz is true then
	set strCommandText to ("\"" & strPyBinPath & "\" -m pip install --user fitz") as text
	doExecTerminal(strCommandText)
	set strCommandText to ("\"" & strPyBinPath & "\" -m pip install --upgrade --user fitz") as text
	doExecTerminal(strCommandText)
end if



##########################
#
to doExecTerminal(argCommandText)
	set boolBusy to true as boolean
	tell application "Terminal"
		launch
		activate
		set objWindowID to (do script "\n\n")
		delay 1
		do script argCommandText in objWindowID
	end tell
	repeat
		tell application "Terminal"
			tell objWindowID
				set boolBusy to busy as boolean
			end tell
		end tell
		if boolBusy is false then
			exit repeat
		else
			delay 0.5
		end if
	end repeat
	
	tell application "Terminal"
		do script "\n\n" in objWindowID
		do script "exit" in objWindowID
		set theWid to get the id of window 1
		delay 1
		close front window saving no
	end tell
	
end doExecTerminal
return "処理終了"
###############################################
#メイン処理ここまで
###############################################

##########################
#【F】JSONの戻り値をDICTかArrayにする
to doMakeJson2Dict(argJsonString)
	set ocidJsonSring to refMe's NSString's stringWithString:(argJsonString)
	set ocidJsonSring to (ocidJsonSring's stringByReplacingOccurrencesOfString:("\r") withString:("\n"))
	set ocidJsonData to ocidJsonSring's dataUsingEncoding:(refMe's NSUTF8StringEncoding)
	set listResponse to refMe's NSJSONSerialization's JSONObjectWithData:(ocidJsonData) options:0 |error|:(reference)
	if (item 2 of listResponse) = (missing value) then
		log "JSONObjectWithData 正常処理"
		set ocidJsonObject to (item 1 of listResponse)
	else if (item 2 of listResponse) ≠ (missing value) then
		set strErrorNO to (item 2 of listResponse)'s code() as text
		set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "JSONObjectWithData　エラーしました" & strErrorNO & strErrorMes
		return false
	end if
	return ocidJsonObject
	
end doMakeJson2Dict


##########################
#【G】テキストの戻り値をレコードにする
to doMakeText2Dict(argText)
	#可変テキスト
	set ocidResponseString to refMe's NSMutableString's alloc()'s init()
	ocidResponseString's setString:("{|")
	ocidResponseString's appendString:(argText)
	set ocidResponseString to (ocidResponseString's stringByReplacingOccurrencesOfString:("\r") withString:("\n"))
	#文末最後が改行の場合は最後の改行を削除する
	set boolLastReturn to (ocidResponseString's hasSuffix:("\n")) as boolean
	if boolLastReturn is true then
		set numStringLength to ocidResponseString's |length|() as integer
		set ocidResponseString to ocidResponseString's substringToIndex:(numStringLength - 1)
	else
		set ocidResponseString to ocidResponseString
	end if
	
	set ocidResponseString to (ocidResponseString's stringByReplacingOccurrencesOfString:("\"") withString:(""))
	ocidResponseString's appendString:("\"}")
	#置換
	set ocidResponseString to (ocidResponseString's stringByReplacingOccurrencesOfString:("\n") withString:("\",|"))
	set ocidResponseString to (ocidResponseString's stringByReplacingOccurrencesOfString:(" : ") withString:("|:\""))
	#
	set ocidResponseString to (ocidResponseString's stringByReplacingOccurrencesOfString:("\"true\"") withString:("true"))
	set ocidResponseString to (ocidResponseString's stringByReplacingOccurrencesOfString:("\"false\"") withString:("false"))
	set strResponseString to ocidResponseString as text
	#レコードにする
	try
		set recordResponse to (run script "return " & strResponseString & "") as record
	on error
		return false
	end try
	#DICTにする
	set ocidResponseDict to refMe's NSMutableDictionary's alloc()'s init()
	ocidResponseDict's setDictionary:(recordResponse)
	#戻す
	return {recordResponse, ocidResponseDict}
	
end doMakeText2Dict

##########################
#【C】インストール済みチェック
to doChkInstall(argBundleID)
	set ocidAppBundle to (refMe's NSBundle's bundleWithIdentifier:(argBundleID))
	if ocidAppBundle = (missing value) then
		#バンドルで見つからない場合　NSWorkspace
		set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
		set ocidAppPathURL to (appSharedWorkspace's URLForApplicationWithBundleIdentifier:(argBundleID))
		if ocidAppPathURL = (missing value) then
			#AppKitで見つからない場合 Finder
			try
				tell application "Finder"
					set aliasAppApth to (application file id argBundleID) as alias
					set strAppPath to (POSIX path of aliasAppApth) as text
				end tell
				set strAppPathStr to (refMe's NSString's stringWithString:(strAppPath))
				set strAppPath to strAppPathStr's stringByStandardizingPath()
				set ocidAppPathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(strAppPath) isDirectory:true)
				set ocidExecPathURL to ocidAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
			on error
				#見つからない
				set ocidAppPathURL to (missing value)
				set ocidExecPathURL to (missing value)
			end try
		else
			set ocidExecPathURL to ocidAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
		end if
	else
		#バンドルで見つかる場合
		set ocidAppPathURL to ocidAppBundle's bundleURL()
		set ocidExecPathURL to ocidAppBundle's executableURL()
	end if
	##########################
	#本当にあるか？チェック
		if ocidAppPathURL = (missing value) then
		set ocidResponse to doInstallSwiftDialog(strDMGURL)
					set ocidAppPathURL to ocidResponse
			set ocidExecPathURL to ocidAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
	end if
	set ocidAppPath to ocidAppPathURL's |path|()
	set appFileManager to refMe's NSFileManager's defaultManager()
	set boolDirExists to appFileManager's fileExistsAtPath:(ocidAppPath) isDirectory:(true)
	if boolDirExists is true then
		log "インストール済み"
	else if boolDirExists is false then
		#【D】インストール
		set ocidResponse to doInstallSwiftDialog(strDMGURL)
		if ocidResponse is false then
			log "swiftDialogのインストールに失敗しました"
			return false
		else
			set ocidAppPathURL to ocidResponse
			set ocidExecPathURL to ocidAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
		end if
	else
		log ocidAppPathURL's |path|() as text
		log ocidExecPathURL's |path|() as text
	end if
	set listResponse to {ocidAppPathURL, ocidExecPathURL} as list
	return listResponse
end doChkInstall

##########################
#【E】バージョン確認
to doChkVersion(argAppPathURL)
	set ocidAppBundle to refMe's NSBundle's alloc()'s initWithURL:(argAppPathURL)
	set ocidVersion to (ocidAppBundle's objectForInfoDictionaryKey:("CFBundleVersion"))
	set ocidVerShort to (ocidAppBundle's objectForInfoDictionaryKey:("CFBundleShortVersionString"))
	if strCurrentVersion is (ocidVerShort as text) then
		log "最新版を利用中" & ocidVerShort as text
		set ocidAppPathURL to argAppPathURL
		set ocidExecPathURL to argAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
	else
		#【D】インストール
		set ocidResponse to doInstallSwiftDialog(strDMGURL)
		if ocidResponse is false then
			log "swiftDialogのインストールに失敗しました"
			return false
		else
			set ocidAppPathURL to ocidResponse
			set ocidExecPathURL to argAppPathURL's URLByAppendingPathComponent:("Contents/MacOS/Dialog") isDirectory:(false)
		end if
		log ocidAppPathURL's |path|() as text
		log ocidExecPathURL's |path|() as text
	end if
	set listResponse to {ocidAppPathURL, ocidExecPathURL} as list
	return listResponse
end doChkVersion

##########################
#【D】swiftDialogインストールユーザー
to doInstallSwiftDialog(argDMGURL)
	set ocidDMGURLString to refMe's NSString's stringWithString:(argDMGURL)
	set ocidDNGURL to refMe's NSURL's alloc()'s initWithString:(ocidDMGURLString)
	#判定用
	set boolDone to true as boolean
	##########################
	#ダウンロード
	set appFileManager to refMe's NSFileManager's defaultManager()
	set ocidTempDirURL to appFileManager's temporaryDirectory()
	set ocidUUID to refMe's NSUUID's alloc()'s init()
	set ocidUUIDString to ocidUUID's UUIDString
	set ocidSaveDirPathURL to ocidTempDirURL's URLByAppendingPathComponent:(ocidUUIDString) isDirectory:(true)
	#Tmp Dir
	set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
	ocidAttrDict's setValue:(511) forKey:(refMe's NSFilePosixPermissions)
	#フォルダを作る
	set listDone to appFileManager's createDirectoryAtURL:(ocidSaveDirPathURL) withIntermediateDirectories:(true) attributes:(ocidAttrDict) |error|:(reference)
	if (item 1 of listDone) is false then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		set boolDone to false as boolean
	end if
	#Download save
	set ocidDMGFileName to ocidDNGURL's lastPathComponent()
	set ocidDMGSaveFilePathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:(ocidDMGFileName) isDirectory:(false)
	set strDMGSaveFilePath to ocidDMGSaveFilePathURL's |path|() as text
	#Download
	set ocidOption to (refMe's NSDataReadingMappedIfSafe)
	set listResponse to refMe's NSData's alloc()'s initWithContentsOfURL:(ocidDNGURL) options:(ocidOption) |error|:(reference)
	if (item 2 of listResponse) = (missing value) then
		log "initWithContentsOfURL 正常処理"
		set ocidReadData to (item 1 of listResponse)
	else if (item 2 of listResponse) ≠ (missing value) then
		set strErrorNO to (item 2 of listResponse)'s code() as text
		set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		set boolDone to false as boolean
	end if
	##保存
	set ocidOption to (refMe's NSDataWritingAtomic)
	set listDone to ocidReadData's writeToURL:(ocidDMGSaveFilePathURL) options:(ocidOption) |error|:(reference)
	if (item 1 of listDone) is true then
		log "writeToURL 正常処理"
	else if (item 2 of listDone) ≠ (missing value) then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		set boolDone to false as boolean
	end if
	##########################
	#MOUNT POINT
	set ocidDMGMountPointPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("Dialog") isDirectory:(true)
	#フォルダを作る
	set listDone to appFileManager's createDirectoryAtURL:(ocidDMGMountPointPathURL) withIntermediateDirectories:(true) attributes:(ocidAttrDict) |error|:(reference)
	if (item 1 of listDone) is false then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		set boolDone to false as boolean
	end if
	#コマンド用のパス
	set strMountPoint to ocidDMGMountPointPathURL's |path|() as text
	#DMG APPpath
	set ocidDMGAppPathURL to ocidDMGMountPointPathURL's URLByAppendingPathComponent:("Dialog.app") isDirectory:(true)
	#DIST 
	set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSApplicationSupportDirectory) inDomains:(refMe's NSUserDomainMask))
	set ocidApplicatioocidupportDirPathURL to ocidURLsArray's firstObject()
	set ocidDistDirPathURL to ocidApplicatioocidupportDirPathURL's URLByAppendingPathComponent:("Dialog") isDirectory:(true)
	#アクセス権を変更
	ocidAttrDict's setValue:(448) forKey:(refMe's NSFilePosixPermissions)
	set listDone to appFileManager's createDirectoryAtURL:(ocidDistDirPathURL) withIntermediateDirectories:(true) attributes:(ocidAttrDict) |error|:(reference)
	if (item 1 of listDone) is false then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		set boolDone to false as boolean
	end if
	#DistApp Path
	set ocidDistAppPathURL to ocidDistDirPathURL's URLByAppendingPathComponent:("Dialog.app") isDirectory:(true)
	#ディスクマウント
	set strCommandText to ("/usr/bin/hdiutil attach \"" & strDMGSaveFilePath & "\" -noverify  -noautoopen -nobrowse -mountpoint \"" & strMountPoint & "\"") as text
	log "\r" & strCommandText & "\r"
	log "コマンド開始　detach"
	# 【N】zsh実行
	set strResponse to doZshShellScript(strCommandText)
	log "コマンド終了　detach"
	if strResponse is false then
		set boolDone to false as boolean
	end if
	##########################
	#コピー前に旧バージョンをゴミ箱に
	set ocidDistAppPath to ocidDistAppPathURL's |path|()
	set boolDirExists to appFileManager's fileExistsAtPath:(ocidDistAppPath) isDirectory:(true)
	if boolDirExists is true then
		set listDone to (appFileManager's trashItemAtURL:(ocidDistAppPathURL) resultingItemURL:(ocidDistAppPathURL) |error|:(reference))
		if (item 2 of listDone) ≠ (missing value) then
			set strErrorNO to (item 2 of listDone)'s code() as text
			set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
			refMe's NSLog("■：" & strErrorNO & strErrorMes)
			log "エラーしました" & strErrorNO & strErrorMes
			set boolDone to false as boolean
		end if
	end if
	
	##########################
	#COPY
	set appFileManager to refMe's NSFileManager's defaultManager()
	set listDone to (appFileManager's copyItemAtURL:(ocidDMGAppPathURL) toURL:(ocidDistAppPathURL) |error|:(reference))
	if (item 1 of listDone) is false then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		set boolDone to false as boolean
	end if
	
	##########################
	#アンマウント
	set strCommandText to ("/usr/bin/hdiutil detach  \"" & strMountPoint & "\" -force") as text
	log "\r" & strCommandText & "\r"
	log "コマンド開始　detach"
	# 【N】zsh実行
	set strResponse to doZshShellScript(strCommandText)
	log "コマンド終了　detach"
	if strResponse is false then
		set boolDone to false as boolean
	end if
	
	##########################
	#launchdに登録するために一回実行しておく
	set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
	set boolResponse to appSharedWorkspace's openURL:(ocidDistAppPathURL)
	if (item 1 of listDone) is false then
		log "NSWorkspace's エラーしました"
		set boolDone to false as boolean
	end if
	##########################
	#結果を戻す
	if boolDone is false then
		return false
	else
		return ocidDistAppPathURL
	end if
	
end doInstallSwiftDialog

##########################
#【J】OSチェック
to doChkOsVer()
	set appFileManager to refMe's NSFileManager's defaultManager()
	set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSCoreServiceDirectory) inDomains:(refMe's NSSystemDomainMask))
	set ocidCoreServiceDirPathURL to ocidURLsArray's firstObject()
	set ocidPlistFilePathURL to ocidCoreServiceDirPathURL's URLByAppendingPathComponent:("SystemVersion.plist") isDirectory:(false)
	set listResponse to refMe's NSDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL) |error|:(reference)
	if (item 1 of listResponse) ≠ (missing value) then
		set ocidPlistDict to (item 1 of listResponse)
	else if (item 2 of listResponse) ≠ (missing value) then
		set strErrorNO to (item 2 of listResponse)'s code() as text
		set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		return false
	end if
	set ocidVerString to (ocidPlistDict's valueForKey:("ProductVersion"))'s doubleValue()
	return ocidVerString
end doChkOsVer

##########################
#【K】エラーアラート
to doExecAlert(argMessageText)
	#ダイアログを前面に出す
	set strName to (name of current application) as text
	if strName is "osascript" then
		tell application "Finder" to activate
	else
		tell current application to activate
	end if
	try
		set recordResponse to (display alert argMessageText buttons {"終了", "再実行"} default button "終了" cancel button "終了" as informational giving up after 5) as record
	on error
		log "エラーしました"
		return "キャンセルしました。"
	end try
	if true is equal to (gave up of recordResponse) then
		return "時間切れです。"
	end if
	set strBottonName to (button returned of recordResponse) as text
	if "再実行" is equal to (strBottonName) then
		tell application "Finder"
			set aliasPathToMe to (path to me) as alias
		end tell
		run script aliasPathToMe with parameters "再実行"
		return
	else if "終了" is equal to (strBottonName) then
		return "終了を確認しました。"
	else if "中断" is equal to (strBottonName) then
		return "中断"
	end if
end doExecAlert

##########################
# 【M】SH　実行
to doShShellScript(argBinPath, argCommandText)
	set strExec to ("\"" & argBinPath & "\" \"" & argCommandText & "\"") as text
	log "コマンド開始\r" & strExec & "\r"
	##########
	#コマンド実行
	try
		set strResnponse to (do shell script strExec) as text
		log "コマンド終了"
	on error
		return false
	end try
	return strResnponse
end doShShellScript


##########################
# 【M】Bash　実行
to doBashShellScript(argCommandText)
	set strCommandText to argCommandText as text
	log "コマンド開始\r" & strCommandText & "\r"
	set strExec to ("/bin/bash -c '" & strCommandText & "'") as text
	##########
	#コマンド実行
	try
		set strResnponse to (do shell script strExec) as text
		log "コマンド終了"
	on error
		return false
	end try
	return strResnponse
end doBashShellScript

##########################
# 【N】ZSH　実行
to doZshShellScript(argCommandText)
	set strCommandText to argCommandText as text
	log "コマンド開始\r" & strCommandText & "\r"
	set strExec to ("/bin/zsh -c '" & strCommandText & "'") as text
	##########
	#コマンド実行
	try
		set strResnponse to (do shell script strExec) as text
		log "コマンド終了"
	on error
		return false
	end try
	return strResnponse
end doZshShellScript

##########################
#【A】ディスク残を求める
to doGetDiskLeft()
	#ディスク残を求める
	set appFileManager to refMe's NSFileManager's defaultManager()
	set listResponse to appFileManager's attributesOfFileSystemForPath:("/System/Volumes/Data") |error|:(reference)
	if (item 2 of listResponse) = (missing value) then
		log "正常処理　attributesOfFileSystemForPath"
		set ocidAttrDict to (item 1 of listResponse)
	else if (item 2 of listResponse) ≠ (missing value) then
		set strErrorNO to (item 2 of listResponse)'s code() as text
		set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		return false
	end if
	#ディスク残を求める
	set ocidFreeSize to ocidAttrDict's objectForKey:(refMe's NSFileSystemFreeSize)
	set strFreeBite to ocidFreeSize's stringValue()
	set ocidFullSize to ocidAttrDict's objectForKey:(refMe's NSFileSystemSize)
	set strFullBite to ocidFullSize's stringValue()
	set ocidFreeBiteDeci to refMe's NSDecimalNumber's decimalNumberWithString:(strFreeBite)
	set ocidFullBiteDeci to refMe's NSDecimalNumber's decimalNumberWithString:(strFullBite)
	#指数はお好みで
	#	set realGB to "1073741824" as real
	set realGB to "1000000000" as real
	#割り算
	set ocidFreeGbDeci to ocidFreeBiteDeci's decimalNumberByDividingBy:(realGB)
	set ocidFullGbDeci to ocidFullBiteDeci's decimalNumberByDividingBy:(realGB)
	#小数点以下２桁
	set appNumberFormatter to refMe's NSNumberFormatter's alloc()'s init()
	appNumberFormatter's setPositiveFormat:("0.00")
	set ocidFreeGb to appNumberFormatter's stringFromNumber:(ocidFreeGbDeci)
	set ocidFullGb to appNumberFormatter's stringFromNumber:(ocidFullGbDeci)
	#戻り値変えるならここを変更
	set strReturnText to ("" & ocidFreeGb & "/" & ocidFullGb & " GB") as text
	if ocidFullGb = (missing value) or ocidFreeGb = (missing value) then
		return false
	else
		return strReturnText
	end if
end doGetDiskLeft

##########################
#【B】JSON作成
to doMakeJsonFiile(argPrefDict)
	#保存先
	set appFileManager to refMe's NSFileManager's defaultManager()
	set ocidTempDirURL to appFileManager's temporaryDirectory()
	set ocidUUID to refMe's NSUUID's alloc()'s init()
	set ocidUUIDString to ocidUUID's UUIDString
	set ocidJsonSaveDirPathURL to ocidTempDirURL's URLByAppendingPathComponent:(ocidUUIDString) isDirectory:(true)
	set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s init()
	ocidAttrDict's setValue:(511) forKey:(refMe's NSFilePosixPermissions)
	set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidJsonSaveDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
	#
	set strFileName to "swiftDialog.json" as text
	set ocidJsonFilePathURL to ocidJsonSaveDirPathURL's URLByAppendingPathComponent:(strFileName) isDirectory:(false)
	set strJsonFilePath to ocidJsonFilePathURL's |path|() as text
	#
	set strLogFileName to "dialog.log" as text
	set ocidLogFilePathURL to ocidJsonSaveDirPathURL's URLByAppendingPathComponent:(strLogFileName) isDirectory:(false)
	set strLogFilePath to ocidLogFilePathURL's |path|() as text
	#ログファイルパスの置換
	argPrefDict's setValue:(strLogFilePath) forKey:("commandfile")
	
	#変換
	set listResponse to (refMe's NSJSONSerialization's dataWithJSONObject:(argPrefDict) options:(refMe's NSJSONReadingMutableContainers) |error|:(reference))
	if (item 2 of listResponse) = (missing value) then
		log "正常処理"
		set ocidJsonData to (item 1 of listResponse)
	else if (item 2 of listResponse) ≠ (missing value) then
		set strErrorNO to (item 2 of listResponse)'s code() as text
		set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		#【K】エラーアラート
		return doExecAlert("設定のJSON変換に失敗しました")
	end if
	#保存
	##NSDataで保存
	set ocidOption to (refMe's NSDataWritingAtomic)
	set listDone to ocidJsonData's writeToURL:(ocidJsonFilePathURL) options:(ocidOption) |error|:(reference)
	if (item 1 of listDone) is true then
		log "正常処理"
	else if (item 2 of listDone) ≠ (missing value) then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		return false
	end if
	#
	set listReturn to {strJsonFilePath, strLogFilePath, ocidJsonSaveDirPathURL, ocidLogFilePathURL} as list
	return listReturn
end doMakeJsonFiile

#################################
#【Y】ログファイルコマンド追記
to doWriteLogFile(argLogText, argSaveFilePathURL)
	set ocidEncode to (refMe's NSUTF8StringEncoding)
	#テキスト読み取り
	set listResponse to refMe's NSMutableString's alloc()'s initWithContentsOfURL:(argSaveFilePathURL) encoding:(ocidEncode) |error|:(reference)
	if (item 2 of listResponse) = (missing value) then
		log "ログファイル読み取り正常処理"
		set ocidReadString to (item 1 of listResponse)
	else if (item 2 of listResponse) ≠ (missing value) then
		set strErrorNO to (item 2 of listResponse)'s code() as text
		set strErrorMes to (item 2 of listResponse)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		return false
	end if
	#テキスト受け取り
	set ocidWriteString to refMe's NSString's alloc()'s initWithString:(argLogText)
	#テキスト追加
	ocidReadString's appendString:(ocidWriteString)
	ocidReadString's appendString:("\n")
	#NSDataにして
	set ocidWriteData to ocidReadString's dataUsingEncoding:(refMe's NSUTF8StringEncoding)
	#NSDataで保存
	set ocidOption to (refMe's NSDataWritingFileProtectionComplete)
	set listDone to ocidWriteData's writeToURL:(argSaveFilePathURL) options:(ocidOption) |error|:(reference)
	if (item 1 of listDone) is true then
		log "ログファイル書き込み正常処理"
		return true
	else if (item 2 of listDone) ≠ (missing value) then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		return false
	end if
	return true
end doWriteLogFile


#################################
#ゴミ箱に入れる
to doGoToTrash(argFilePath)
	set ocidFilePathStr to refMe's NSString's stringWithString:(argFilePath)
	set ocidFilePath to ocidFilePathStr's stringByStandardizingPath()
	set ocidFilePathURL to (refMe's NSURL's alloc()'s initFileURLWithPath:(ocidFilePath) isDirectory:false)
	set appFileManager to refMe's NSFileManager's defaultManager()
	set listDone to (appFileManager's trashItemAtURL:(ocidFilePathURL) resultingItemURL:(ocidFilePathURL) |error|:(reference))
	if (item 2 of listDone) ≠ (missing value) then
		set strErrorNO to (item 2 of listDone)'s code() as text
		set strErrorMes to (item 2 of listDone)'s localizedDescription() as text
		refMe's NSLog("■：" & strErrorNO & strErrorMes)
		log "エラーしました" & strErrorNO & strErrorMes
		#エラーでもTRUEでいい
		return true
	end if
	return true
end doGoToTrash

##########################
#【Q】タスクチェック
to doChkTaskRunning(argBundleID)
	set boolRuning to (missing value)
	set appRunAppArray to refMe's NSRunningApplication's runningApplicationsWithBundleIdentifier:(argBundleID)
	set appRunApp to appRunAppArray's firstObject()
	if appRunApp = (missing value) then
		return false
	else
		log appRunApp's processIdentifier()
		return true
	end if
end doChkTaskRunning

##########################
#【O】タスクを終了させる
to doQuitTask(argAppNSTask, argLogFilePathURL)
	set strLogText to ("title: 処理を終了しますします") as text
	set strResponse to doWriteLogFile(strLogText, argLogFilePathURL)
	if strResponse is false then
		return "更新失敗"
	end if
	delay 1
	set strLogText to ("quit:") as text
	set strResponse to doWriteLogFile(strLogText, argLogFilePathURL)
	if strResponse is false then
		return "更新失敗"
	end if
	doTerminateTask(argAppNSTask)
end doQuitTask

##########################
#タスクの強制終了
to doTerminateTask(argAppNSTask)
	#Ctrl+Cを３回送る
	repeat 3 times
		argAppNSTask's interrupt()
		delay 0.2
	end repeat
	#ストールしていなければここで終わるが
	#念の為強制終了もかける
	argAppNSTask's terminate()
	return doExecAlert("強制終了しました")
end doTerminateTask
