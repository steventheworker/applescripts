tell application "BetterTouchTool"
	-- set_number_variable "capsOverlayState" to 0.0
	set overlayState to get_number_variable "capsOverlayState"
	set showDesktopThen to get_number_variable "showDesktopThen"
	-- if showDesktopThen is equal to 2.0 then
	-- 	return
	-- end if
  if overlayState is equal to 0.0 then 
    set_number_variable "capsOverlayState" to 3.0
    set_number_variable "showDesktopThen" to 2.0
    return
  end if
  if overlayState is equal to 3.0 then 
    set_number_variable "showDesktopThen" to 0.0
    return
  end if
  set_number_variable  "showDesktopThen" to 0.0
  set_number_variable "capsOverlayState" to 3.0
end tell

