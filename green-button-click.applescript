tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)
set focusedWIndex to 1

tell application "System Events"
   tell process tarAppPName
      try # get the active window (helps w/ Firefox (Picture-in-Picture) / Floating)
         set x to 1
         repeat with w in windows
            if value of attribute "AXMain" of w is equal to true -- if focused of w is equal to true
               set focusedWIndex to x
               exit repeat
            end if
            set x to (x + 1)
         end repeat
      end try
      set tarWin to window focusedWIndex
      set isFullScreen to value of attribute "AXFullScreen" of tarWin
      if isFullScreen or tarAppID is equal to "com.apple.finder" or tarAppID is equal to "com.apple.preview"
         tell application "BetterTouchTool" to trigger_named "default green button"
      else
         key code 36 using {control down, option down, command down} # full size rectangle shortcut
      end if
   end tell
end tell

# helper fn's
on getPName(axTitle) # process name from axTitle (eg:   tell process getPName("Visual Studio Code")  =>  tell process "Code")
	#todo: find all exceptions: (apps whose app name !== process name (examples below))
	if axTitle is equal to "Alfred 4" or axTitle is equal to "Alfred 5" then return "Alfred"
	if axTitle is equal to "Visual Studio Code" then return "Code"
	if axTitle is equal to "iTerm" then return "iTerm2"
	if axTitle is equal to "PyCharm CE" then return "PyCharm"
	if axTitle is equal to "Adobe Illustrator 2021" then return "Adobe Illustrator"
	if axTitle is equal to "Adobe Photoshop 2021" then return "Photoshop"
	if axTitle is equal to "Adobe Premiere Pro 2021" then return "Premiere Pro"
	return axTitle
end getPName
