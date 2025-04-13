set githubName to "steventheworker"
property lastEnteredValue : ""

on trim(txt)
	set oldTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ""
	set txt to words of txt as string
	set AppleScript's text item delimiters to oldTIDs
	return txt
end trim

set txt to text returned of (display dialog "repo name (empty uses the last selected repo)" default answer "")
if txt is equal to "" or (my trim(txt) is equal to "") then
	# set txt to "DockAltTab"
	tell application "BetterTouchTool"
		set lastEnteredValue to get_string_variable "lastEnteredValue"
	end tell
	
	if lastEnteredValue is not "" then
		set txt to lastEnteredValue
	else
		set txt to text returned of (display dialog "repo name (empty uses the last selected repo)" default answer "")
	end if
	
end if

-- Store current entered value to BetterTouchTool
tell application "BetterTouchTool"
	set_string_variable "lastEnteredValue" to txt
end tell
set out to do shell script "curl -s https://api.github.com/repos/" & githubName & "/" & txt & "/releases | egrep '\"name\"|\"updated_at\"|\"download_count\"'"
display dialog out
