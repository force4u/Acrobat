#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
# 32bit版の　製品版Acrobat Reader用です WINDOWS
#
# <https://quicktimer.cocolog-nifty.com/icefloe/2024/06/post-04a154.html>
#################################################
#設定項目 7zzへのパス　7zzが解凍に必要です
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"
STR_BIN_PATH="/Users/${STAT_USR}/bin/7zip/7zz"
#一般的にはこちらのパス
#STR_BIN_PATH="/usr/local/bin/7zip/7zz"

#################################################
#最新バージョン番号を確認
#このURLは64bit版
#STR_URL="https://armmf.adobe.com/arm-manifests/mac/AcrobatDC/acrobat/current_version.txt"
#32bitはこちら
STR_URL="https://armmf.adobe.com/arm-manifests/mac/AcrobatDC/reader/current_version.txt"
#ダウンロード
if ! STR_NEWER_VER=$(/usr/bin/ruby -r open-uri -e 'puts URI.open(ARGV[0]).read' "$STR_URL"); then
  /bin/echo "ファイルのダウンロードに失敗しました CURLで再トライします"
  if ! STR_NEWER_VER=$(/usr/bin/curl -L -o "$STR_PKG_FILE_PATH" "$STR_URL" --connect-timeout 20); then
    /bin/echo "ファイルのダウンロードに失敗しました"
    exit 1
  fi
fi

#################################################
#ダウンロード先を確保
LOCAL_TMP_DIR=$(/usr/bin/mktemp -d)
/bin/echo "TMPDIR：" "$LOCAL_TMP_DIR"
#保存先のパス
STR_CAB_FILE_PATH="${LOCAL_TMP_DIR}/ReaderDCManifest3.cab"
#ダウンロードURL
STR_URL="https://armmf.adobe.com/arm-manifests/win/ReaderDCManifest3.msi"
#ダウンロード
if ! /usr/bin/ruby -r open-uri -e 'File.write(ARGV[1], URI.open(ARGV[0]).read)' "$STR_URL" "$STR_CAB_FILE_PATH"; then
  /bin/echo "ファイルのダウンロードに失敗しました HTTP1.1で再トライします"
  if ! /usr/bin/curl -L -o "$STR_CAB_FILE_PATH" "$STR_URL" --connect-timeout 20; then
    /bin/echo "ファイルのダウンロードに失敗しました"
    exit 1
  fi
fi
#################################################
#解凍先パス
STR_EXPAND_DIR_PATH="${LOCAL_TMP_DIR}/AcrobatManifest"
/bin/mkdir -p "$STR_EXPAND_DIR_PATH"
/bin/chmod 777 "$STR_EXPAND_DIR_PATH"
#解凍
/bin/cd "$LOCAL_TMP_DIR"
pushd "$LOCAL_TMP_DIR" && "$STR_BIN_PATH" x "$STR_CAB_FILE_PATH" -o"$STR_EXPAND_DIR_PATH"

#################################################
#テキスト保存先
STR_SAVE_FILE_PATH="${LOCAL_TMP_DIR}/AcrobatManifest.txt"
/bin/echo "Windows版 32bit　Acrobat Reader版アップデータ" | tee -a "$STR_SAVE_FILE_PATH" 
/bin/echo "最新バージョンは" "$STR_NEWER_VER" "です" | tee -a "$STR_SAVE_FILE_PATH" 
/bin/echo "拡張子MSI：インストーラー" | tee -a "$STR_SAVE_FILE_PATH" 
/bin/echo "拡張子MSP：パッチインストール" | tee -a "$STR_SAVE_FILE_PATH" 
/bin/echo "INCR：差分のみパッチ" | tee -a "$STR_SAVE_FILE_PATH" 
/bin/echo "MUI：マルチリンガル" | tee -a "$STR_SAVE_FILE_PATH" 
/bin/echo "" | tee -a "$STR_SAVE_FILE_PATH" 

#読み込むSQLテキストファイルパス
STR_TEXT_FILE_PATH="${STR_EXPAND_DIR_PATH}/!_StringData"
#TEXT読み込み
STR_READ_TEXT=$(/bin/cat "$STR_TEXT_FILE_PATH")
#URLで改行
STR_TMP_TEXT=$(/bin/echo "$STR_READ_TEXT" | sed 's/https/\nhttps/g')
STR_TMP_TEXT=$(/bin/echo "$STR_TMP_TEXT" | sed 's/msi/msi\n/g')
STR_URL_TEXT=$(/bin/echo "$STR_TMP_TEXT" | sed 's/msp/msp\n/g')

#改行でリストにする
IFS=$'\n' read -r -d '' -a LIST_LINE_TEXT <<<"$STR_URL_TEXT"
for ITEM_LINETEXT in "${LIST_LINE_TEXT[@]}"; do
  if [[ "$ITEM_LINETEXT" == https* ]]; then
    /bin/echo "URL: " | tee -a "$STR_SAVE_FILE_PATH"
    /bin/echo "$ITEM_LINETEXT" | tee -a "$STR_SAVE_FILE_PATH"
  elif [[ "$ITEM_LINETEXT" == ID_* ]]; then
    /bin/echo "ID: $ITEM_LINETEXT" | tee -a "$STR_SAVE_FILE_PATH"
  /bin/echo "" | tee -a "$STR_SAVE_FILE_PATH"
  fi
done

#################################################
#収集したURLテキストを開く
/usr/bin/open "$STR_SAVE_FILE_PATH"

exit 0
