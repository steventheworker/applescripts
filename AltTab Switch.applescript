tell application "System Events" to tell process "AltTab"
	click menu bar item 1 of menu bar 2
	click menu item "Show" of menu 1 of menu bar item 1 of menu bar 2
end tell
tell application "System Events"
	key code 123
end tell

-- tell application "System Events"
-- 	key code 48 using {command down}
-- 	delay 0.008
-- 	key code 123
-- end tell
