tell application "System Events"
   tell process "Podcasts"
      set els to UI elements of menu 1 of menu item "Playback Speed" of menu 1 of menu bar item "Controls" of menu bar 1
      set i to 1 # item i of els
      set elIndex to 0
      repeat with el in els
         set checked to (value of attribute "AXMenuItemMarkChar" of el)
         if not (checked is equal to missing value) then set elIndex to i
         set i to (i + 1)
      end repeat
      if elIndex <= 1 then return
      click item (elIndex - 1) of els
   end tell
end tell
