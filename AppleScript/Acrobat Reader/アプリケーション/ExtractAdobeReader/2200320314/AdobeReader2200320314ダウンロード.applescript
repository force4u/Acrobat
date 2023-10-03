#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
# com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
##©•ªŠÂ‹«‚ªos12‚È‚Ì‚Å2.8‚É‚µ‚Ä‚¢‚é‚¾‚¯‚Å‚·
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use framework "UniformTypeIdentifiers"
use scripting additions
property refMe : a reference to current application

###æ‚èo‚·ƒo[ƒWƒ‡ƒ“‚ÌƒAƒbƒvƒf[ƒ^‚ÌURL
set strUTL to ("https://ardownload2.adobe.com/pub/adobe/reader/mac/AcrobatDC/2200320314/AcroRdrDCUpd2200320314_MUI.dmg") as text
set strDMGFileName to "AcroRdrDCUpd2200320314_MUI.dmg" as text
set strPKGFileName to ("AcroRdrDCUpd2200320314_MUI.pkg") as text

set appFileManager to refMe's NSFileManager's defaultManager()

########################################
###ƒ_ƒEƒ“ƒ[ƒhƒtƒ@ƒCƒ‹‚ğ•Û‘¶‚·‚é‹N“®‚Éíœ‚³‚ê‚é€–Ú
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidTempDirURL to appFileManager's temporaryDirectory()
set ocidUUID to refMe's NSUUID's alloc()'s init()
set ocidUUIDString to ocidUUID's UUIDString
set ocidSaveDirPathURL to ocidTempDirURL's URLByAppendingPathComponent:(ocidUUIDString) isDirectory:true
##
set ocidAttrDict to refMe's NSMutableDictionary's alloc()'s initWithCapacity:0
# 777-->511 755-->493 700-->448 766-->502 
ocidAttrDict's setValue:(511) forKey:(refMe's NSFilePosixPermissions)
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidSaveDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)

########################################
###ƒ_ƒEƒ“ƒ[ƒh
##•Û‘¶ƒpƒX
set ocidSaveDMGPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:(strDMGFileName) isDirectory:false
set strSaveDMGPathURL to (ocidSaveDMGPathURL's |path|()) as text
###ƒ_ƒEƒ“ƒ[ƒhURL
###ƒRƒ}ƒ“ƒhÀs
set strCommandText to ("/usr/bin/curl -L -o €"" & strSaveDMGPathURL & "€" €"" & strUTL & "€" --connect-timeout 20") as text
do shell script strCommandText

########################################
###DMGƒ}ƒEƒ“ƒg
###ƒ}ƒEƒ“ƒgƒ|ƒCƒ“ƒg
set ocidMountPointPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("MountPoint/DC/") isDirectory:true
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidMountPointPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
set strMountPointPathURL to (ocidMountPointPathURL's |path|()) as text
###ƒRƒ}ƒ“ƒhÀs
set strCommandText to ("/usr/bin/hdiutil attach  €"" & strSaveDMGPathURL & "€" -noverify -nobrowse -noautoopen -mountpoint €"" & strMountPointPathURL & "€"") as text
do shell script strCommandText

########################################
###ƒ}ƒEƒ“ƒg‚³‚ê‚½ƒ{ƒŠƒ…[ƒ€‚©‚çPKG‚ğ‰ğ“€
###PKGURL
set ocidPkgPathURL to ocidMountPointPathURL's URLByAppendingPathComponent:(strPKGFileName) isDirectory:false
set strPkgPath to (ocidPkgPathURL's |path|()) as text
###pkg‚Ì“WŠJæ
set ocidExpandDirPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("Expand") isDirectory:true
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidExpandDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
set ocidExpandPKGPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("Expand/Expand.pkg") isDirectory:true
set strExpandPKGPath to (ocidExpandPKGPathURL's |path|()) as text
####ƒRƒ}ƒ“ƒhÀs
set strComandText to "/usr/sbin/pkgutil  --expand  €"" & strPkgPath & "€" €"" & strExpandPKGPath & "€"" as text
do shell script strComandText

####‰ğ“€‚ªI‚í‚Á‚½‚çDMG‚Ìƒ}ƒEƒ“ƒg‰ğœ
set strComandText to "/usr/bin/hdiutil detach €"" & strMountPointPathURL & "€" -force" as text
do shell script strComandText


########################################
###Payload‚ğ‰ğ“€‚µ‚È‚ª‚ç•¡»
###Payload‚ÌƒpƒX
set ocidPayloadPathURL to ocidExpandPKGPathURL's URLByAppendingPathComponent:("payload.pkg/Payload") isDirectory:true
set strPayloadPath to (ocidPayloadPathURL's |path|()) as text
###‰ğ“€æ
set ocidExtractDirPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("Extract") isDirectory:true
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidExtractDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
set strExtractDirPath to (ocidExtractDirPathURL's |path|()) as text

set strComandText to ("/usr/bin/ditto  -xz   €"" & strPayloadPath & "€"   €"" & strExtractDirPath & "€"") as text
do shell script strComandText

########################################
###7zƒtƒ@ƒCƒ‹‚ğ‰ğ“€
###ƒRƒ}ƒ“ƒh‚Ö‚ÌƒpƒX
set ocid7zzPathURL to ocidExpandPKGPathURL's URLByAppendingPathComponent:("acropython3.pkg/Scripts/Tools/7za") isDirectory:true
set str7zzPath to (ocid7zzPathURL's |path|()) as text
###‰ğ“€‚·‚éƒtƒ@ƒCƒ‹
set ocid7zArcPathURL to ocidExtractDirPathURL's URLByAppendingPathComponent:("MUI.7z") isDirectory:true
set str7zArcPat to (ocid7zArcPathURL's |path|()) as text
delay 2
set strComandText to ("€"" & str7zzPath & "€" x €"" & str7zArcPat & "€" -o€"" & strExtractDirPath & "€" -y -slt") as text
do shell script strComandText

########################################
###RdrServicesUpdater‚ğsudo‚ÅÀs
set ocidPayloadPathURL to ocidExpandPKGPathURL's URLByAppendingPathComponent:("RdrServicesUpdater.pkg/Payload") isDirectory:true
set strPayloadPath to (ocidPayloadPathURL's |path|()) as text
###‰ğ“€æ
set ocidRdrServicesUpdaterExtractDirPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("RdrServicesUpdater") isDirectory:true
set listBoolMakeDir to appFileManager's createDirectoryAtURL:(ocidRdrServicesUpdaterExtractDirPathURL) withIntermediateDirectories:true attributes:(ocidAttrDict) |error|:(reference)
set strServicesUpdaterExtractDirPath to (ocidRdrServicesUpdaterExtractDirPathURL's |path|()) as text

set strComandText to ("/usr/bin/ditto  -xz   €"" & strPayloadPath & "€"   €"" & strServicesUpdaterExtractDirPath & "€"") as text
do shell script strComandText

set ocidServicesUpdaterPathURL to ocidSaveDirPathURL's URLByAppendingPathComponent:("RdrServicesUpdater/RdrServicesUpdater.app/Contents/MacOS/RdrServicesUpdater") isDirectory:true
set strServicesUpdaterPath to (ocidServicesUpdaterPathURL's |path|()) as text


set strComandText to ("/usr/bin/sudo €"" & strServicesUpdaterPath & "€"") as text

do shell script strComandText with administrator privileges

########################################
###‰ğ“€‚³‚ê‚½ƒAƒvƒŠƒP[ƒVƒ‡ƒ“‚ÌˆÚ“®
set ocidAppPathURL to ocidExtractDirPathURL's URLByAppendingPathComponent:("MUI/Application/Adobe Acrobat Reader DC.app") isDirectory:true
###ƒ_ƒEƒ“ƒ[ƒhƒfƒBƒŒƒNƒgƒŠ‚ÉˆÚ“®
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSDownloadsDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidDownloadsDirPathURL to ocidURLsArray's firstObject()
set ocidMoveAppPathURL to ocidDownloadsDirPathURL's URLByAppendingPathComponent:("Adobe Acrobat Reader DC.app") isDirectory:true
####
set lisrDone to appFileManager's moveItemAtURL:(ocidAppPathURL) toURL:(ocidMoveAppPathURL) |error|:(reference)

##•\¦
set appSharedWorkspace to refMe's NSWorkspace's sharedWorkspace()
set boolDone to appSharedWorkspace's selectFile:(ocidMoveAppPathURL's |path|()) inFileViewerRootedAtPath:(ocidDownloadsDirPathURL's |path|())
###Œ‹‰Ê
if boolDone is false then
	return "ƒGƒ‰[‚µ‚Ü‚µ‚½"
end if

