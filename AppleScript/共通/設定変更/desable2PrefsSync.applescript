#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
(* 注意！
Adobeの関連プロセスを片っ端から終了させます
作業中の場合は一旦全てデータを保存してから実行させてください
*)
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "UniformTypeIdentifiers"
use scripting additions
property refMe : a reference to current application
##########################################
###【設定項目】停止= true？　又は再開= false？
set boolStopSync to true as boolean

##########################################
###まずはAdobe関連のプロセスを終了させます
doKill2BundleID()
##########################################
###本処理
set listPlistFileName to {"com.adobe.Reader.plist", "com.adobe.Acrobat.Pro.plist"} as list
###Libraryへのパス
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
###ReaderとPro両方処理する
repeat with itemPlistFileName in listPlistFileName
	##########################################
	###【１】PLISTのパス
	set strSubPath to ("Preferences/" & itemPlistFileName) as text
	set ocidPlistFilePathURL to (ocidLibraryDirPathURL's URLByAppendingPathComponent:(strSubPath))
	##########################################
	### 【２】PLISTを可変レコードとして読み込み
	set ocidPlistDict to (refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL))
	##########################################
	### 【３】処理
	set ocidDCDict to (ocidPlistDict's objectForKey:("DC"))
	set ocidPrefsSyncDict to (ocidDCDict's objectForKey:("PrefsSync"))
	#
	if boolStopSync is true then
		set numNumValue to 0 as integer
		set boolBoolValue to false as boolean
	else if boolStopSync is false then
		set numNumValue to 1 as integer
		set boolBoolValue to true as boolean
	end if
	#
	set ocidPrefsSyncDoneArray to (ocidPrefsSyncDict's objectForKey:("PrefsSyncDone"))
	set ocidSetValue to (refMe's NSNumber's numberWithInteger:(numNumValue))
	(ocidPrefsSyncDoneArray's replaceObjectAtIndex:(0) withObject:(ocidSetValue))
	set ocidSetValue to (refMe's NSNumber's numberWithBool:(boolBoolValue))
	(ocidPrefsSyncDoneArray's replaceObjectAtIndex:(1) withObject:(ocidSetValue))
	#
	set ocidPrefsSyncUserEnabledArray to (ocidPrefsSyncDict's objectForKey:("PrefsSyncUserEnabled"))
	set ocidSetValue to (refMe's NSNumber's numberWithInteger:(numNumValue))
	(ocidPrefsSyncUserEnabledArray's replaceObjectAtIndex:(0) withObject:(ocidSetValue))
	set ocidSetValue to (refMe's NSNumber's numberWithBool:(boolBoolValue))
	(ocidPrefsSyncUserEnabledArray's replaceObjectAtIndex:(1) withObject:(ocidSetValue))
	#	
	##########################################
	####【４】保存 ここは上書き
	set boolDone to (ocidPlistDict's writeToURL:(ocidPlistFilePathURL) atomically:true)
	log boolDone
	if boolDone = true then
		log "正常終了"
	else
		return "保存に失敗しました"
	end if
end repeat

##########################################
#### プロセス終了

to doKill2BundleID()
	set listBundleID to {"com.apple.appkit.xpc.openAndSavePanelService", "com.adobe.distiller", "com.adobe.Reader", "com.adobe.Acrobat.Pro", "com.adobe.AdobeAcroCEFHelper", "com.adobe.AdobeAcroCEFHelperRenderer", "com.adobe.AdobeAcroCEFHelperGPU", "com.adobe.AdobeResourceSynchronizer", "com.adobe.Acrobat.Uninstaller", "com.adobe.headlights.LogTransport2App", "com.adobe.acrobat.assert", "com.adobe.AdobeAcroCEF", "com.adobe.acc.AdobeCreativeCloud", "com.adobe.ccd.helper", "com.adobe.acc.HEXHelper", "com.adobe.acc.HEXHelper.Renderer", "com.adobe.acc.HEXHelper.GPU", "com.adobe.CCXProcess", "com.adobe.accmac", "com.adobe.accmac.ACCFinderSync", "com.adobe.adobe_licutil", "com.adobe.ngl.p7helper", "com.adobe.AcroLicApp", "com.adobe.acc.AdobeDesktopService", "com.adobe.AdobeApplicationUpdater", "com.adobe.HDInstall", "com.adobe.AdobeIPCBroker", "com.adobe.ngl.p7helper", "com.adobe.ARMDCHelper", "com.adobe.ARMDC", "com.adobe.CCLibrary", "com.adobe.Acrobat.NativeMessagingHost", "com.adobe.Automator.Save-as-Adobe-PDF", "com.adobe.AdobeRdrCEFHelperGPU", "com.adobe.AdobeRdrCEFHelperRenderer", "com.adobe.AdobeRdrCEFHelper", "com.adobe.AdobeCRDaemon", "com.adobe.crashreporter", "com.adobe.LogTransport.LogTransport"} as list
	repeat with itemBundleID in listBundleID
		set strBundleID to itemBundleID as text
		try
			set ocidResultsArray to (refMe's NSRunningApplication's runningApplicationsWithBundleIdentifier:(strBundleID))
			set numCntArray to ocidResultsArray count
			set ocidRunApp to (ocidResultsArray's objectAtIndex:0)
			###通常終了
			set boolDone to ocidRunApp's terminate()
			####強制終了
			set boolDone to ocidRunApp's forceTerminate()
		end try
	end repeat
	
	
	
	set listAppName to {"AcroCEF", "AcroCEF.app", "CCLibrary", "ACCFinderSync", "Creative Cloud.app", "AdobeIPCBroker.app", "Adobe Crash Reporter.app", "Adobe Desktop Service", "CCLibrary.app", "Core Sync.app", "CCXProcess.app", "Adobe Crash Handler", "Adobe Desktop Service", "AdobeResourceSynchronizer", "Acrobat", "AdobeReader", "RdrCEF", "Adobe Crash Processor", "Adobe Crash Processor.app", "Adobe Crash Reporter.app", "LogTransport.app", "Adobe Crash Reporter"} as list
	
	
	repeat with itemAppName in listAppName
		set strAppName to itemAppName as text
		set strCommandText to "/bin/ps  -alxe | grep \"" & strAppName & "\" | grep -v \"grep\" | awk '{ print $2 }'" as text
		set strResponce to (do shell script strCommandText) as text
		log strResponce
		set AppleScript's text item delimiters to "\r"
		set listPID to every text item of strResponce
		set AppleScript's text item delimiters to ""
		
		if (count of listPID) = 0 then
			log "対象プロセス無し"
		else
			repeat with itemPID in listPID
				###プロセスを終了させる
				doQuitApp2PID(itemPID)
			end repeat
		end if
	end repeat
	##念押し
	try
		set strCommandText to "/usr/bin/killall -QUIT  'Adobe Desktop Service'" as text
		set strResponce to (do shell script strCommandText) as text
	on error
		try
			set strCommandText to "/usr/bin/killall -KILL  'Adobe Desktop Service'" as text
			set strResponce to (do shell script strCommandText) as text
		end try
	end try
	try
		set strCommandText to "/usr/bin/killall  -QUIT 'Creative Cloud'" as text
		set strResponce to (do shell script strCommandText) as text
	on error
		try
			set strCommandText to "/usr/bin/killall -KILL  'Creative Cloud'" as text
			set strResponce to (do shell script strCommandText) as text
		end try
	end try
	
	try
		set strCommandText to "/usr/bin/killall -QUIT 'ACCFinderSync'" as text
		set strResponce to (do shell script strCommandText) as text
	on error
		try
			set strCommandText to "/usr/bin/killall -KILL  'ACCFinderSync'" as text
			set strResponce to (do shell script strCommandText) as text
		end try
	end try
	
	
end doKill2BundleID

###################################
########アプリケーションを終了させる
###################################
to doQuitApp2PID(argPID)
	set strPID to argPID as text
	#### killallを使う場合
	set strCommandText to ("/bin/kill -15  " & strPID & "") as text
	set ocidCommandText to refMe's NSString's stringWithString:strCommandText
	set ocidTermTask to refMe's NSTask's alloc()'s init()
	ocidTermTask's setLaunchPath:"/bin/zsh"
	ocidTermTask's setArguments:({"-c", ocidCommandText})
	set listResults to ocidTermTask's launchAndReturnError:(reference)
	log listResults
	if item 1 of listResults is true then
		log "正常終了"
	else
		try
			set strCommandText to ("/bin/kill -9  " & strPID & "") as text
			set strResponse to (do shell script strCommandText) as text
		end try
	end if
end doQuitApp2PID
