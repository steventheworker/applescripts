tell application "BetterTouchTool"
	set cornerRight to get_number_variable "cornerRight"
   if cornerRight is equal to 2.0 or cornerRight is equal to 1.0 or cornerRight is equal to 3.0 then return
   tell application "System Events" to key code 103
end tell
