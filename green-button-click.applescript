# copy Windowsª max button behavior - (maximize / restore size --prevent going full screen except for finder previews / certain apps)
use framework "AppKit"
set monitors to ""
set H to 0
tell the current application
   set monitors to (its NSScreen's screens()'s valueForKey:"frame") as list # requires: use framework "AppKit"
   set H to NSHeight(its NSScreen's mainScreen's frame) # primary screen height
end tell

tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)
set focusedWIndex to 1

tell application "System Events"
   tell process tarAppPName
      set x to 1
      repeat with w in windows
         if value of attribute "AXMain" of w is equal to true -- if focused of w is equal to true
            set focusedWIndex to x
            exit repeat
         end if
         set x to (x + 1)
      end repeat
      set tarWin to window focusedWIndex
      set isFullScreen to value of attribute "AXFullScreen" of tarWin

      if isFullScreen or tarAppID is equal to "com.apple.finder" or tarAppID is equal to "com.apple.preview"
         tell application "BetterTouchTool" to trigger_named "default green button" # default
      else
         set alreadyFullWH to false
         set menuHeight to 0
         set dockWidth to 0
         set dockHeight to 0
         repeat with m in monitors
            set xy to item 1 of m
            set wh to item 2 of m
            set fullWH to {(item 1 of wh) - dockWidth, (item 2 of wh) - menuHeight - dockHeight} # dock/menu only taken into account when autoh
            set zeroPtWithDockAndMenu to {(item 1 of xy) + dockWidth, (item 2 of xy) + menuHeight}
            set pos to position of tarWin
            if not(item 2 of xy is equal to 0) then set item 2 of pos to (H - item 2 of wh) - item 2 of pos # carbonPoint/CGPpoint/some sort of conversion
            log {zeroPtWithDockAndMenu, "  ÇÇÇÈÈÈ  ", pos}
            if (size of tarWin is equal to fullWH and pos is equal to zeroPtWithDockAndMenu)
               set alreadyFullWH to true
               exit repeat
            end if
         end repeat

         if alreadyFullWH
            key code 51 using {control down, option down} # (delete) --restore size/position (rectangle shortcut)
            return "restored"
         else
            key code 36 using {control down, option down, command down} # (enter) --maximize window (rectangle shortcut)
            return "maximized"
         end if
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
