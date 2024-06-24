#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
# 32bit版の Acrobat Reader用です WINDOWS
# アップデータ　パッチ差分　パッチ累積のURL
# <https://quicktimer.cocolog-nifty.com/icefloe/2024/06/post-04a154.html>
#
#過去のバージョンも含む全てのアップデータのURL
#################################################
#設定項目 7zzへのパス　7zzが解凍に必要です
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"
STR_BIN_PATH="/Users/${STAT_USR}/bin/7zip/7zz"
#一般的にはこちらのパス
#STR_BIN_PATH="/usr/local/bin/7zip/7zz"

#################################################
#最新バージョン番号を確認
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
STR_CAB_FILE_PATH="${LOCAL_TMP_DIR}/ReaderCatalog-DC.cab"
#ダウンロードURL
STR_URL="https://armmf.adobe.com/arm-manifests/win/SCUP/ReaderCatalog-DC.cab"
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
/bin/echo "Windows版 32bit　64bit Reader 版 全バージョンアップデータ" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "最新バージョンは" "$STR_NEWER_VER" "です" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "拡張子MSI：インストーラー" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "拡張子MSP：パッチインストール" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "INCR：差分のみパッチ" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "MUI：マルチリンガル" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "無印：32bit版" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "x64：64bit版" | tee -a "$STR_SAVE_FILE_PATH"
/bin/echo "" | tee -a "$STR_SAVE_FILE_PATH"

#XMLファイルパス
STR_XML_FILE_PATH="${LOCAL_TMP_DIR}/AcrobatManifest/Reader_Catalog.xml"
#抽出先
STR_TMP_FILE_PATH="${LOCAL_TMP_DIR}/AcrobatManifest/OriginFile.xml"
#XML読み込み
/bin/echo "$STR_XML_FILE_PATH"
#URL部分のみ抽出
/bin/cat <"$STR_XML_FILE_PATH" | grep '<sdp:OriginFile' >"$STR_TMP_FILE_PATH"
#XML読み込み
/bin/echo "$STR_TMP_FILE_PATH"
#抽出したデータを読み込み
XML_READ_DATA=$(/bin/cat <"$STR_TMP_FILE_PATH")
#XML_READ_DATA=$(/usr/bin/xmllint --format "$STR_TMP_FILE_PATH")

#改行でリストにする
IFS=$'\n' read -r -d '' -a LIST_DITEM <<<"$XML_READ_DATA"
for ITEM_DITEM in "${LIST_DITEM[@]}"; do

  STR_URL=$(/bin/echo "$ITEM_DITEM" | sed -n 's/.*OriginUri="\([^"]*\)".*/\1/p')
  /bin/echo "$STR_URL" | tee -a "$STR_SAVE_FILE_PATH"
  /bin/echo "" | tee -a "$STR_SAVE_FILE_PATH"
done

#################################################
#収集したURLテキストを開く
/usr/bin/open "$STR_TEXT_FILE_PATH"
#################################################
#収集したURLテキストを開く
/usr/bin/open "$STR_SAVE_FILE_PATH"

exit 0
