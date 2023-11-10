#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
(*
Title
Author
Authors  (Acrobat 9.0)
Subject
Keywords
Creator
Producer
CreationDate
ModDate
Trapped
*)
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
		do script ("this.info.Author = (\"\");")
		do script ("this.info.Title = (\"\");")
		do script ("this.info.Author = (\"\");")
	##	do script ("this.info.Authors = (\"\");") Acrobat9専用
		do script ("this.info.Subject = (\"\");")
		do script ("this.info.Keywords = (\"\");")
		do script ("this.info.Creator = (\"\");")
		do script ("this.info.Producer = (\"\");")
		do script ("this.info.CreationDate = (\"\");")
		do script ("this.info.ModDate = (\"\");")
		do script ("this.info.Trapped = (\"\");")
		
	end tell
end tell