tell application "Firefox Developer Edition" to activate
tell application "System Events"
	tell process "Firefox Developer Edition"
		set view_toolbars_bookmarks to menu 1 of menu item "Bookmarks Toolbar" of menu 1 of menu item "Toolbars" of menu 1 of menu bar item "View" of menu bar 1
      tell application "Firefox Developer Edition" to set winTitle to name of first window whose miniaturizable is equal to true # first non-pip window
      if not(winTitle is equal to "Mozilla Firefox")
         set checked_1 to not((value of attribute "AXMenuItemMarkChar" of menu item 1 of view_toolbars_bookmarks) is equal to missing value)
         if checked_1
            click menu item 2 of view_toolbars_bookmarks
         else
            click menu item 1 of view_toolbars_bookmarks
         end if
      else
         set checked_2 to not((value of attribute "AXMenuItemMarkChar" of menu item 2 of view_toolbars_bookmarks) is equal to missing value)
         if checked_2 then
            click menu item 3 of view_toolbars_bookmarks
         else
            click menu item 2 of view_toolbars_bookmarks
         end if
      end if
	end tell
end tell
