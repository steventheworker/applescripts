-- tell application "Podcasts" to activate
tell application "System Events"
   tell process "Podcasts"
      set els to UI elements of menu 1 of menu item "Playback Speed" of menu 1 of menu bar item "Controls" of menu bar 1
      set i to 1 # item i of els
      set elIndex to -1
      repeat with el in els
         set checked to (value of attribute "AXMenuItemMarkChar" of el)
         if not (checked is equal to missing value) then set elIndex to i
         set i to (i + 1)
      end repeat
      if elIndex is equal to -1 then set elIndex to 5 # weird Ventura bug, 1.75x speed checkbox (5) is uncheckable
      if elIndex >= (count of els) then return
      -- return elIndex
      click item (elIndex + 1) of els
   end tell
end tell
