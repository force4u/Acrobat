#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
################################################
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
###STAT
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"
################################################
# 設定する方のコメントはずしてね
STR_PLIST_FILEPAHT="$HOME/Library/Preferences/com.adobe.Reader.plist"
#STR_PLIST_FILEPAHT="$HOME/Library/Preferences/com.adobe.Acrobat.Pro.plist"
################################Classic設定
##General
INT_CLASSNO=$(/usr/libexec/PlistBuddy -c "Print:DC:General:PrintAsImage:0" "$STR_PLIST_FILEPAHT")
if [ $? -ne 0 ]; then
  /bin/echo "General未設定"
  /usr/libexec/PlistBuddy -c "Add:DC:General:PrintAsImage array" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:General:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:General:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
elif [ "$INT_CLASSNO" -eq 0 ]; then
  /bin/echo "設定値0=boolで正しいです"
  /usr/libexec/PlistBuddy -c "Delete:DC:General:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:General:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
else
  /bin/echo "設定値が" "$INT_CLASSNO" "なので0を設定します"
  /usr/libexec/PlistBuddy -c "Delete:DC:General:PrintAsImage:0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Delete:DC:General:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:General:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:General:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
fi
/usr/libexec/PlistBuddy -c "Save" "$STR_PLIST_FILEPAHT"
################################AV2設定
##AVGeneral
INT_CLASSNO=$(/usr/libexec/PlistBuddy -c "Print:DC:AVGeneral:PrintAsImage:0" "$STR_PLIST_FILEPAHT")
if [ $? -ne 0 ]; then
  /bin/echo "General未設定"
  /usr/libexec/PlistBuddy -c "Add:DC:AVGeneral:PrintAsImage array" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVGeneral:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVGeneral:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
elif [ "$INT_CLASSNO" -eq 0 ]; then
  /bin/echo "設定値0=boolで正しいです"
  /usr/libexec/PlistBuddy -c "Delete:DC:AVGeneral:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVGeneral:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
else
  /bin/echo "設定値が" "$INT_CLASSNO" "なので0を設定します"
  /usr/libexec/PlistBuddy -c "Delete:DC:AVGeneral:PrintAsImage:0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Delete:DC:AVGeneral:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVGeneral:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVGeneral:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
fi
/usr/libexec/PlistBuddy -c "Save" "$STR_PLIST_FILEPAHT"

exit 0
##ここまで　ConversionToPDF　と　AVConversionToPDFは処理しない
################################Classic設定
##ConversionToPDF
INT_CLASSNO=$(/usr/libexec/PlistBuddy -c "Print:DC:ConversionToPDF:Settings:1:PrintAsImage:0" "$STR_PLIST_FILEPAHT")
if [ $? -ne 0 ]; then
  /bin/echo "General未設定"
  /usr/libexec/PlistBuddy -c "Add:DC:ConversionToPDF:Settings:1:PrintAsImage:0 array " "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:ConversionToPDF:Settings:1:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:ConversionToPDF:Settings:1:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
elif [ "$INT_CLASSNO" -eq 0 ]; then
  /bin/echo "設定値0=boolで正しいです"
  /usr/libexec/PlistBuddy -c "Delete:DC:ConversionToPDF:Settings:1:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:ConversionToPDF:Settings:1:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
else
  /bin/echo "設定値が" "$INT_CLASSNO" "なので0を設定します"
  /usr/libexec/PlistBuddy -c "Delete:DC:ConversionToPDF:Settings:1:PrintAsImage:0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Delete:DC:ConversionToPDF:Settings:1:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:ConversionToPDF:Settings:1:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:ConversionToPDF:Settings:1:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
fi
/usr/libexec/PlistBuddy -c "Save" "$STR_PLIST_FILEPAHT"



################################AV2設定
##AVConversionToPDF
INT_CLASSNO=$(/usr/libexec/PlistBuddy -c "Print:DC:AVConversionToPDF:Settings:1:PrintAsImage:0" "$STR_PLIST_FILEPAHT")
if [ $? -ne 0 ]; then
  /bin/echo "General未設定"
  /usr/libexec/PlistBuddy -c "Add:DC:AVConversionToPDF:Settings:1:PrintAsImage:0 array " "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVConversionToPDF:Settings:1:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVConversionToPDF:Settings:1:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
elif [ "$INT_CLASSNO" -eq 0 ]; then
  /bin/echo "設定値0=boolで正しいです"
  /usr/libexec/PlistBuddy -c "Delete:DC:AVConversionToPDF:Settings:1:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVConversionToPDF:Settings:1:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
else
  /bin/echo "設定値が" "$INT_CLASSNO" "なので0を設定します"
  /usr/libexec/PlistBuddy -c "Delete:DC:AVConversionToPDF:Settings:1:PrintAsImage:0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Delete:DC:AVConversionToPDF:Settings:1:PrintAsImage:1" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVConversionToPDF:Settings:1:PrintAsImage:0 integer 0" "$STR_PLIST_FILEPAHT"
  /usr/libexec/PlistBuddy -c "Add:DC:AVConversionToPDF:Settings:1:PrintAsImage:1 bool false" "$STR_PLIST_FILEPAHT"
fi
/usr/libexec/PlistBuddy -c "Save" "$STR_PLIST_FILEPAHT"

exit 0
