tell application "Mail" to activate
tell application "System Events"
   tell process "Mail"
      tell last group of toolbar 1 of window 1
         set btns to (every button whose description is equal to "Search")
         if count of btns > 0
            click item 1 of btns
         else
            set focused of text field 1 to true
         end if
      end tell
   end tell
end tell
