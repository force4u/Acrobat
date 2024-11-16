#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
: <<'EOF'
"/Library/Application Support/Adobe/ARMDC/Registered Products"に生成される設定ファイルの値が
ユーザー設定を参照しないようになっている項目を修正します
FeatureLockDownの参照先を
/Library/Preferences/com.adobe.Acrobat.Pro.plist
/Library/Preferences/com.adobe.Reader.plistt
から
~/Library/Preferences/com.adobe.Acrobat.Pro.plist
~/Library/Preferences/com.adobe.Reader.plistt　に変更します

EOF

STR_PREF_FILE_PATH_CLASSIC="com.adobe.acrobat.classic.plist"
STR_PREF_FILE_PATH_DC="com.adobe.acrobat.dc.plist"
STR_PREF_FILE_PATH_2020="com.adobe.acrobat.2020.plist"

STR_PREF_FILE_PATH_READER="com.adobe.reader.dc.plist"
STR_PREF_FILE_PATH_READER2020="com.adobe.reader.2020.plist"

STR_SERV_FILE_PATH_CLASSIC="com.adobe.acrobat.servicesupdater.classic.plist"
STR_SERV_FILE_PATH_DC="com.adobe.acrobat.servicesupdater.dc.plist"
STR_SERV_FILE_PATH_2020="com.adobe.acrobat.servicesupdater.2020.plist"

STR_SERV_FILE_PATH_READER="com.adobe.reader.servicesupdater.dc.plist"
STR_SERV_FILE_PATH_READER2020="com.adobe.reader.servicesupdater.2020.plist"

LIST_PLIST_FILE_NAME=(
	"$STR_PREF_FILE_PATH_CLASSIC"
	"$STR_PREF_FILE_PATH_DC"
	"$STR_PREF_FILE_PATH_2020"
	"$STR_PREF_FILE_PATH_READER"
	"$STR_PREF_FILE_PATH_READER2020"

	"$STR_SERV_FILE_PATH_CLASSIC"
	"$STR_SERV_FILE_PATH_DC"
	"$STR_SERV_FILE_PATH_2020"
	"$STR_SERV_FILE_PATH_READER"
	"$STR_SERV_FILE_PATH_READER2020"
)
STR_BASE_DIR_PATH="/Library/Application Support/Adobe/ARMDC/Registered Products"

#まずはタッチする
for ITEM_FILE_NAME in "${LIST_PLIST_FILE_NAME[@]}"; do
	STR_FILE_PATH="${STR_BASE_DIR_PATH}/${ITEM_FILE_NAME}"
	/bin/echo "TOUCH: ${STR_FILE_PATH}"
	/usr/bin/sudo /usr/bin/touch "$STR_FILE_PATH"
done


#アクセス権を修正
for ITEM_FILE_NAME in "${LIST_PLIST_FILE_NAME[@]}"; do
	STR_FILE_PATH="${STR_BASE_DIR_PATH}/${ITEM_FILE_NAME}"
	/bin/echo "CHMOD: ${STR_FILE_PATH}"
	/usr/bin/sudo /bin/chmod 644 "$STR_FILE_PATH"
done


#	STR_PREF_FILE_PATH_CLASSIC="com.adobe.acrobat.classic.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_PREF_FILE_PATH_CLASSIC}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Acrobat.Pro.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "Classic/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Acrobat.Pro.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 'Classic/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_PREF_FILE_PATH_DC="com.adobe.acrobat.dc.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_PREF_FILE_PATH_DC}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Acrobat.Pro.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "DC/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Acrobat.Pro.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 'DC/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_PREF_FILE_PATH_2020="com.adobe.acrobat.2020.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_PREF_FILE_PATH_2020}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Acrobat.Pro.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "2020/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Acrobat.Pro.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 '2020/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_SERV_FILE_PATH_CLASSIC="com.adobe.acrobat.servicesupdater.classic.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_SERV_FILE_PATH_CLASSIC}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Acrobat.Pro.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "Classic/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Acrobat.Pro.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 'Classic/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_SERV_FILE_PATH_DC="com.adobe.acrobat.servicesupdater.dc.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_SERV_FILE_PATH_DC}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Acrobat.Pro.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "DC/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Acrobat.Pro.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 'DC/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_SERV_FILE_PATH_2020="com.adobe.acrobat.servicesupdater.2020.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_SERV_FILE_PATH_2020}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Acrobat.Pro.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "2020/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Acrobat.Pro.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 '2020/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

####ここからREADER

#	STR_PREF_FILE_PATH_READER="com.adobe.reader.dc.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_PREF_FILE_PATH_READER}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Reader.plistt"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "DC/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Reader.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 'DC/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_PREF_FILE_PATH_READER2020="com.adobe.reader.2020.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_PREF_FILE_PATH_READER2020}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Reader.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "2020/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Reader.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 '2020/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_SERV_FILE_PATH_READER="com.adobe.reader.servicesupdater.dc.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_SERV_FILE_PATH_READER}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Reader.plistt"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "DC/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Reader.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 'DC/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#	STR_SERV_FILE_PATH_READER2020="com.adobe.reader.servicesupdater.2020.plist"
STR_TARGET_PATH="${STR_BASE_DIR_PATH}/${STR_SERV_FILE_PATH_READER2020}"
if ! /usr/bin/defaults read "$STR_TARGET_PATH" FeatureLockDown; then
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "~/Library/Preferences/com.adobe.Reader.plist"
	/usr/bin/sudo /usr/bin/defaults write "$STR_TARGET_PATH" FeatureLockDown -array-add -string "2020/FeatureLockdown/cServices/bUpdater"
else
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:0 '~/Library/Preferences/com.adobe.Reader.plist'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Set:FeatureLockDown:1 '2020/FeatureLockdown/cServices/bUpdater'" "$STR_TARGET_PATH"
	/usr/bin/sudo /usr/libexec/PlistBuddy -c "Save" "$STR_TARGET_PATH"
fi

#アクセス権を修正
for ITEM_FILE_NAME in "${LIST_PLIST_FILE_NAME[@]}"; do
	STR_FILE_PATH="${STR_BASE_DIR_PATH}/${ITEM_FILE_NAME}"
	/bin/echo "CHMOD: ${STR_FILE_PATH}"
	/usr/bin/sudo /bin/chmod 644 "$STR_FILE_PATH"
done

exit
