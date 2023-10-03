#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#	com.adobe.distiller
#	com.adobe.Acrobat.Pro
#	com.adobe.Reader
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions


tell application "Acrobat Distiller" to launch
tell application "Acrobat Distiller" to activate


(*
tell application id "com.adobe.distiller"
	activate
end tell

property refMe : a reference to current application
set appNSWorkspace to refMe's NSWorkspace's sharedWorkspace()
set strUTI to "com.adobe.distiller" as text
set ocidAppBundlePathURL to appNSWorkspace's URLForApplicationWithBundleIdentifier:strUTI
###オプション
set ocidOpenConfiguration to refMe's NSWorkspaceOpenConfiguration's configuration()
ocidOpenConfiguration's setHides:(refMe's NSNumber's numberWithBool:false)
ocidOpenConfiguration's setActivates:(refMe's NSNumber's numberWithBool:true)
###起動
appNSWorkspace's openApplicationAtURL:ocidAppBundlePathURL configuration:(ocidOpenConfiguration) completionHandler:(missing value)

*)