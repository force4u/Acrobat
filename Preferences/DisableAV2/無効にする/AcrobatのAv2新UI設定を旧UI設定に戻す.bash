#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
#AcrobatのAv2新UI設定を旧UI設定に戻します
#################################################
###基本
USER_WHOAMI=$(/usr/bin/whoami)
/bin/echo "実行ユーザー(whoami): $USER_WHOAMI"
###実行しているユーザー名
CONSOLE_USER=$(/bin/echo "show State:/Users/ConsoleUser" | /usr/sbin/scutil | /usr/bin/awk '/Name :/ { print $3 }')
/bin/echo "コンソールユーザー(scutil): $CONSOLE_USER"
###実行しているユーザー名
HOME_USER=$(/bin/echo "$HOME" | /usr/bin/awk -F'/' '{print $NF}')
/bin/echo "実行ユーザー(HOME): $HOME_USER"
###logname
LOGIN_NAME=$(/usr/bin/logname)
/bin/echo "ログイン名(logname): $LOGIN_NAME"
###UID
USER_NAME=$(/usr/bin/id -un)
/bin/echo "ユーザー名(id): $USER_NAME"
#################################################
/bin/echo "設定ファイルへのパス　まずは製品版から"
STR_PLIST_PATH="$HOME/Library/Preferences/com.adobe.Acrobat.Pro.plist"
###IPMEnableAV2AcrobatNewUser
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:IPMEnableAV2AcrobatNewUser:1" "$STR_PLIST_PATH")
/bin/echo "IPMEnableAV2AcrobatNewUser 現在の設定は: $BOOL_VALUE"
if [ "$BOOL_VALUE" = "true" ]; then
##設定をFALSEに
/usr/libexec/PlistBuddy -c "Set:DC:AVGeneral:IPMEnableAV2AcrobatNewUser:1 bool false" "$STR_PLIST_PATH"
/bin/echo "IPMEnableAV2AcrobatNewUser 設定を変更しました"
fi
###EnableAV2
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:EnableAV2:1" "$STR_PLIST_PATH")
/bin/echo "EnableAV2 現在の設定は: $BOOL_VALUE"
if [ "$BOOL_VALUE" = "true" ]; then
##設定をFALSEに
/usr/libexec/PlistBuddy -c "Set:DC:AVGeneral:EnableAV2:1 bool false" "$STR_PLIST_PATH"
/bin/echo "EnableAV2 設定を変更しました"
fi
###EnableAV2Enterprise
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:FeatureLockDown:EnableAV2Enterprise" "$STR_PLIST_PATH")
/bin/echo "EnableAV2Enterprise 現在の設定は: $BOOL_VALUE"
if [ "$BOOL_VALUE" = "true" ]; then
##設定をFALSEに
/usr/libexec/PlistBuddy -c "Set:DC:FeatureLockDown:EnableAV2Enterprise bool false" "$STR_PLIST_PATH"
/bin/echo "EnableAV2Enterprise 設定を変更しました"
fi
##保存
/usr/libexec/PlistBuddy -c "Save" "$STR_PLIST_PATH"

#################################################
/bin/echo "設定ファイルへのパス　無償Reader版"
STR_PLIST_PATH="$HOME/Library/Preferences/com.adobe.Reader.plist"
###IPMEnableAV2ReaderNewUser
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:IPMEnableAV2ReaderNewUser:1" "$STR_PLIST_PATH")
/bin/echo "IPMEnableAV2ReaderNewUser 現在の設定は: $BOOL_VALUE"
if [ "$BOOL_VALUE" = "true" ]; then
##設定をFALSEに
/usr/libexec/PlistBuddy -c "Set:DC:AVGeneral:IPMEnableAV2ReaderNewUser:1 bool false" "$STR_PLIST_PATH"
/bin/echo "IPMEnableAV2ReaderNewUser 設定を変更しました"
fi
###EnableAV2
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:EnableAV2:1" "$STR_PLIST_PATH")
/bin/echo "EnableAV2 現在の設定は: $BOOL_VALUE"
if [ "$BOOL_VALUE" = "true" ]; then
##設定をFALSEに
/usr/libexec/PlistBuddy -c "Set:DC:AVGeneral:EnableAV2:1 bool false" "$STR_PLIST_PATH"
/bin/echo "EnableAV2 設定を変更しました"
fi
###EnableAV2Enterprise
BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print:DC:FeatureLockDown:EnableAV2Enterprise" "$STR_PLIST_PATH")
/bin/echo "EnableAV2Enterprise 現在の設定は: $BOOL_VALUE"
if [ "$BOOL_VALUE" = "true" ]; then
##設定をFALSEに
/usr/libexec/PlistBuddy -c "Set:DC:FeatureLockDown:EnableAV2Enterprise bool false" "$STR_PLIST_PATH"
/bin/echo "EnableAV2Enterprise 設定を変更しました"
fi
##保存
/usr/libexec/PlistBuddy -c "Save" "$STR_PLIST_PATH"

exit 0
