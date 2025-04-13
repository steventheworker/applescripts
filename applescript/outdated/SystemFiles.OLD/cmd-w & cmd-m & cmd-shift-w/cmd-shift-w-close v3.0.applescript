# red button fn (close window)   -   this whole script is a subfeature of cmd-w-close (close tab OR window (if 0 tabs))
# get active app
tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)

# switch to next window via AltTab (cmd+tab)
tell application "System Events"
	# check if weird window that dissapears on switch (eg: "Colors" ((cmd+shift+c) in many apps like Stickies/Script Editor)) & for dialog windows
	tell process tarAppPName
		if subrole of window 1 is equal to "AXFloatingWindow" or subrole of window 1 is equal to "AXDialog" or subrole of window 1 is equal to "Quick Look"
			tell application "BetterTouchTool" to trigger_named "commandW"
			return "floating window closed (with cycling)"
		end if
	end tell
	key code 48 using {command down}
	delay 0.1
	key code 55 # make sure AltTab is closed... CMD (55 works) / SPACE (49 works) / ESC (53 - doesn't work due to BTT mapping)
	delay 0.1
end tell

# get new active app
tell application "BetterTouchTool" to set nextAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set nextApp to name of application id nextAppID

# close by app
tell application tarApp
   try
      set winCount to (count of windows)
      if winCount is equal to 0 then return "0 windows"
		set tarWin to window 1
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		close tarWin
		return {tarApp, nextApp, "application"}
   end try
end tell

# close by process
tell application "System Events"
	tell process tarAppPName
      set winCount to (count of windows)
      if winCount is equal to 0 then return "0 windows"
		set tarWin to window 1
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		try
			close tarWin
			return {tarApp, nextApp, "process1"}
		end try
      click (tarWin's buttons whose subrole is "AXCloseButton")
		return {tarApp, nextApp, "process2"}
	end tell
end tell






# helper fn's
on getPName(axTitle) # process name from axTitle (eg:   tell process getPName("Visual Studio Code")  =>  tell process "Code")
	#todo: find all exceptions: (apps whose app name !== process name (examples below))
	if axTitle is equal to "Visual Studio Code" then return "Code"
	if axTitle is equal to "iTerm" then return "iTerm2"
	if axTitle is equal to "PyCharm CE" then return "PyCharm"
	if axTitle is equal to "Adobe Illustrator 2021" then return "Illustrator"
	if axTitle is equal to "Adobe Photoshop 2021" then return "Photoshop"
	if axTitle is equal to "Adobe Premiere 2021" then return "Premiere"
	return axTitle
end getPName
