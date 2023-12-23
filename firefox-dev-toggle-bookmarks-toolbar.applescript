tell application "Firefox Developer Edition"
   activate
   set winTitle to name of first window whose miniaturizable is equal to true # first non-pip window
end tell
tell application "System Events"
	tell process "Firefox Developer Edition"
      tell menu 1 of menu item "Bookmarks Toolbar" of menu 1 of menu item "Toolbars" of menu 1 of menu bar item "View" of menu bar 1
         if not(winTitle is equal to "Mozilla Firefox")
            set checked_1 to not((value of attribute "AXMenuItemMarkChar" of menu item 1) is equal to missing value)
            if checked_1
               click menu item 2
            else
               click menu item 1
            end if
         else
            set checked_2 to not((value of attribute "AXMenuItemMarkChar" of menu item 2) is equal to missing value)
            if checked_2 then
               click menu item 3
            else
               click menu item 2
            end if
         end if
      end tell
   end tell
end tell
