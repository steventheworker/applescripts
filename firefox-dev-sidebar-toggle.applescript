# command + s (toggles sidebar & lets screenhook know open/closed)
tell application "System Events"
   tell process "Firefox Developer Edition"
      set win to first window whose value of attribute "AXMain" is equal to true
      if (title of win is equal to "Picture-in-Picture") then return "pip stop"
      tell menu 1 of menu item "Sidebar" of menu 1 of menu bar item "View" of menu bar 1
         tell last menu item
            perform action "AXPress"
            set sidebarOpen to not(value of attribute "AXMenuItemMarkChar" is equal to missing value)
            tell application "screenhook" to updateFFSidebarShowing sidebarOpen
         end tell
      end tell
   end tell
end tell
