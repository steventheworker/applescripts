property lastEnteredValue : ""
tell application "BetterTouchTool"
	set lastEnteredValue to get_string_variable "last_gpt_prompt"
	if lastEnteredValue is equal to missing value then set lastEnteredValue to ""
end tell

set txt to text returned of (display dialog "prompt:" default answer (lastEnteredValue)) # prompt
if txt is equal to "" or (my trim(txt) is equal to "") then return

on trim(txt)
	set oldTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ""
	set txt to words of txt as string
	set AppleScript's text item delimiters to oldTIDs
	return txt
end trim

tell application "iTerm"
	activate
	set newWindow to (create window with default profile)
	tell current session of newWindow
		write text ("sgpt \"" & quoted form of txt & "\"")
	end tell
end tell

-- Store new entered value to BetterTouchTool
tell application "BetterTouchTool"
	set_string_variable "last_gpt_prompt" to txt
end tell
