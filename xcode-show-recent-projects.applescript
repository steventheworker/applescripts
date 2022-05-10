#click File -> click "Open Recent"

tell application "System Events"
	tell application "Xcode" to activate
	delay 0.333 # allow enough time to activate app
	key down 63 # fn down
	delay 0.333
	key code 100 using {control down} # Ctrl+F8 (reveal/navigate menu bar w/ keyboard) (or F2)
	key up 63 #fn up
	tell process "Xcode"
		click menu bar item "File" of menu bar 1
		click menu item "Open Recent" of menu 1 of menu bar item "File" of menu bar 1
	end tell
end tell
