#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application


##########################################
###アプリケーションの終了
set listBundleID to {"com.adobe.Acrobat.Pro", "com.adobe.Reader"} as list
repeat with itemList in listBundleID
	tell application id itemList to quit
	delay 1
end repeat

##########################################
###本処理
set listPlistFileName to {"com.adobe.Acrobat.Pro.plist", "com.adobe.Reader.plist"} as list
###Plistへのパス
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
###ReaderとPro両方処理する
repeat with itemPlistFileName in listPlistFileName
	log "Start:" & itemPlistFileName
	##########################################
	###【１】PLISTのパス
	set strSubPath to ("Preferences/" & itemPlistFileName) as text
	set ocidPlistFilePathURL to (ocidLibraryDirPathURL's URLByAppendingPathComponent:(strSubPath) isDirectory:(false))
	##########################################
	### 【２】PLISTを可変レコードとして読み込み
	set ocidPlistDict to (refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL))
	##########################################
	### 【３】処理
	set ocidDCDict to (ocidPlistDict's objectForKey:("DC"))
	##############
	set ocidGeneralDict to (ocidDCDict's objectForKey:("General"))
	if ocidGeneralDict = (missing value) then
		set ocidNilDict to (refMe's NSMutableDictionary's alloc()'s initWithCapacity:0)
		(ocidDCDict's setObject:(ocidNilDict) forKey:"General")
		set ocidGeneralDict to (ocidDCDict's objectForKey:("General"))
	end if
	#
	set ocidPrintAsImageArray to (ocidGeneralDict's objectForKey:("PrintAsImage"))
	if ocidPrintAsImageArray = (missing value) then
		set ocidNilArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:(0))
		(ocidGeneralDict's setObject:(ocidNilArray) forKey:"PrintAsImage")
		set ocidPrintAsImageArray to (ocidGeneralDict's objectForKey:("PrintAsImage"))
	end if
	set listSetValue to {(0 as integer), (false as boolean)} as list
	(ocidPrintAsImageArray's setArray:(listSetValue))
	##############
	set ocidAVGeneralDict to (ocidDCDict's objectForKey:("AVGeneral"))
	if ocidAVGeneralDict = (missing value) then
		set ocidNilDict to (refMe's NSMutableDictionary's alloc()'s initWithCapacity:0)
		(ocidDCDict's setObject:(ocidNilDict) forKey:"General")
		set ocidAVGeneralDict to (ocidDCDict's objectForKey:("General"))
	end if
	#
	set ocidAVPrintAsImageArray to (ocidAVGeneralDict's objectForKey:("PrintAsImage"))
	if ocidAVPrintAsImageArray = (missing value) then
		set ocidNilArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:(0))
		(ocidAVGeneralDict's setObject:(ocidNilArray) forKey:"PrintAsImage")
		set ocidAVPrintAsImageArray to (ocidAVGeneralDict's objectForKey:("PrintAsImage"))
	end if
	set listSetValue to {(0 as integer), (false as boolean)} as list
	(ocidAVPrintAsImageArray's setArray:(listSetValue))
	##############
	set ocidConversionToPDFDict to (ocidDCDict's objectForKey:("ConversionToPDF"))
	if ocidConversionToPDFDict = (missing value) then
		set ocidNilDict to (refMe's NSMutableDictionary's alloc()'s initWithCapacity:0)
		(ocidDCDict's setObject:(ocidNilDict) forKey:"ConversionToPDF")
		set ocidConversionToPDFDict to (ocidDCDict's objectForKey:("ConversionToPDF"))
	end if
	set ocidSettingsArray to (ocidConversionToPDFDict's objectForKey:("Settings"))
	
	if ocidSettingsArray = (missing value) then
		set ocidNilArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:(0))
		(ocidConversionToPDFDict's setObject:(ocidNilArray) forKey:"Settings")
		set ocidSettingsArray to (ocidConversionToPDFDict's objectForKey:("Settings"))
	end if
	
	set numCntArray to (count of ocidSettingsArray) as integer
	if numCntArray = 2 then
		(ocidSettingsArray's replaceObjectAtIndex:(0) withObject:(8 as integer))
		set ocidItem1Dict to (ocidSettingsArray's objectAtIndex:(1))
		set ocidPrintAsImageArray to (ocidItem1Dict's objectForKey:("PrintAsImage"))
		set listSetValue to {(0 as integer), (false as boolean)} as list
		(ocidPrintAsImageArray's setArray:(listSetValue))
		
	else if numCntArray = 0 then
		(ocidSettingsArray's insertObject:(8) atIndex:(0))
		set ocidNilDict to (refMe's NSMutableDictionary's alloc()'s initWithCapacity:0)
		set ocidNilArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:(0))
		set listSetValue to {(0 as integer), (false as boolean)} as list
		(ocidNilArray's setArray:(listSetValue))
		(ocidNilDict's setObject:(ocidNilArray) forKey:"PrintAsImage")
		(ocidSettingsArray's insertObject:(ocidNilDict) atIndex:(1))
	end if
	##############
	if itemPlistFileName is ("com.adobe.Reader.plist") then
		set ocidAVConversionToPDFDict to (ocidDCDict's objectForKey:("AVConversionToPDF"))
		if ocidAVConversionToPDFDict = (missing value) then
			set ocidNilDict to (refMe's NSMutableDictionary's alloc()'s initWithCapacity:0)
			(ocidAVConversionToPDFDict's setObject:(ocidNilDict) forKey:"ConversionToPDF")
			set ocidAVConversionToPDFDict to (ocidAVConversionToPDFDict's objectForKey:("ConversionToPDF"))
		end if
		set ocidAVSettingsArray to (ocidAVConversionToPDFDict's objectForKey:("Settings"))
		if ocidAVSettingsArray = (missing value) then
			set ocidNilArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:(0))
			(ocidAVConversionToPDFDict's setObject:(ocidNilArray) forKey:"Settings")
			set ocidAVSettingsArray to (ocidAVConversionToPDFDict's objectForKey:("Settings"))
		end if
		(ocidAVSettingsArray's insertObject:(8 as integer) atIndex:(0))
		set ocidAVItemsDict to (ocidAVSettingsArray's objectAtIndex:(1))
		if ocidAVItemsDict = (missing value) then
			set ocidNilDict to (refMe's NSMutableDictionary's alloc()'s initWithCapacity:0)
			set ocidNilArray to (refMe's NSMutableArray's alloc()'s initWithCapacity:(0))
			set listSetValue to {(0 as integer), (false as boolean)} as list
			(ocidNilArray's setArray:(listSetValue))
			(ocidNilDict's setObject:(ocidNilArray) forKey:"PrintAsImage")
			(ocidAVSettingsArray's insertObject:(ocidNilDict) atIndex:(1))
		else
			set ocidIAVtem1Array to (ocidAVItemsDict's objdectForKey:("PrintAsImage"))
			set listSetValue to {(0 as integer), (false as boolean)} as list
			(ocidIAVtem1Array's setArray:(listSetValue))
		end if
	end if
	##########################################
	####【４】保存 ここは上書き
	set listDone to (ocidPlistDict's writeToURL:(ocidPlistFilePathURL) |error|:(reference))
	if (item 1 of listDone) = true then
		log "正常終了"
	else
		return "保存に失敗しました"
	end if
end repeat



