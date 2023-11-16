#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
(*
前提
Adobe Acrobat　Acrobat Reader
アプリケーションを終了させてから
１０秒程度経過してから
実行してください

修正
DC.AVGeneral.IPMEnableAV2AcrobatNewUser
DC.AVGeneral.IPMEnableAV2ReaderNewUser
で
キーが別なのを修正
*)
#com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
use AppleScript version "2.8"
use framework "Foundation"
use framework "AppKit"
use scripting additions
property refMe : a reference to current application

###BOOL値比較用
set ocidTrue to (refMe's NSNumber's numberWithBool:true)
set ocidFalse to (refMe's NSNumber's numberWithBool:false)


##パス
set appFileManager to refMe's NSFileManager's defaultManager()
set ocidURLsArray to (appFileManager's URLsForDirectory:(refMe's NSLibraryDirectory) inDomains:(refMe's NSUserDomainMask))
set ocidLibraryDirPathURL to ocidURLsArray's firstObject()
##PLISTへのパス　まずは　製品版
set ocidPlistFilePathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences/com.adobe.Acrobat.Pro.plist")
log "まずは　製品版の設定変更"
##### ◆IPMEnableAV2AcrobatNewUser
###まずは現在の値 (Acrobat)
set ocidPlistDict to refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL)
set ocidValueArray to (ocidPlistDict's valueForKeyPath:"DC.AVGeneral.IPMEnableAV2AcrobatNewUser")
if ocidValueArray = (missing value) then
	set listValue to {0, false} as list
	set ocidDcDict to ocidPlistDict's objectForKey:("DC")
	set ocidGeneralDict to ocidDcDict's objectForKey:("AVGeneral")
	ocidGeneralDict's setValue:(listValue) forKey:("IPMEnableAV2AcrobatNewUser")
else
	set ocidValue to ocidValueArray's objectAtIndex:(1)
	if ocidValue = ocidTrue then
		log "IPMEnableAV2AcrobatNewUser：現在の設定はYES TRUEです FALSEに変更します"
		###値変更
		ocidValueArray's replaceObjectAtIndex:(1) withObject:(ocidFalse)
	else if ocidValue = ocidFalse then
		log "IPMEnableAV2AcrobatNewUser：現在の設定はNO FALSEです"
	end if
end if
##### ◆EnableAV2
###まずは現在の値 (Acrobat)
set ocidValueArray to (ocidPlistDict's valueForKeyPath:"DC.AVGeneral.EnableAV2")
if ocidValueArray = (missing value) then
	set listValue to {0, false} as list
	set ocidDcDict to ocidPlistDict's objectForKey:("DC")
	set ocidGeneralDict to ocidDcDict's objectForKey:("AVGeneral")
	ocidGeneralDict's setValue:(listValue) forKey:("EnableAV2")
else
	set ocidValue to ocidValueArray's objectAtIndex:(1)
	if ocidValue = ocidTrue then
		log "EnableAV2：現在の設定はYES TRUEです FALSEに変更します"
		###値変更
		ocidValueArray's replaceObjectAtIndex:(1) withObject:(ocidFalse)
	else if ocidValue = ocidFalse then
		log "EnableAV2：現在の設定はNO FALSEです"
	end if
end if
##### ◆EnableAV2Enterprise
###まずは現在の値 (Acrobat)
set ocidValue to ocidPlistDict's valueForKeyPath:("DC.FeatureLockDown.EnableAV2Enterprise")
if ocidValue = (missing value) then
	set ocidDcDict to ocidPlistDict's objectForKey:("DC")
	set ocidFeatureLockDownDict to ocidPlistDict's objectForKey:("FeatureLockDown")
	ocidFeatureLockDownDict's setValue:(ocidFalse) forKey:("EnableAV2Enterprise")
else
	if ocidValue = ocidTrue then
		log "EnableAV2Enterprise：現在の設定はYES TRUEです FALSEに変更します"
		###値変更
		ocidPlistDict's setValue:(ocidFalse) forKeyPath:("DC.FeatureLockDown.EnableAV2Enterprise")
	else if ocidValue = ocidFalse then
		log "EnableAV2Enterprise：現在の設定はNO FALSEです"
	end if
end if
##保存
set boolDone to ocidPlistDict's writeToURL:(ocidPlistFilePathURL) atomically:true


###リーダ版の設定パス
set ocidPlistFilePathURL to ocidLibraryDirPathURL's URLByAppendingPathComponent:("Preferences/com.adobe.Reader.plist")
log "続いて　リーダー無償版の設定変更"

##### ◆IPMEnableAV2AcrobatNewUser
###まずは現在の値 (Reader)
set ocidPlistDict to refMe's NSMutableDictionary's alloc()'s initWithContentsOfURL:(ocidPlistFilePathURL)
set ocidValueArray to (ocidPlistDict's valueForKeyPath:"DC.AVGeneral.IPMEnableAV2ReaderNewUser")
if ocidValueArray = (missing value) then
	set listValue to {0, false} as list
	set ocidDcDict to ocidPlistDict's objectForKey:("DC")
	set ocidGeneralDict to ocidDcDict's objectForKey:("AVGeneral")
	ocidGeneralDict's setValue:(listValue) forKey:("IPMEnableAV2AcrobatNewUser")
else
	set ocidValue to ocidValueArray's objectAtIndex:(1)
	if ocidValue = ocidTrue then
		log "IPMEnableAV2AcrobatNewUser：現在の設定はYES TRUEです FALSEに変更します"
		###値変更
		ocidValueArray's replaceObjectAtIndex:(1) withObject:(ocidFalse)
	else if ocidValue = ocidFalse then
		log "IPMEnableAV2AcrobatNewUser：現在の設定はNO FALSEです"
	end if
end if
##### ◆EnableAV2
###まずは現在の値 (Reader)
set ocidValueArray to (ocidPlistDict's valueForKeyPath:"DC.AVGeneral.EnableAV2")
if ocidValueArray = (missing value) then
	set listValue to {0, false} as list
	set ocidDcDict to ocidPlistDict's objectForKey:("DC")
	set ocidGeneralDict to ocidDcDict's objectForKey:("AVGeneral")
	ocidGeneralDict's setValue:(listValue) forKey:("EnableAV2")
else
	set ocidValue to ocidValueArray's objectAtIndex:(1)
	if ocidValue = ocidTrue then
		log "EnableAV2：現在の設定はYES TRUEです FALSEに変更します"
		###値変更
		ocidValueArray's replaceObjectAtIndex:(1) withObject:(ocidFalse)
	else if ocidValue = ocidFalse then
		log "EnableAV2：現在の設定はNO FALSEです"
	end if
end if
##### ◆EnableAV2Enterprise
###まずは現在の値 (Reader)
set ocidValue to ocidPlistDict's valueForKeyPath:("DC.FeatureLockDown.EnableAV2Enterprise")
if ocidValue = (missing value) then
	set ocidDcDict to ocidPlistDict's objectForKey:("DC")
	set ocidFeatureLockDownDict to ocidPlistDict's objectForKey:("FeatureLockDown")
	ocidFeatureLockDownDict's setValue:(ocidFalse) forKey:("EnableAV2Enterprise")
else
	if ocidValue = ocidTrue then
		log "EnableAV2Enterprise：現在の設定はYES TRUEです FALSEに変更します"
		###値変更
		ocidPlistDict's setValue:(ocidFalse) forKeyPath:("DC.FeatureLockDown.EnableAV2Enterprise")
	else if ocidValue = ocidFalse then
		log "EnableAV2Enterprise：現在の設定はNO FALSEです"
	end if
end if
##保存
set boolDone to ocidPlistDict's writeToURL:(ocidPlistFilePathURL) atomically:true