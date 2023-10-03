#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#メニューバーの● ■ ▶︎ の右三角をクリックして実行してください↑
#
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions

property refMe : a reference to current application

set listAppName to {"AcroCEF", "AcroCEF.app", "CCLibrary", "ACCFinderSync", "Creative Cloud.app", "AdobeIPCBroker.app", "Adobe Crash Reporter.app", "Adobe Desktop Service", "CCLibrary.app", "Core Sync.app", "CCXProcess.app", "Adobe Crash Handler", "Adobe Desktop Service", "AdobeResourceSynchronizer", "Acrobat", "AdobeReader", "RdrCEF"} as list


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
