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
		execute menu item "GeneralInfo" of menu "File" of application "Adobe Acrobat Reader DC"
	on error
		do script ("app.execMenuItem(\"GeneralInfo\");")
	end try
end tell

return
{menu item "Open" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "RestoreSession" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "ReopenTab" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Annots:SPOpenURL" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "OpenRecent" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "endOpenGroup" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "CreatePDFOnlineReader" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "CreatePDFSubmenu" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "CombinePDFRdrMenuItem" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "InsertPagesRdrMenuItem" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Save" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "SaveAs" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "SaveAsSubmenu" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "RdrConvertToWordOrExcelMenuItem" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "ADBE:SaveAsAccText" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "ProtectUsingPwdMenuItem" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "endSaveGroup" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "CompressFile" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "PasswordProtect" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "FileMenuRequestSignatures" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Share" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "ShareMenuItem" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "ExtractFilesFromPackage" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Annots:SharePointServer" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Print" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "endPrintGroup" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "GeneralInfo" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "endDocInfoGroup" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Revert" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Close" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Close" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "CloseAll" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "endFormDataGroup" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "GeneralInfo" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "endDocInfoGroup" of menu "ファイル " of application "Adobe Acrobat Reader DC", menu item "Print" of menu "ファイル " of application "Adobe Acrobat Reader DC"}