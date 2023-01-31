delay 0.666 # wait to get hands off modifier keys
-- set the_clipboard to the clipboard
-- set _clipboard to (the_clipboard as text)
tell application "MenubarX" to activate
tell application "System Events"
   tell process "MenubarX"
		-- keystroke "x" using {option down}
      set focusedWindow to value of attribute "AXFocusedWindow"
		set address to value of every text field of focusedWindow
	end tell
	-- keystroke "l" using {command down}
	-- keystroke "c" using {command down}
	keystroke "n" using {command down}
	delay 4.2
	# click newest 
	keystroke "l" using {command down}
	-- keystroke "v" using {command down}
	keystroke address
   key code 36 # enter
end tell
-- set the clipboard to the_clipboard
