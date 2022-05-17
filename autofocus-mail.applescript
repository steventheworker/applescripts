tell application "Mail" to activate
tell application "System Events"
   tell process "Mail"
      -- UI elements of group 4 of toolbar 1 of window 1
      set focused of text field 1 of group 4 of toolbar 1 of window 1 to true
   end tell
end tell
