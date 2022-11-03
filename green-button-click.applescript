# copy Windowsª max button behavior - (maximize / restore size --prevent going full screen except for finder previews / certain apps)
use framework "AppKit"
tell the current application
   set monitors to (its NSScreen's screens()'s valueForKey:"frame") as list # requires: use framework "AppKit"
   set H to NSHeight(its NSScreen's mainScreen's frame) # primary screen height
	tell [] & its NSEvent's mouseLocation
		set X to (item 1)
		set Y to H - (item 2)
	end tell
end tell

tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)
set focusedWIndex to 1

tell application "System Events"
	tell dock preferences
      set dockautohide to autohide
      set menuautohide to autohide menu bar
      set dockPos to screen edge
   end tell
	tell application process "Dock"
		set {dockWidth, dockHeight} to the size of list 1
      set {dockX, dockY} to the position of list 1
      # todo: outer margin is 2px or 1px depending on monitor / dockPos...???
      if (dockPos is equal to bottom) then set dockHeight to dockHeight + 1 + 5 # dockHeight has marginTop (2px) and marginBottom (5px) when autohide is off
      if (not(dockPos is equal to bottom)) then set dockWidth to dockWidth + 1 + 5 # dockWidth has marginLeft/Right of (5px) and marginLeft/Right of (2px)
   end tell
   tell process tarAppPName
      set i to 1
      repeat with w in windows
         if value of attribute "AXMain" of w is equal to true -- if focused of w is equal to true
            set focusedWIndex to i
            exit repeat
         end if
         set i to (i + 1)
      end repeat
      set tarWin to window focusedWIndex
      set isFullScreen to value of attribute "AXFullScreen" of tarWin

      if isFullScreen or tarAppID is equal to "com.apple.finder" or tarAppID is equal to "com.apple.preview"
         tell application "BetterTouchTool" to trigger_named "default green button" # default
      else
         set alreadyFullWH to false
         # calculate effective UI sizes
         set menuSize to (size of menu bar 1)
         set menuHeight to item 2 of menuSize
         set dockOnMonitorUnderCursor to false
         repeat with m in monitors # ??? dockOnMonitorUnderCursor
            set xy to item 1 of m
            set wh to item 2 of m
            set offsetY to (H - item 2 of wh)
            if (X >= item 1 of xy and X <= item 1 of xy + item 1 of wh)   and   (Y >= -(item 2 of xy) and Y <= item 2 of wh + offsetY) # mouse on this monitor
               if (dockX >= item 1 of xy and dockX <= item 1 of xy + item 1 of wh and dockY >= item 2 of xy and dockY <= item 2 of xy + item 2 of wh) # dock is on monitor
                  set dockOnMonitorUnderCursor to true
               end if
            end if
         end repeat
         if dockautohide or not(dockOnMonitorUnderCursor)
            set dockWidth to 0
            set dockHeight to 0
         end if
         if menuautohide then set menuHeight to 0
         
         # see if tarWin already fullWH on a monitor
         repeat with m in monitors
            set xy to item 1 of m
            set wh to item 2 of m
            set fullWH to {item 1 of wh, item 2 of wh}
            set zeroPt to {item 1 of xy, item 2 of xy}
            if dockPos is equal to bottom
               set item 2 of fullWH to item 2 of fullWH - menuHeight - dockHeight
               set item 2 of zeroPt to item 2 of zeroPt + menuHeight
            end if
            -- if (dockPos is equal to left and onLeftMost) or (dockPos is equal to right and onRightMost)
               -- set fullWH to {(item 1 of wh) - dockWidth, (item 2 of wh) - menuHeight - dockHeight}
            -- else
            --    set fullWH to {(item 1 of wh), (item 2 of wh) - menuHeight - dockHeight}
            -- end if
            -- if dockPos is equal to left and onLeftMost then set zeroPt to {(item 1 of xy) + dockWidth, (item 2 of xy) + menuHeight}
            -- if dockPos is equal to right then set zeroPt to {(item 1 of xy), (item 2 of xy) + menuHeight}
            -- if (dockPos is equal to bottom) # dock could be @ bottom of any monitor
            --    set fullWH to {(item 1 of wh), (item 2 of wh) - menuHeight - dockHeight}
            --    set zeroPt to {(item 1 of xy), (item 2 of xy) + menuHeight}
            -- end if
            set pos to position of tarWin
            set s to size of tarWin
            if not(item 2 of xy is equal to 0) then set item 2 of pos to (H - item 2 of wh) - item 2 of pos # carbonPoint/CGPpoint/some sort of conversion
            log "x:" & (item 1 of pos) & " y:" & (item 2 of pos) & "\t~~ (" & (item 1 of zeroPt) & ", " & (item 2 of zeroPt) & ")  \t\t\t\t&&\t\t (win) " & (item 1 of s) & "x" & (item 2 of s) & " ~~ (\"full\") " & (item 1 of fullWH) & "x" & (item 2 of fullWH)
            if (my compareMagnitude(item 1 of s - item 1 of fullWH, 2) and my compareMagnitude(item 2 of s - item 2 of fullWH, 2)) and (my compareMagnitude(item 1 of pos - item 1 of zeroPt, 2) and my compareMagnitude(item 2 of pos - item 2 of zeroPt, 2))
               set alreadyFullWH to true
               exit repeat
            end if
         end repeat

         if alreadyFullWH
            key code 51 using {control down, option down} # (delete) --restore size/position (rectangle shortcut)
            return "restored window size & position"
         else
            key code 36 using {control down, option down, command down} # (enter) --maximize window (rectangle shortcut)
            return "maximized & zeroed window"
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

on compareMagnitude(val, compareVal) # checks if absolute val <= compareVal
	if (val < 0) then set val to val * -1
   return (val <= compareVal)
end compareMagnitude
