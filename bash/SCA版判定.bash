#! /bin/bash
#com.cocolog-nifty.quicktimer.icefloe
##SCA版か？のみを判定する
BOOL_SCA=$(/usr/bin/defaults read "/Applications/Adobe Acrobat DC/Adobe Acrobat.app/Contents/Info.plist" AcroSCA)
if [ "$BOOL_SCA" == "1" ]; then
/bin/echo "SCA版インストールです"
else 
/bin/echo "従来版インストールです"
fi

##SCA版のインストール状態を判定する設定ファイル
STR_PLIST_PATH="/Library/Application Support/Adobe/Acrobat/DC/SupportFiles/Preferences/com.adobe.acrobat.scainstaller.plist"

STR_ISSCACROAPPINSTALLED=$(/usr/bin/defaults read "$STR_PLIST_PATH" bIsSCAcroAppInstalled)
/bin/echo "bIsSCAcroAppInstalled:""$STR_ISSCACROAPPINSTALLED"
if [ "$STR_ISSCACROAPPINSTALLED" == "1" ]; then
	/bin/echo "bIsSCAcroAppInstalled=1=TURE  FULLパッケージでインストールしてあります"
elif [ "$STR_ISSCACROAPPINSTALLED" == "0" ]; then
	/bin/echo "bIsSCAcroAppInstalled=0=FALSE  MINIパッケージでインストールしてあります"
fi

STR_SCAPACKAGELEVEL=$(/usr/bin/defaults read "$STR_PLIST_PATH" SCAPackageLevel)
/bin/echo "SCAPackageLevel:""$STR_SCAPACKAGELEVEL"
if [ "$STR_SCAPACKAGELEVEL" == 1 ]; then
	/bin/echo "SCAPackageLevel=1 Mini版　Readerモードです"
elif [ "$STR_SCAPACKAGELEVEL" == 3 ]; then
	/bin/echo "SCAPackageLevel=1 Full版 製品版 モードです"
fi

STR_ISSINGLECLIENTAPP=$(/usr/bin/defaults read "$STR_PLIST_PATH" bIsSingleClientApp)
/bin/echo "bIsSingleClientApp:""$STR_ISSINGLECLIENTAPP"
if [ "$STR_ISSINGLECLIENTAPP" == "1" ]; then
	/bin/echo "bIsSingleClientApp=1=TRUE　SCA版をインストールしています"
else
	/bin/echo "bIsSingleClientApp=1=FALSE or NUL 通常盤です"
fi
