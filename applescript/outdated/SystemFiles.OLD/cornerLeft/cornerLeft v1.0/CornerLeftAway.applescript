tell application "BetterTouchTool"
	-- set_number_variable "capsOverlayState" to 0.0
	set overlayState to get_number_variable "capsOverlayState"
	set showDesktopThen to get_number_variable "showDesktopThen"
	if showDesktopThen is equal to 2.0 then
		return
	end if
	set_number_variable "showDesktopThen" to 0.0
end tell

