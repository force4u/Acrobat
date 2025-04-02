#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
#set -x
#export PATH=/usr/bin:/bin:/usr/sbin:/sbin
#export CONT="$HOME/Library/Containers"
#サンドボックスモードの場合
#export SBXHOME="$CONT/com.adobe.Reader/Data/"
#アクセス権を755でターミナルにドロップしてください
#################################################
#ユーザー名
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"
#PLISTパス
PATH_PLIST="/Users/${STAT_USR}/Library/Preferences/com.adobe.Acrobat.Pro.plist"
#サンドボックスの場合
#PATH_PLIST_SBX="/Users/${STAT_USR}/Library/Containers/com.adobe.Reader/Data/Library/Preferences/com.adobe.Acrobat.Pro.plist"
#PATH_PLIST=PATH_PLIST_SBX
#まずはバックアップ
STR_DATE=$(/bin/date "+%Y%m%d%H%M%S")
#書類フォルダに設定ファイルをコピーします
PATH_DIST_DIR="/Users/${STAT_USR}/Documents/Adobe/Acrobat/Acrobat Reader/Preferences/${STR_DATE}"
PATH_DIST_FILE="${PATH_DIST_DIR}/com.adobe.Acrobat.Pro.plist"
/bin/mkdir -p "$PATH_DIST_DIR"
/usr/bin/ditto "$PATH_PLIST" "$PATH_DIST_FILE"
#不具合発生時には
#書類フォルダの/Adobe/Acrobat/Acrobat Reader/Preferenceにコピーしたファイルで
#元に戻す事ができます

################################################
#まずは現在の値を
function DO_CHK_VALUE {
  STR_SET_PATH=$1
  BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Print${STR_SET_PATH}" "$PATH_PLIST")
  if [ $? -ne 0 ]; then
    /bin/echo "${STR_SET_PATH} : 未定義です"
  else
    /bin/echo "${STR_SET_PATH} : ${BOOL_VALUE}"
  fi
}
/bin/echo "現在の設定値です"

STR_SET_PATH=":DC:FeatureLockdown:EnableGentech:1"
DO_CHK_VALUE "$STR_SET_PATH"

################################################
#ユーザー判断
while true; do
  /bin/echo "これらの項目にfalseを設定します"
  /bin/echo "処理を実行しますか？ (y/n)"
  read -r choice
  case "$choice" in
  [Yy]*)
    /bin/echo "処理を実行します..."
    break
    ;;
  [Nn]*)
    /bin/echo "処理をキャンセルしました。"
    exit 1
    ;;
  *)
    /bin/echo "無効な入力です。y または n を入力してください。"
    ;;
  esac
done

################################################
#値にFALSEを入れる　ARRAYの場合
function DO_SET_FALSE_ARRAY {
  STR_SET_PATH=$1
  STR_PRE_ARRAY="${STR_SET_PATH%:*}"
  /usr/libexec/PlistBuddy -c "Print ${STR_SET_PATH}" "$PATH_PLIST"
  if [ $? -ne 0 ]; then
    /usr/libexec/PlistBuddy -c "Print ${STR_PRE_ARRAY}" "$PATH_PLIST"
    if [ $? -ne 0 ]; then
      /usr/libexec/PlistBuddy -c "Add ${STR_PRE_ARRAY} array" "$PATH_PLIST"
    fi
    /usr/libexec/PlistBuddy -c "Add ${STR_PRE_ARRAY}:0 integer 0" "$PATH_PLIST"
    BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Add ${STR_SET_PATH} bool false" "$PATH_PLIST")
  else
    #Arrayを削除して
    /usr/libexec/PlistBuddy -c "Delete ${STR_PRE_ARRAY}" "$PATH_PLIST"
    #再設定
    /usr/libexec/PlistBuddy -c "Add ${STR_PRE_ARRAY} array" "$PATH_PLIST"
    /usr/libexec/PlistBuddy -c "Add ${STR_PRE_ARRAY}:0 integer 0" "$PATH_PLIST"
    BOOL_VALUE=$(/usr/libexec/PlistBuddy -c "Add ${STR_PRE_ARRAY}:1 bool false" "$PATH_PLIST")
  fi
  /bin/echo "${STR_SET_PATH} : ${BOOL_VALUE} FALSE=NOを設定しました"
}

STR_SET_PATH=":DC:FeatureLockdown:EnableGentech:1"
DO_SET_FALSE_ARRAY "$STR_SET_PATH"
#保存
/usr/libexec/PlistBuddy -c "Save" "$PATH_PLIST"
#確認
/bin/echo "変更後の値です"
STR_SET_PATH=":DC:FeatureLockdown:EnableGentech:1"
DO_CHK_VALUE "$STR_SET_PATH"

exit 0
