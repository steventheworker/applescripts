tell application "Safari" to activate
tell application "System Events"
	tell process "Safari"
		tell window "History"
			tell splitter group 1
				tell group 1 of tab group 1
					set focused of text field 1 to true
				end tell
			end tell
		end tell
	end tell
end tell
