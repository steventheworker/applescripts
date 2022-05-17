-- set Storage to do shell script "/opt/homebrew/bin/cliclick p"
-- tell application "BetterTouchTool"
-- 	set overlayState to get_number_variable "TaskSwitcherOpen"
-- 	if overlayState is not equal to 0.0 then
-- 		set_number_variable "TaskSwitcherOpen" to 0.0
-- 		return
-- 	end if
-- 	set_number_variable "TaskSwitcherOpen" to 1.0
-- end tell

-- tell application "System Events"
-- 	do shell script "/opt/homebrew/bin/cliclick m:0,0"
-- 	key code 160 # trigger f3
-- 	do shell script "/opt/homebrew/bin/cliclick m:" & Storage
-- end tell

use framework "Foundation"

# get oldLocation (ASOC - applescipt objective-c)
set oldLoc to current application's NSEvent's mouseLocation()
set screenSize to (current application's NSScreen's mainScreen's valueForKey:"frame") as list
set H to item 2 of item 2 of screenSize
set oldLoc's y to (H - (oldLoc's y))


# mouse to 0,0
set cursorPoint to current application's NSMakePoint(0, 0)
set runError to current application's CGDisplayMoveCursorToPoint(current application's CGMainDisplayID(), cursorPoint)

# open mission control
tell application "System Events" to key code 99

delay 0.01

# mouse to oldLocation
set cursorPoint to current application's NSMakePoint(oldLoc's x, oldLoc's y)
set runError to current application's CGDisplayMoveCursorToPoint(current application's CGMainDisplayID(), cursorPoint)

tell application "BetterTouchTool"
	set overlayState to get_number_variable "TaskSwitcherOpen"
	if overlayState is not equal to 0.0 then
		set_number_variable "TaskSwitcherOpen" to 0.0
		return
	end if
	set_number_variable "TaskSwitcherOpen" to 1.0
end tell
