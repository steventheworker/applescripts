
tell application "Preview" to activate
tell application "System Events"
   tell process "Preview"
      tell window 1
         tell group 3 of toolbar 1
            set input to text field 1
            -- click input
            set focused of input to true
         end tell
      end tell
   end tell
end tell
