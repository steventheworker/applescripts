# red button fn (close window) - this script is within cmd-w-close (minus some parts)

# get active app
global tarApp
global tarAppPName
global tarAppID
global winCount
tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)
set winTitle to ""

if not (tarAppPName is equal to "Premiere Pro") # all Premiere Pro components are floating (ignore; we want to close the full window in this script)
	tell application "System Events"
		tell process tarAppPName
			# close weird window (by process) that dissapear on switch (eg: "Colors" ((cmd+shift+c) in many apps like Stickies/Script Editor)) & for dialog windows & AXFullScreen windows
			set isFullScreen to value of attribute "AXFullScreen" of window 1
			set wid to (attributes of window 1) whose (name is equal to "AXIdentifier")
			if count of wid > 0 then set wid to value of attribute "AXIdentifier" of window 1
			set sub to subrole of window 1 # window subrole
			set floats to (sub is equal to "AXSystemFloatingWindow" or sub is equal to "AXFloatingWindow")
			if wid is equal to "open-panel" or isFullScreen or floats or sub is equal to "AXDialog" or sub is equal to "Quick Look"
				set winCount to (count of windows)
				tell application "BetterTouchTool" to trigger_named "commandW"
				if winCount is equal to (count of windows) then click ((window 1)'s buttons whose subrole is "AXCloseButton")
				return my quitAt0({tarApp, "'nextApp'", "floating window closed (with cycling)"})
			end if
			set tarWin to window 1
		end tell
	end tell
end if

# get new active app
tell application "AltTab" to trigger
delay 0.05 # let app fully activate
tell application "BetterTouchTool" to set nextAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set nextApp to name of application id nextAppID

# some Apple (tab based) apps are handled within the block below
if (tarApp is equal to "Pages" or tarApp is equal to "Numbers" or tarApp is equal to "Terminal" or tarApp is equal to "Maps" or tarApp is equal to "Finder" or tarApp is equal to "Script Editor")
	tell application "System Events"
		tell process tarAppPName
			if (count of windows) is equal to 0 then return # no windows exist
			if tarApp is equal to nextApp # uncycle (since we're targeting window 1 (which is now 2))
				if (tarApp is equal to "Script Editor")
					set tarWin to window 2
				else
					tell application "AltTab" to trigger
					delay 0.05 # let app fully activate
				end if
			end if
			set tabCount to 1
			if (exists (tab group 1 of tarWin))
				set tabCount to (count of UI elements of tab group 1 of tarWin) - 1 # minus the "+" button (add tab button)
				# close tab by clicking UI element (AXClose / x button)
				repeat (tabCount) times
					if (exists (tab group 1 of tarWin)) # prevent crash after tab bar UI hides @ 0 tabs (eg: Finder, and others)
						set winCount to count of windows
						click button 1 of radio button 1 of tab group 1 of tarWin
						delay 0.06
						if (winCount - (count of windows) is equal to 1) then exit repeat # stop closing tabs, a window's been closed
					else
						click (tarWin's buttons whose subrole is "AXCloseButton") # last ditch effort to close the tab, after all other windows closed
					end if
				end repeat
			else
				click (tarWin's buttons whose subrole is "AXCloseButton")
				return my quitAt0({tarApp, nextApp, "Single apple app window"})
			end if
		end tell
	end tell
	return my quitAt0({tarApp, nextApp, "Apple apps"})
end if


# close by app
tell application tarApp
	set nameTitle to "" # make sure winTitle of window we're supposed to be closing is the same (apps sometimes return only include tab windows here, when telling by app (eg: Inspector windows in Safari))
	try
      set winCount to (count of windows)
      if winCount is equal to 0 then return my quitAt0({tarApp, nextApp, "0 windows"})
		set tarWin to window 1
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		set nameTitle to title of tarWin
	end try
	try
		if nameTitle is equal to "" then set nameTitle to name of tarWin
	end try
	if nameTitle is equal to winTitle
		try
			close tarWin
			if (tarApp is equal to "iTerm" and winCount is equal to 1) # iTerm is weird (leaves no app activated after close)
				delay 0.0625
				tell application "AltTab" to trigger
			end if
			return my quitAt0({tarApp, nextApp, "application"})
		end try
	end if
end tell

# close by process
tell application "System Events"
	tell process tarAppPName
      set winCount to (count of windows)
      if winCount is equal to 0 then return my quitAt0({tarApp, nextApp, "0 windows"})
		set tarWin to window 1
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		try
			close tarWin
			return my quitAt0({tarApp, nextApp, "process1"})
		end try
		if tarAppPName is equal to "Premiere Pro" and name of tarWin ends with ".prproj"
			click menu item "Close Project" of menu 1 of menu bar item "File" of menu bar 1
			return my quitAt0({tarApp, nextApp, "process click menu item - Close Project"})
		end if
		if exists (tarWin's buttons whose subrole is "AXCloseButton")
			click (tarWin's buttons whose subrole is "AXCloseButton")
			return my quitAt0({tarApp, nextApp, "process AXCloseButton"})
		end if
		if tarAppPName is equal to "Adobe Illustrator" or tarAppPName is equal to "Photoshop"
			set isHome to do shell script "osascript -e 'tell application \"" & tarApp & "\" to return homescreenvisible'"
			if (count of window is equal to 1 and isHome is equal to "true") then set visible to false
			return my quitAt0({tarApp, nextApp, "illustrator - app then process"})
		end if
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

on numWindowsAllSpaces(tarApp)
	tell application "AltTab" to return countWindows appBID tarAppID
end numWindowsAllSpaces

# quits an app if it hits 0 windows (in all spaces)
on quitAt0(_a)
	log _a # logs closing message
	# count windows remaining and close / hide (at 0)
	-- apple apps
	if (tarApp is equal to "Calendar" or tarApp is equal to "Accessibility Inspector" or tarApp is equal to "Mail" or tarApp is equal to "TextEdit" or tarApp is equal to "Script Editor" or tarApp is equal to "Activity Monitor" or tarApp is equal to "Maps" or tarApp is equal to "Notes" or tarApp is equal to "Terminal" or tarApp is equal to "Preview" or tarApp is equal to "Messages"Â
		or tarApp is equal to "Firefox" or tarAppPName is equal to "Code" or tarApp is equal to "VLC" or tarApp is equal to "Spark" or tarApp is equal to "Apollo" or tarApp is equal to "Sublime Text" or tarApp is equal to "Termius" or tarApp is equal to "Friendly Streaming") -- other apps
		tell application "System Events"
			tell process tarAppPName
				if tarApp is equal to "Accessibility Inspector" # apps that always have a floating window open (shows on process, but not AltTab)
					if (winCount is equal to 1 and (count of windows) is equal to 1) then set didLastWindowClose to my numWindowsAllSpaces(tarApp) is equal to 0
				else
					if (count of windows < 1) then set didLastWindowClose to my numWindowsAllSpaces(tarApp) < 1 # other apps that close @ 0
				end if
				if (didLastWindowClose)
					if (tarApp is equal to "Mail" or tarApp is equal to "Spark")
						set visible to false # apps to HIDE at 0 windows
					else
						do shell script("osascript -e 'tell application \"" & tarApp & "\" to quit'") # quit at 0 windows
					end if
				end if
			end tell
			if didLastWindowClose and tarApp is equal to "Notes" # notes doesn't close all processes on quit (close the one that prevents dockClickHideToggle (dock exposŽ))
				delay 3
				tell process "com.apple.Notes.WidgetExtension" to do shell script "kill -9 " & (unix id)
			end if
		end tell
	end if
end quitAt0
