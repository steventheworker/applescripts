tell application "Activity Monitor" to activate
tell application "System Events"
	tell process "Activity Monitor"
		tell window 1
			tell toolbar 1
				set lastGroup to count of every group
				tell group lastGroup
					set focused of text field 1 to true
				end tell
			end tell
		end tell
	end tell
end tell
