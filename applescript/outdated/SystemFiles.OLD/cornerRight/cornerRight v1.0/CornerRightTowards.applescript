-- tell application "System Events"
-- 	key code 118
-- end tell
tell application "BetterTouchTool"
	set overlayState to get_number_variable "capsOverlayState"
	if overlayState is equal to 3.0 then
		set_number_variable "showDesktopThen" to 0.0
		set_number_variable "capsOverlayState" to 0.0
		return
	end if
	set_number_variable "capsOverlayState" to 3.0
end tell
