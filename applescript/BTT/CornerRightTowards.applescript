tell application "BetterTouchTool"
	set cornerRight to get_number_variable "cornerRight"
   if cornerRight is equal to 3.0 then set cornerRight to 0.0
   if cornerRight is equal to 1.0
      set cornerRight to 2.0
      trigger_named "showDesktop"
   end if
   if cornerRight is equal to 2.0
      set_number_variable "cornerRight" to 3.0
      return
   end if
   set_number_variable "cornerRight" to 0.0
   trigger_named "showDesktop"
end tell
