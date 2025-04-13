# toggle shortcut2
tell application "BetterTouchTool"
	set overlayState to get_number_variable "AltTabSwitcherOpen"
	if overlayState is equal to 0.0 then set_number_variable "AltTabSwitcherOpen" to 1.0
	if overlayState is equal to 1.0 then set_number_variable "AltTabSwitcherOpen" to 0.0
	set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
end tell

tell application "AltTab"
	if overlayState is equal to 1.0
		hide
	else
		showApp appBID tarAppID
	end if
end tell