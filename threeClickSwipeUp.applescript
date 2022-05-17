-- tell application "System Events"
-- 	key code 48 using {command down}
-- 	delay 0.334
-- 	key code 49
-- end tell
tell application "System Events"
	tell application "AltTab" to show
	delay 0.134
	key code 124 # right
	delay 0.2
	key code 49 #space
end tell
