#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
#
#################################################
###管理者インストールしているか？チェック
USER_WHOAMI=$(/usr/bin/whoami)
/bin/echo "実行ユーザー(whoami): $USER_WHOAMI"
SCRIPT_PATH="${BASH_SOURCE[0]}"
/bin/echo "/usr/bin/sudo \"$SCRIPT_PATH\""
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

########################################
###ダウンロード
###ダウンロード起動時に削除する項目
USER_TEMP_DIR=$(/usr/bin/mktemp -d)
/bin/echo "起動時に削除されるディレクトリ：" "$USER_TEMP_DIR"

/bin/echo "ダウンロード開始"
###ダウンロードURL
STR_URL="https://ardownload2.adobe.com/pub/adobe/reader/mac/AcrobatDC/2200320314/AcroRdrDCUpd2200320314_MUI.dmg"
/usr/bin/curl -Lv "$STR_URL" -o "$USER_TEMP_DIR/AcroRdrDCUpd.dmg"
/bin/echo "ダウンロード終了"
########################################
###DMGからPKGを取り出す
/bin/echo "DMGマウント :開始"
###マウントする場所を作成
/bin/mkdir -p "$USER_TEMP_DIR/MountPoint/DC"
/bin/chmod 777 "$USER_TEMP_DIR/MountPoint/DC"
###マウント
/usr/bin/hdiutil attach "$USER_TEMP_DIR/AcroRdrDCUpd.dmg" -noverify -nobrowse -noautoopen -mountpoint "$USER_TEMP_DIR/MountPoint/DC"
/bin/echo "PKG解凍 :開始"
###解凍先を作成
/bin/mkdir -p "$USER_TEMP_DIR/Expand"
/bin/chmod 777 "$USER_TEMP_DIR/Expand"
###PKG解凍
/usr/sbin/pkgutil --expand "$USER_TEMP_DIR/MountPoint/DC/AcroRdrDCUpd2200320314_MUI.pkg" "$USER_TEMP_DIR/Expand/Expand.pkg"
###DMGをアンマウント
/usr/bin/hdiutil detach "$USER_TEMP_DIR/MountPoint/DC" -force
/bin/echo "PKG解凍 :完了"
########################################
###Payload解凍
/bin/echo "Payload解凍 :開始"
/bin/mkdir -p "$USER_TEMP_DIR/7z"
/bin/chmod 777 "$USER_TEMP_DIR/7z"
/usr/bin/ditto -xzv "$USER_TEMP_DIR/Expand/Expand.pkg/payload.pkg/Payload" "$USER_TEMP_DIR/7z"
/bin/echo "Payload解凍 :完了"
########################################
###7z解凍
/bin/echo "7zz解凍 :開始"
/bin/mkdir -p "$USER_TEMP_DIR/Extract"
/bin/chmod 777 "$USER_TEMP_DIR/Extract"
"$USER_TEMP_DIR/Expand/Expand.pkg/acropython3.pkg/Scripts/Tools/7za" x "$USER_TEMP_DIR/7z/MUI.7z" -o"$USER_TEMP_DIR/Extract" -y -slt

/bin/echo "7zz解凍 :完了"
########################################
###これでだけはsudo必要
/usr/bin/sudo "$USER_TEMP_DIR/Expand/Expand.pkg/RdrServicesUpdater.pkg/Scripts/Tools/RdrServicesUpdater.app/Contents/MacOS/RdrServicesUpdater"
########################################
###ダウンロードフォルダへ移動
/bin/echo "終了処理 :開始"
/bin/mkdir -p "/Users/$CONSOLE_USER/Downloads/Adobe Acrobat Reader DC"
/bin/chmod 777 "/Users/$CONSOLE_USER/Downloads/Adobe Acrobat Reader DC"

/bin/mv -f "$USER_TEMP_DIR/Extract/MUI/Application/Adobe Acrobat Reader DC.app" "/Users/$CONSOLE_USER/Downloads/Adobe Acrobat Reader DC"
/usr/bin/open "/Users/$CONSOLE_USER/Downloads/Adobe Acrobat Reader DC"

###ダウンロードに使ったフォルダをゴミ箱に入れる
/bin/mv -f "$USER_TEMP_DIR" "/Users/$CONSOLE_USER/.Trash"


/bin/echo "ダウンロードフォルダに解凍しました"

exit 0
