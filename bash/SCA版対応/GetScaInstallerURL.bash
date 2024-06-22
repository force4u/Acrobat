#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
# SCA(SingleClientApp)　Unified App版
# IDに MINIがつくのはREADER版
# FULLは新規または上書きインストール用
#################################################
#STAT
STAT_USR=$(/usr/bin/stat -f%Su /dev/console)
/bin/echo "STAT_USR(console): $STAT_USR"

#################################################
#ダウンロード先を確保
LOCAL_TMP_DIR=$(/usr/bin/mktemp -d)
/bin/echo "TMPDIR：" "$LOCAL_TMP_DIR"
#保存先のパス
STR_PKG_FILE_PATH="${LOCAL_TMP_DIR}/AcrobatSCAManifest.pkg"
#ダウンロードURL
STR_URL="https://armmf.adobe.com/arm-manifests/mac/AcrobatDC/acrobatSCA/AcrobatSCAManifest.arm"
#ダウンロード
if ! /usr/bin/curl -L -o "$STR_PKG_FILE_PATH" "$STR_URL" --connect-timeout 20; then
  /bin/echo "ファイルのダウンロードに失敗しました HTTP1.1で再トライします"
  if ! /usr/bin/curl -L -o "$STR_PKG_FILE_PATH" "$STR_URL" --http1.1 --connect-timeout 20; then
    /bin/echo "ファイルのダウンロードに失敗しました"
    exit 1
  fi
fi
#################################################
#解凍先パス
STR_EXPAND_DIR_PATH="${LOCAL_TMP_DIR}/AcrobatSCAManifest"
#解凍
/usr/sbin/pkgutil --expand-full "$STR_PKG_FILE_PATH" "$STR_EXPAND_DIR_PATH"

#################################################
#出力用のテキスト
STR_OUTPUT_TEXT=""
#テキスト保存先
STR_TEXT_FILE_PATH="${LOCAL_TMP_DIR}/AcrobatSCAManifest/AcrobatSCAManifest.txt"
#XML保存先
STR_XML_FILE_PATH="${LOCAL_TMP_DIR}/AcrobatSCAManifest/ASSET/AcrobatSCAManifest.xml"
#XML読み込み
XML_READ_DATA=$(/usr/bin/xmllint --format "$STR_XML_FILE_PATH")
#XMLをdItemだけ読み込んで
STR_DITEM=$(/bin/echo "$XML_READ_DATA" | /usr/bin/xmllint --xpath '//dItem' -)
#改行でリストにする
IFS=$'\n' read -r -d '' -a LIST_DITEM <<<"$STR_DITEM"
for ITEM_DITEM in "${LIST_DITEM[@]}"; do
  #ID
  STR_ID=$(/bin/echo "$ITEM_DITEM" | /usr/bin/xmllint --xpath 'string(/dItem/@id)' -)
  #URLだけ必要な場合はここを出力しなければいい
  /bin/echo "STR_ID : " "$STR_ID" >>"$STR_TEXT_FILE_PATH"
  #httpURLBase
  STR_URLBASE=$(/bin/echo "$ITEM_DITEM" | /usr/bin/xmllint --xpath 'string(/dItem/@httpURLBase)' -)
  /bin/echo "STR_URLBASE : " "$STR_URLBASE"
  #httpURLBase
  STR_URL_PATH=$(/bin/echo "$ITEM_DITEM" | /usr/bin/xmllint --xpath 'string(/dItem/@URL)' -)
  /bin/echo "STR_URL_PATH : " "$STR_URL_PATH"
  #fileName
  STR_FILE_NAME=$(/bin/echo "$ITEM_DITEM" | /usr/bin/xmllint --xpath 'string(/dItem/@fileName)' -)
  /bin/echo "STR_FILE_NAME : " "$STR_FILE_NAME"

  STR_OUTPUT_TEXT="${STR_URLBASE}/${STR_URL_PATH}/${STR_FILE_NAME}"
  /bin/echo "$STR_OUTPUT_TEXT" >>"$STR_TEXT_FILE_PATH"
  /bin/echo "" >>"$STR_TEXT_FILE_PATH"
done

#################################################
#収集したURLテキストを開く
/usr/bin/open "$STR_TEXT_FILE_PATH"

exit 0
