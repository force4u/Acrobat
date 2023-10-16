#!/bin/bash
#com.cocolog-nifty.quicktimer.icefloe
#################################################

STR_URL="http://ccmdl.adobe.com/AdobeProducts/APRO/18/osx10/Acrobat_DC_Web_WWMUI.dmg"
STR_SAVE_FILE_PATH="$HOME/Downloads/Acrobat_DC_18.dmg"
/usr/bin/curl "$STR_URL"  -o "$STR_SAVE_FILE_PATH"  -v --progress-bar --header 'x-api-key: CreativeCloud_v4_5' --user-agent 'Creative Cloud'


exit 0
