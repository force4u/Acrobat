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
use scripting additions


try
	do shell script "/usr/bin/xcode-select --install"
end try

log "モジュールインストールの確認中"
#######################################################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3  -m pip install --user pip" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中"
#######################################################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3  -m pip install --upgrade --user pip" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　pip ok"


#######################################################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3  -m pip install --user reportlab" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中"
#######################################################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3  -m pip install --upgrade --user reportlab" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　pip ok"







#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install --user pypdf" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　pypdf ok"
#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install  --upgrade --user pypdf" in objWindowID
	delay 3
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　pypdf ok"





#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install --user PyPDF4" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　PyPDF4 ok"

#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install  --upgrade --user PyPDF4" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　PyPDF4 ok"
#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install --user PyPDF3" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　PyPDF3 ok"

#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install  --upgrade --user PyPDF3" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　PyPDF3 ok"

#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install --user PyPDF2" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　PyPDF2 ok"

#########################
tell application "Terminal"
	launch
	activate
	set objWindowID to (do script "\n\n")
	delay 1
	do script "python3 -m pip install  --upgrade --user PyPDF2" in objWindowID
	delay 3
	
	do script "\n\n" in objWindowID
	do script "exit" in objWindowID
	
	
	set theWid to get the id of window 1
	
	delay 1
	close front window saving no
	
end tell
log "モジュールインストールの確認中　PyPDF2 ok"




