set hkWin to null
tell application "iTerm"
   -- set a to create hotkey window with profile "Hotkey Window"
   repeat with win in windows
      if is hotkey window of win
         set hkWin to win
         exit repeat
      end if
   end repeat
   if (hkWin is equal to null)
      create hotkey window with profile "Hotkey Window"
   else
      toggle hotkey window hkWin
   end if
end tell
