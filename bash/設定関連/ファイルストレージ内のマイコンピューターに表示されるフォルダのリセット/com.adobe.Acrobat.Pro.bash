#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
# Acrobat SCA版のAcrobat Reader 共通
#################################################
#STAT
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"

#【前提条件】まずはAcrobatを終了させてください
#【１】現在の設定の値を確認する
#旧UI
/usr/libexec/PlistBuddy -c "Print:DC:General:RecentFolders:0" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"
#-->たぶん８が戻ります

#AV2新UI
/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:RecentFolders:0" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"
#-->たぶん８が戻ります



#【２】設定を変更する
#旧UI
/usr/libexec/PlistBuddy -c "Set:DC:General:RecentFolders:0  0" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"

#AV2新UI
/usr/libexec/PlistBuddy -c "Set:DC:AVGeneral:RecentFolders:0  0" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"

#【３】変更内容を保存する
#旧UI　AV2新UI　共通１回実施でOK
/usr/libexec/PlistBuddy -c "Save" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"



#【４】変更内容を確認す
#旧UI
/usr/libexec/PlistBuddy -c "Print:DC:General:RecentFolders:0" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"

#AV2新UI
/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:RecentFolders:0" "/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"

#-->０が戻ればOK　アクロバットを起動してみてください






exit 0
