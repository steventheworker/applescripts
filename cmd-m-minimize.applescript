# get active app
tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)

# get new active app
tell application "AltTab" to trigger
delay 0.05 # let app fully activate
tell application "BetterTouchTool" to set nextAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set nextApp to name of application id nextAppID

# minimize by app
tell application tarApp
   try
      set winCount to (count of windows)
      if winCount is equal to 0 then return "0 windows"
		set tarWin to window 1
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		set collapsed of tarWin to true
		return {tarApp, nextApp, "application"}
   end try
end tell

# minimize by process
tell application "System Events"
	tell process tarAppPName
      set winCount to (count of windows)
      if winCount is equal to 0 then return "0 windows"
		set tarWin to window 1
		if tarApp is equal to "KeyCastr" then set tarWin to window 2 # apps where window 1 === uncloseable overlay
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		try
			set value of attribute "AXMinimized" of tarWin to true
			return {tarApp, nextApp, "process1"}
		end try
		click (tarWin's buttons whose subrole is "AXMinimizeButton")
		return {tarApp, nextApp, "process2"}
	end tell
end tell






# helper fn's
on getPName(axTitle) # process name from axTitle (eg:   tell process getPName("Visual Studio Code")  =>  tell process "Code")
	#todo: find all exceptions: (apps whose app name !== process name (examples below))
	if axTitle is equal to "Visual Studio Code" then return "Code"
	if axTitle is equal to "iTerm" then return "iTerm2"
	if axTitle is equal to "PyCharm CE" then return "PyCharm"
	if axTitle is equal to "Adobe Illustrator 2021" then return "Adobe Illustrator"
	if axTitle is equal to "Adobe Photoshop 2021" then return "Photoshop"
	if axTitle is equal to "Adobe Premiere Pro 2021" then return "Premiere Pro"
	return axTitle
end getPName
