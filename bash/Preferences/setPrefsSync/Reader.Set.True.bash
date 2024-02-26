#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
#################################################
###STAT
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"

STR_READER_PLIST_FILE_PATH="$HOME/Library/Preferences/com.adobe.Reader.plist"
/bin/echo "STR_READER_PLIST_FILE_PATH: $STR_READER_PLIST_FILE_PATH"

#################################################
/bin/echo "現在の設定は"
NUM_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncDone:0" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncDone:NUM_VALUE: $NUM_VALUE"
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncDone:1" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncDone:BOOL_VALUE: $BOOL_VALUE"

NUM_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncUserEnabled:0" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncUserEnabled:NUM_VALUE: $NUM_VALUE"
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncUserEnabled:1" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncUserEnabled:BOOL_VALUE: $BOOL_VALUE"
#################################################
/bin/echo "設定を変更する"

/usr/libexec/PlistBuddy -c "Set:DC:PrefsSync:PrefsSyncDone:0 1" "$STR_READER_PLIST_FILE_PATH"
/usr/libexec/PlistBuddy -c "Set:DC:PrefsSync:PrefsSyncDone:1 true" "$STR_READER_PLIST_FILE_PATH"
/usr/libexec/PlistBuddy -c "Set:DC:PrefsSync:PrefsSyncUserEnabled:0 1" "$STR_READER_PLIST_FILE_PATH"
/usr/libexec/PlistBuddy -c "Set:DC:PrefsSync:PrefsSyncUserEnabled:1 true" "$STR_READER_PLIST_FILE_PATH"
#
/usr/libexec/PlistBuddy -c "Save" "$STR_READER_PLIST_FILE_PATH"

#################################################
/bin/echo "変更された設定内容を確認する"
NUM_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncDone:0" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncDone:NUM_VALUE: $NUM_VALUE"
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncDone:1" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncDone:BOOL_VALUE: $BOOL_VALUE"

NUM_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncUserEnabled:0" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncUserEnabled:NUM_VALUE: $NUM_VALUE"
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:PrefsSync:PrefsSyncUserEnabled:1" "$STR_READER_PLIST_FILE_PATH")
/bin/echo "PrefsSyncUserEnabled:BOOL_VALUE: $BOOL_VALUE"
exit 0
