set Storage to do shell script "/opt/homebrew/bin/cliclick p"
tell application "BetterTouchTool"
	set overlayState to get_number_variable "TaskSwitcherOpen"
	if overlayState is not equal to 0.0 then
		set_number_variable "TaskSwitcherOpen" to 0.0
		return
	end if
	set_number_variable "TaskSwitcherOpen" to 1.0
end tell

tell application "System Events"
	do shell script "/opt/homebrew/bin/cliclick m:0,0"
	key code 160 # trigger f3
	do shell script "/opt/homebrew/bin/cliclick m:" & Storage
end tell
