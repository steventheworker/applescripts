# get active app
tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)

set focusedWIndex to 1
tell application "System Events"
	tell process tarAppPName
		try # get the active window (helps w/ Firefox (Picture-in-Picture)
			set x to 1
			repeat with w in windows
				if value of attribute "AXMain" of w is equal to true or focused of w is equal to true
					set focusedWIndex to x
					exit repeat
				end if
				set x to (x + 1)
			end repeat
		end try
		set OGWindow to window focusedWIndex
	end tell
end tell

# get new active app
tell application "AltTab" to trigger
delay 0.05 # let app fully activate
tell application "BetterTouchTool" to set nextAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set nextApp to name of application id nextAppID


# minimize (by process)
set wIndex to focusedWIndex # reset  --in case it was incremented (by app)
set newFocusedWIndex to 1
tell application "System Events"
	tell process tarAppPName
		try # get new active window (helps w/ Firefox (Picture-in-Picture)
			set x to 1
			repeat with w in windows
				if value of attribute "AXMain" of w is equal to true or focused of w is equal to true
					set newFocusedWIndex to x
					exit repeat
				end if
				set x to (x + 1)
			end repeat
		end try

      set winCount to (count of windows) - (count of (windows whose value of attribute "AXMinimized" is true)) - (count of (windows whose title is "Picture-in-Picture"))
      if winCount is equal to 0 then return "0 windows"
		if tarApp is equal to "KeyCastr" then set wIndex to wIndex + 1 # apps where window 1 === uncloseable overlay

		# get wIndex, handle floating windows
		set isFloatingWindow to (focusedWIndex is equal to 1 and newFocusedWIndex > 1) or (focusedWIndex is equal to 1 and newFocusedWIndex is equal to 1 and nextApp is equal to tarApp and winCount > 1)
		set floatingWinExists to isFloatingWindow or (focusedWIndex > 1 or newFocusedWIndex > 1)
		set isOGWindow to OGWindow is equal to window 1
		if nextApp is equal to tarApp and winCount > 1 and not(isOGWindow)
			if floatingWinExists
				if isFloatingWindow
					set wIndex to newFocusedWIndex + 1
				else
					set wIndex to wIndex + 1
				end if
			else
				set wIndex to 2
			end if
		end if

		# perform minimize
		set tarWin to window wIndex
		try
			set value of attribute "AXMinimized" of tarWin to true
			return {tarApp, nextApp, "process1"}
		end try
		click (tarWin's buttons whose subrole is "AXMinimizeButton")
		return {tarApp, nextApp, "process2"}
	end tell
end tell


# minimize (by application)
set wIndex to focusedWIndex # tarWin window index (floating/frontmost window)
tell application tarApp
   try
      set winCount to (count of windows)
      if winCount is equal to 0 then return "0 windows"
		if nextApp is equal to tarApp and winCount > 1 and not(isOGWindow) then set wIndex to wIndex + 1
		set tarWin to window wIndex
		set collapsed of tarWin to true
		return {tarApp, nextApp, "application1"}
   end try
	try
		-- if tarApp is equal to "Emacs"
		-- 	tell application "Emacs" to set miniaturized of tarWin to true
		-- else
			set miniaturized of tarWin to true
		-- end if
		return {tarApp, nextApp, "application2"}
	end try
end tell





# helper fn's
on getPName(axTitle) # process name from axTitle (eg:   tell process getPName("Visual Studio Code")  =>  tell process "Code")
	#todo: find all exceptions: (apps whose app name !== process name (examples below))
	if axTitle is equal to "Parallels Mac VM" then return "Parallels Desktop"
	if axTitle is equal to "Alfred 4" or axTitle is equal to "Alfred 5" then return "Alfred"
	if axTitle is equal to "Visual Studio Code" then return "Code"
	if axTitle is equal to "iTerm" then return "iTerm2"
	if axTitle is equal to "PyCharm CE" then return "PyCharm"
	if axTitle is equal to "Adobe Illustrator 2021" then return "Adobe Illustrator"
	if axTitle is equal to "Adobe Photoshop 2021" then return "Photoshop"
	if axTitle is equal to "Adobe Premiere Pro 2021" then return "Premiere Pro"
	return axTitle
end getPName
