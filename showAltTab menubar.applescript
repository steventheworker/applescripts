tell application "BetterTouchTool"
	set overlayState to get_number_variable "AltTabSwitcherOpen"
	if overlayState is equal to 0.0 then set_number_variable "AltTabSwitcherOpen" to 1.0
	if overlayState is equal to 1.0 then set_number_variable "AltTabSwitcherOpen" to 0.0
end tell

tell application "System Events"
	#hide
	if overlayState is equal to 1.0 then
		key code 53
		return
	end if

	#begin show
	keystroke "b" using {command down, option down, control down, shift down} #show hidden items
	ignoring application responses
		tell process "AltTab"
			click menu bar item 1 of menu bar 2
		end tell
	end ignoring
end tell

#end show
delay 0.0333
do shell script "killall 'System Events'"

tell application "System Events"
	# select second menu option
	key code 125 #down
	key code 125 #down
	key code 49 #space

	# move back a preview
	key code 123
end tell
