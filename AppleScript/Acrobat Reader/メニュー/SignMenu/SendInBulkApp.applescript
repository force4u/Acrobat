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
use scripting additions


set strBundleID to "com.adobe.Reader"

tell application id "com.adobe.Reader"
	tell front window to activate
	try
		execute menu item "SendInBulkApp" of menu "SignMenu" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"SendInBulkApp\");")
	end try
end tell

return
{menu item "FillSignMenu" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "SignMenuRequestSignatures" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "CreateWebFormApp" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "SendInBulkApp" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "AddSignBrandingApp" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "CollectPaymentsApp" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "CreateAgreementMenu" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "" of menu "署名" of application "Adobe Acrobat Reader DC", menu item "ManageAgreementsMenu" of menu "署名" of application "Adobe Acrobat Reader DC"}