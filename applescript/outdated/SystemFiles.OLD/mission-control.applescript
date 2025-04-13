#capsOverlay.scpt helper
tell application "BetterTouchTool"
	set state to get_number_variable "capsOverlayState"
	if state is missing value then return
	if state is equal to 0.0 then set_number_variable "capsOverlayState" to 2.0
	if state is equal to 1.0 then set_number_variable "capsOverlayState" to 2.0
	if state is equal to 2.0 then set_number_variable "capsOverlayState" to 0.0
end tell
	return state
