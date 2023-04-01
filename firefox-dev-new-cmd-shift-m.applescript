tell application "Firefox Developer Edition"
	open ":"
	activate
end tell
tell application "System Events"
	tell process "Firefox Developer Edition"
		tell menu 1 of menu item "New Container Tab" of menu 1 of menu bar item "File" of menu bar 1
			click menu item 1
		end tell
	end tell
end tell

tell application "Firefox Developer Edition"
	-- activate
end tell

tell application "System Events"
	tell process "Firefox Developer Edition"
		key code 48 using {control down}
		keystroke "w" using {command down}
	end tell
end tell
