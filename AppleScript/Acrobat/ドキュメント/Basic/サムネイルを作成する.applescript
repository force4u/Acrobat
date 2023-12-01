tell application "Adobe Acrobat"
	activate
	try
		set numAllPage to do script ("this.numPages;")
		set numNowPage to do script ("this.pageNum;")
		set numJsNowPage to (numNowPage - 1)
	on error
		display alert "エラー:pdfを開いていません" buttons {"OK", "キャンセル"} default button "OK" as informational giving up after 10
		return
	end try
	tell active doc
		create thumbs
	end tell
end tell