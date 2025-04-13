set urls to ""
tell application "Safari"
	repeat with t in every tab of window 1
		set urls to (urls & (URL of t) & "
")
	end repeat
end tell

display dialog urls