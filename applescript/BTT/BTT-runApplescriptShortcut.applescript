tell application "System Events"
   tell process "BetterTouchTool"
      tell scroll area 3 of splitter group 1 of window 1
         perform action "AXPress" of button "Compile / Test"
         perform action "AXPress" of button "Run Script"
      end tell
   end tell
   keystroke "s" using {command down}
end tell
