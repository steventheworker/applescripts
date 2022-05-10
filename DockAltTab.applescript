#test - (unused code) to see if Custom AltTab project is scriptable
tell application "System Events" to tell process "AltTab"
    # objective:   show AltTab for a specific program only


    #show AltTab
	click menu bar item 1 of menu bar 2 # click menu icon (show submenu options)
	click menu item "Show" of menu 1 of menu bar item 1 of menu bar 2

	delay 2

    #hide AltTab
	click menu bar item 1 of menu bar 2 # click menu icon (show submenu options)
	click menu item "DockAltTab'd" of menu 1 of menu bar item 1 of menu bar 2
end tell
