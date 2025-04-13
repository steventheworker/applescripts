tell application "BetterTouchTool"	
	set overlayState to get_number_variable "capsOverlayState"
	set showDesktopThen to get_number_variable "showDesktopThen"

  if overlayState is equal to 3.0 then
    tell application "System Events"
      key code 118
    end tell
    set_number_variable "capsOverlayState" to 0.0
    set_number_variable "showDesktopThen" to 0.0
    return
  end if
  
  if showDesktopThen is not equal to 0.0 then
    set_number_variable "showDesktopThen" to 0.0
    set_number_variable "capsOverlayState" to 0.0
  end if
end tell

return overlayState