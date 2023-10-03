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

property refMe : a reference to current application

set appFileManager to refMe's NSFileManager's defaultManager()


set strBundleID to "com.adobe.Reader"

set ocidResultsArray to refMe's NSRunningApplication's runningApplicationsWithBundleIdentifier:(strBundleID)
set numCntArray to ocidResultsArray count
if numCntArray ≠ 0 then
	set ocidRunApp to ocidResultsArray's objectAtIndex:0
	set boolHide to ocidRunApp's isHidden()
	log boolHide
	if boolHide is false then
		set boolDone to ocidRunApp's hide()
	end if
	set boolActive to ocidRunApp's isActive()
	log boolActive
	if boolActive is true then
		set appNSWorkspace to refMe's NSWorkspace's sharedWorkspace()
		set ocidAppBundlePathURL to appNSWorkspace's URLForApplicationWithBundleIdentifier:(strBundleID)
		set ocidOpenConfiguration to refMe's NSWorkspaceOpenConfiguration's configuration()
		ocidOpenConfiguration's setHides:(refMe's NSNumber's numberWithBool:true)
		ocidOpenConfiguration's setActivates:(refMe's NSNumber's numberWithBool:false)
		appNSWorkspace's openApplicationAtURL:ocidAppBundlePathURL configuration:(ocidOpenConfiguration) completionHandler:(missing value)
	end if
	
else if numCntArray = 0 then
	return "アプリケーションが未起動です"
end if
