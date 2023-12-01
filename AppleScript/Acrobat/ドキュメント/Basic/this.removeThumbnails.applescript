








tell application "Adobe Acrobat"
	tell page 1
		
		do script ("this.addThumbnails();")
		
	end tell
end tell


return





tell application "Adobe Acrobat"
	activate
	do script ("this.removeThumbnails();")
	do script ("this.removeThumbnails[0,2];")
	
	
	tell active doc
		set numAllPage to do script ("this.numPages;")
		set numNowPage to do script ("this.pageNum;")
		do script ("this.removeThumbnails({});")
		do script ("this.removeThumbnails({nStart:0,nEnd:1});")
		do script ("this.addThumbnails({nStart:0,nEnd:1});")
		do script ("this.addThumbnails({nStart:0,nEnd:1});")
	end tell
end tell
tell application "Adobe Acrobat"
	tell page numNowPage
		do script ("this.removeThumbnails();")
		do script ("this.removeThumbnails[0,2];")
		do script ("this.addThumbnails();")
		do script ("this.addThumbnails[0,2];")
	end tell
end tell