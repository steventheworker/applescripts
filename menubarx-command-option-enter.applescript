delay 0.666 # wait to get hands off modifier keys
tell application "MenubarX" to activate
tell application "System Events"
   tell process "MenubarX"
      set focusedWindow to value of attribute "AXFocusedWindow"
		set address to value of every text field of focusedWindow
	end tell
	delay 4.2
	# open newest (automatically opened by menubarx now)
	keystroke "l" using {command down}
	keystroke address
   key code 36 # enter
end tell
