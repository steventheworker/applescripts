# toggle shortcut1
-- tell application "BetterTouchTool"
-- 	set overlayState to get_number_variable "AltTabSwitcherOpen"
-- 	if overlayState is equal to 0.0 then set_number_variable "AltTabSwitcherOpen" to 1.0
-- 	if overlayState is equal to 1.0 then set_number_variable "AltTabSwitcherOpen" to 0.0
-- end tell

-- tell application "System Events"
-- 	#hide
-- 	if overlayState is equal to 1.0 then
-- 		key code 53
-- 		return
-- 	end if
	
-- 	#show
-- 	key code 48 using {command down}
-- 	# move back a preview
-- 	delay 0.02
-- 	key code 123
-- end tell
tell application "BetterTouchTool"
	set overlayState to get_number_variable "AltTabSwitcherOpen"
	if overlayState is equal to 0.0 then set_number_variable "AltTabSwitcherOpen" to 1.0
	if overlayState is equal to 1.0 then set_number_variable "AltTabSwitcherOpen" to 0.0
end tell

tell application "AltTab"
	if overlayState is equal to 1.0
		hide
	else
		show
	end if
end tell