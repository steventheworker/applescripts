tell application "BetterTouchTool"
	set state1 to get_number_variable "showDesktopThen"
	if state1 is equal to missing value or state1 is equal to 0.0 then
		set state1 to 1.0
		set_number_variable "showDesktopThen" to 1.0
	end if

	if state1 is equal to 1.0 then delay 0.6

	set state2 to get_number_variable "showDesktopThen"
	tell application "System Events"
		if state2 is equal to 0.0 then return
		key code 99
	end tell
	if state2 is not equal to 2.0 then set_number_variable "showDesktopThen" to 2.0
	if state2 is equal to 2.0 then set_number_variable "showDesktopThen" to 1.0

	#capsOverlay.scpt helper (toggle values)
	set overlayState to get_number_variable "capsOverlayState"
	if overlayState is missing value then return
	if overlayState is equal to 0.0 then set_number_variable "capsOverlayState" to 2.0
	if overlayState is equal to 1.0 then set_number_variable "capsOverlayState" to 2.0
	if overlayState is equal to 2.0 then set_number_variable "capsOverlayState" to 0.0
	if overlayState is equal to 3.0 then set_number_variable "capsOverlayState" to 0.0
end tell
