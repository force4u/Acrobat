set strWriteJs to ("console.show();\nconsole.clear();\nconsole.println(\"\");") as text

set aliasDesktopDirPath to (path to desktop folder from user domain) as alias
set strDesktopDirPath to (POSIX path of aliasDesktopDirPath) as text
set strJsFilePath to (strDesktopDirPath & "open_console.js") as text
#set aliasJsFilePath to (POSIX file strJsFilePath) as «class furl»

tell application "Finder"
	try
		make new file at aliasDesktopDirPath with properties {name:"open_console.js"}
	end try
end tell
set aliasJsFilePath to (POSIX file strJsFilePath) as alias


#WriteFile 
write strWriteJs to aliasJsFilePath starting at eof
#or
#write strWriteJs to strJsFilePath starting at eof

#ReadFile 
set strReadJS to read aliasJsFilePath
#or
#set strReadJS to read strJsFilePath

tell application "Adobe Acrobat Reader"
	activate
	do script strReadJS
end tell
