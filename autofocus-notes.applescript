tell application "Notes" to activate
tell application "System Events"
   tell process "Notes"
      tell group 4 of toolbar 1 of window 1
         set focused of text field 1 to true
      end tell
   end tell
end tell
