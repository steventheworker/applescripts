# command + s (toggles sidebar & lets screenhook know open/closed)
# tell application "Firefox Developer Edition" to activate
tell application "System Events"
	tell process "Firefox Developer Edition"
		tell (first window whose value of attribute "AXMain" is equal to true)
			if (title of it is equal to "Picture-in-Picture") then return "pip stop"
		end tell
		tell menu 1 of menu item "Sidebar" of menu 1 of menu bar item "View" of menu bar 1
			repeat with el in every UI element
				if (title of el is equal to "History" or title of el is equal to "Synced Tabs" or title of el is equal to "Bookmarks") then
					
				else
					tell el
						perform action "AXPress"
						set sidebarOpen to not (value of attribute "AXMenuItemMarkChar" is equal to missing value)
						tell application "screenhook" to updateFFSidebarShowing sidebarOpen
					end tell
					return
				end if
			end repeat
		end tell
	end tell
end tell

