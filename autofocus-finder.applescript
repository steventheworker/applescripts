-- delay 2
tell application "System Events"
	tell process "Finder"
      tell group 3 of toolbar 1 of window 1
         if (count of (every button) > 0)
            perform action "AXPress" of button 1
         else # button DNE
            set focused of text field 1 to true
         end if
      end tell
   end tell
end tell
