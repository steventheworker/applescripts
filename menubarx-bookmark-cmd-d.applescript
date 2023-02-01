
delay 2
set cliclick to "/opt/homebrew/bin/cliclick"
set Storage to do shell script "/opt/homebrew/bin/cliclick p"

set iconIndex to 1
tell application "System Events"
   tell process "MenubarX"
      keystroke "x" using {option down}
      delay 0.333
      set focusedWindow to value of attribute "AXFocusedWindow"
      set m to value of attribute "AXParent" of focusedWindow # menu holding "pop over"s and "menu bar item"
      -- perform action "AXPress" of (menu bar item (iconIndex) of m)
      set p to position of menu bar item (iconIndex) of m
      set x to item 1 of p
      set y to item 2 of p
      do shell script cliclick & " rc:" & x & "," & y & " m:" & Storage # AXShowMenu workaround (right click then move mouse to OG location)
   end tell
end tell
# figure out how to tell what "menu bar icon" is linked to what "pop over"