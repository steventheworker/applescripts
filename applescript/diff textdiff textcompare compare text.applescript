on smallestScreen()
	set smallest to {}
	repeat with p in paragraphs of ¬
		(do shell script "system_profiler SPDisplaysDataType | awk '/Resolution:/{ printf \"%s %s\\n\", $2, $4 }'")
		set w to word 1 of p as number
		set h to word 2 of p as number
		if (count of smallest) is equal to 0 then set smallest to {w, h}
		if w * h < (item 1 of smallest) * (item 2 of smallest) then
			set smallest to {w, h}
		end if
	end repeat
	if (count of smallest) is equal to 0 then return {0, 0}
	return smallest
end smallestScreen

on makefile(fileName, txt)
	set folderPath to path to desktop
	set fileHandle to open for access file ((folderPath as text) & fileName) with write permission
	write txt to fileHandle
	close access fileHandle
	return ((POSIX path of folderPath) & fileName)
end makefile

on trim(txt)
	set oldTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ""
	set txt to words of txt as string
	set AppleScript's text item delimiters to oldTIDs
	return txt
end trim

set txt1 to text returned of (display dialog "txt1 (drag file OR paste):" default answer "")
if txt1 is equal to "" or (my trim(txt1) is equal to "") then return
set txt2 to text returned of (display dialog "txt2 (drag file OR paste):" default answer "")
if txt2 is equal to "" or (my trim(txt2) is equal to "") then return

set param1 to quoted form of txt1 # "\"" & txt1 & "\""
set param2 to quoted form of txt2 # "\"" & txt2 & "\""

set isParam1FilePath to (do shell script "[ -f " & param1 & " ] && echo 'true' || echo 'false'") is equal to "true"
set isParam2FilePath to (do shell script "[ -f " & param2 & " ] && echo 'true' || echo 'false'") is equal to "true"
# diff --side-by-side <(echo "text1") <(echo "text2")
if not isParam1FilePath then
	# set param1 to "<(echo " & param1 & ")"
	set param1 to my makefile("textdiff-temp-1.txt", txt1)
end if
if not isParam2FilePath then
	# set param2 to "<(echo " & param2 & ")"
	set param2 to my makefile("textdiff-temp-2.txt", txt2)
end if

tell application "iTerm"
	set newWindow to (create window with default profile)
	tell current session of newWindow
		write text "diff --side-by-side " & param1 & " " & param2 # without newline
	end tell
end tell

delay 1

tell application "iTerm" to activate
tell application "System Events"
	# key code 36 using {command down, option down, control down}
	tell process "iTerm2"
		set position of front window to {0, 0}
		set screen to my smallestScreen()
		set size of front window to {item 1 of screen, item 2 of screen} # {screen width, screen height}
	end tell
end tell

if not isParam1FilePath then do shell script "rm " & param1
if not isParam2FilePath then do shell script "rm " & param2
# cannot send keystrokes bug, don't fullsize the terminal
