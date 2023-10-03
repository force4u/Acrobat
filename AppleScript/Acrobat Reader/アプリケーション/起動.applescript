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

set strBundleID to "com.adobe.Reader"

#####NSWorkspace's
set appNSWorkspace to refMe's NSWorkspace's sharedWorkspace()
#####NSRUL
set ocidAppBundlePathURL to appNSWorkspace's URLForApplicationWithBundleIdentifier:(strBundleID)
#####Configuration
set ocidOpenConfiguration to refMe's NSWorkspaceOpenConfiguration's configuration()
ocidOpenConfiguration's setHides:(refMe's NSNumber's numberWithBool:false)
ocidOpenConfiguration's setRequiresUniversalLinks:(refMe's NSNumber's numberWithBool:false)
ocidOpenConfiguration's setActivates:(refMe's NSNumber's numberWithBool:true)
appNSWorkspace's openApplicationAtURL:ocidAppBundlePathURL configuration:(ocidOpenConfiguration) completionHandler:(missing value)

return