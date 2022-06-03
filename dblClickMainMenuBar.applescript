tell application "BetterTouchTool"
	set cornerRight to get_number_variable "cornerRight"
   if not (cornerRight is equal to 0.0)
      set_number_variable "cornerRight" to 0.0
   else
      set_number_variable "cornerRight" to 1.0
   end if
end tell

tell application "System Events"
	key code 103 # toggle show/hide desktop
end tell
