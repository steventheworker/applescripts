# duplicate open tab

# config  #todo: use BTT to add systemfiles folder to path
set pathStr to "Macintosh HD:users:super:Desktop:important:SystemFiles:menubarx-new-and-focus.scpt"
set p to POSIX path of pathStr

delay 0.666 # wait to get hands off modifier keys
tell application "MenubarX" to activate
tell application "System Events"
   tell process "MenubarX"
      set focusedWindow to value of attribute "AXFocusedWindow"
		set address to value of every text field of focusedWindow
	end tell
	log run script p # equivalent to:  do shell script "osascript -e 'run script \"'/Users/super/Desktop/important/SystemFiles/menubarx-new-and-focus.applescript'\"'"
	delay 4.2
	# open newest (automatically opened by menubarx now)
	keystroke "l" using {command down}
	keystroke address
   key code 36 # enter
end tell
