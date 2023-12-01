#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#  com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7

use AppleScript version "2.8"
use framework "Foundation"
use scripting additions



tell application "Adobe Acrobat"
	activate
	tell active doc
		tell PDF Window 1
			####ページ数
			try
				set numAllPages to count of every page
			on error
				display alert "エラー:pdfを開いていません" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 10
				return
			end try
		end tell
		create thumbs
	end tell
end tell
############ここまで定型

tell application "Adobe Acrobat"
	activate
	tell active doc
		set strFileName to name as text
	end tell
end tell


tell application "Adobe Acrobat"
	activate
	tell active doc
		do script ("this.info.Title= (\"\");")
		##特定の文字列入れたい場合
		##	do script ("var strDocTitle = \"ここにお好きな文字列\";")
		##	do script ("this.info.Title= (strDocTitle);")
	end tell
end tell