tell application "BetterTouchTool"
	set state to get_number_variable "commitTopRight"
   if state is equal to 2.0 then
      set_number_variable "commitTopRight" to 0.0
      return
   end if
   set_number_variable "commitTopRight" to 1.0
   delay 0.666
	set state to get_number_variable "commitTopRight"
   if state is equal to 0.0 then return
	tell application "System Events"
		key code 103
	end tell
   set_number_variable "commitTopRight" to 0.0
end tell
