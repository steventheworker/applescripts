tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
tell application "AltTab" to showApp appBID tarAppID
tell application "System Events"
	delay 0.134
	key code 124 # right
	delay 0.2
	-- key code 49 # space
	key code 36 # enter
end tell
