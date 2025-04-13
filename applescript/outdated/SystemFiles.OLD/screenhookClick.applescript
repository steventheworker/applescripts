-- Screenhook script (runs on click)
tell application "BetterTouchTool"	
	set overlayState to get_number_variable "capsOverlayState"
	set showDesktopThen to get_number_variable "showDesktopThen"
  if showDesktopThen is not equal to 0.0 or overlayState is equal to 1.0 then
    set_number_variable "showDesktopThen" to 0.0
    set_number_variable "capsOverlayState" to 0.0
  end if
  set_number_variable "TaskSwitcherOpen" to 0.0
  set_number_variable "AltTabSwitcherOpen" to 0.0
end tell
