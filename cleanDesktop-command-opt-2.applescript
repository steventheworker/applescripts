# gives an extra dock icon row (if have autohide off)
tell application "System Events"
   set autohide_status to autohide of dock preferences
   tell process "Finder" to set isDesktopFocused to (focused of scroll area 1) # scroll area 1 === desktop "window"
   if (not(isDesktopFocused))
      tell process "Finder"
         #  sort by (kind)  --the only folder that runs "clean up" is the desktop, otherwise: sort by => kind
         tell menu 1 of menu item "Sort By" of menu 1 of menu bar item "View" of menu bar 1
            click menu item "Kind"
         end tell
      end tell
   end if

   # autohide dock + delays (if main desktop window is in focus)
   if isDesktopFocused is equal to true and autohide_status is equal to false
      set autohide of dock preferences to true
      delay 1.2 #give time for hide to be noticed by clean fn
   end if
   tell process "Finder"
      #  clean up (by kind)
      tell menu 1 of menu item "Clean Up By" of menu 1 of menu bar item "View" of menu bar 1
         click menu item "Kind"
      end tell

      # undo autohide (if necessary)
   end tell
   if isDesktopFocused is equal to true and autohide_status is equal to false then set autohide of dock preferences to false
end tell


