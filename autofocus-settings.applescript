# press / to autofocus the search textinput
tell application "System Events"
	tell process "System Settings"
		tell window 1
			set focused of text field 1 of group 1 of splitter group 1 of group 1 to true
		end tell
	end tell
end tell
