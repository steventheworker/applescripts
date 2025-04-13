# BTT sends fn+q and cmd+n
# now close the old quicknote window
tell application "System Events"
   tell process "Notes"
      set main to first window whose value of attribute "AXMain" equals true
      if main equals window 1
         click button 1 of window 2
      else
         click button 1 of window 1
      end if
   end tell
end tell
-- tell application "Notes"
--    --your code
-- end tell
