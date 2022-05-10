tell application "Activity Monitor" to activate
tell application "System Events"
	tell process "Activity Monitor"
		tell window 1
			tell toolbar 1
				tell group 3
					set focused of text field 1 to true
				end tell
			end tell
		end tell
	end tell
end tell
