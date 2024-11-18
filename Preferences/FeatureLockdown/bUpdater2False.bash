#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
#
#################################################
#パス　DC
STR_PLIST_FILE_PATH="/Library/Preferences/com.adobe.Acrobat.Pro.plist"
#ファイルが無い想定でまずはタッチ
/usr/bin/sudo /usr/bin/touch "$STR_PLIST_FILE_PATH"

if ! /usr/libexec/PlistBuddy -c "Print:DC:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo /usr/bin/defaults write "$STR_PLIST_FILE_PATH" DC -dict
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"
#####
if ! /usr/libexec/PlistBuddy -c "Print:2020:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo /usr/bin/defaults write "$STR_PLIST_FILE_PATH" 2020 -dict
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"

##### Classic
if ! /usr/libexec/PlistBuddy -c "Print:Classic:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo /usr/bin/defaults write "$STR_PLIST_FILE_PATH" Classic -dict
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"



#################################################
#パス　READER
STR_PLIST_FILE_PATH="/Library/Preferences/com.adobe.Reader.plist"
#ファイルが無い想定でまずはタッチ
/usr/bin/sudo /usr/bin/touch "$STR_PLIST_FILE_PATH"

if ! /usr/libexec/PlistBuddy -c "Print:DC:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo /usr/bin/defaults write "$STR_PLIST_FILE_PATH" DC -dict
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"
#####
if ! /usr/libexec/PlistBuddy -c "Print:2020:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo /usr/bin/defaults write "$STR_PLIST_FILE_PATH" 2020 -dict
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"
##### Classic
if ! /usr/libexec/PlistBuddy -c "Print:Classic:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo /usr/bin/defaults write "$STR_PLIST_FILE_PATH" Classic -dict
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"

#################################################
##ここからユーザー設定
###STAT
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"
#################################################
#パス　DC
STR_PLIST_FILE_PATH="/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"
#ファイルが無い想定でまずはタッチ
/usr/bin/sudo -u "$STAT_USR"  /usr/bin/touch "$STR_PLIST_FILE_PATH"

if ! /usr/libexec/PlistBuddy -c "Print:DC:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo -u "$STAT_USR"  /usr/bin/defaults write "$STR_PLIST_FILE_PATH" DC -dict
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"
#####
if ! /usr/libexec/PlistBuddy -c "Print:2020:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo -u "$STAT_USR"  /usr/bin/defaults write "$STR_PLIST_FILE_PATH" 2020 -dict
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"

##### Classic
if ! /usr/libexec/PlistBuddy -c "Print:Classic:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo -u "$STAT_USR"  /usr/bin/defaults write "$STR_PLIST_FILE_PATH" Classic -dict
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR" /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"



#################################################
#パス　READER
STR_PLIST_FILE_PATH="/Users/${STAT_USR}/Library/Preferences/com.adobe.Reader.plist"
#ファイルが無い想定でまずはタッチ
/usr/bin/sudo -u "$STAT_USR"  /usr/bin/touch "$STR_PLIST_FILE_PATH"

if ! /usr/libexec/PlistBuddy -c "Print:DC:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo -u "$STAT_USR"  /usr/bin/defaults write "$STR_PLIST_FILE_PATH" DC -dict
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:DC:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:DC:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"
#####
if ! /usr/libexec/PlistBuddy -c "Print:2020:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo -u "$STAT_USR"  /usr/bin/defaults write "$STR_PLIST_FILE_PATH" 2020 -dict
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:2020:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:2020:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"
##### Classic
if ! /usr/libexec/PlistBuddy -c "Print:Classic:FeatureLockdown:cServices:bUpdater" "$STR_PLIST_FILE_PATH"
then
  /bin/echo "エラー： FeatureLockdown 設定値がありません"
  /usr/bin/sudo -u "$STAT_USR"  /usr/bin/defaults write "$STR_PLIST_FILE_PATH" Classic -dict
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown dict" "$STR_PLIST_FILE_PATH"
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:bUpdater bool false" "$STR_PLIST_FILE_PATH"
  #
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices dict" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Add:Classic:FeatureLockdown:cServices:bUpdater bool false" "$STR_PLIST_FILE_PATH"
fi
#  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:bUpdater  false" "$STR_PLIST_FILE_PATH"
  /usr/bin/sudo -u "$STAT_USR"  /usr/libexec/PlistBuddy -c "Set:Classic:FeatureLockdown:cServices:bUpdater  false" "$STR_PLIST_FILE_PATH"


exit 0
