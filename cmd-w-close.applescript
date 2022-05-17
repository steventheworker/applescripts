# if tab app / document app - only close tabs (via trigger "commandW" (not windows)) (apps SHOULD handle closing windows @ last/single tab)         # handled tab apps: Xcode, Visual Studio Code, Terminal, Chrome, Firefox, Safari, PyCharm, Maps, iTerm2, Finder, Adobe Photoshop & Illustrator & 
# config (set _PATH's to "." to run from same directory as this script)
set RECLAIMFOCUS_PATH to "~/proj/Swift"

# get active app
global tarApp
global tarAppPName
global tarAppID
global winCount
tell application "BetterTouchTool" to set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set tarApp to name of application id tarAppID
set tarAppPName to getPName(tarApp)
set closeTab to false

tell application "System Events"
	tell process tarAppPName	# check tabs apps (by process)
		set winCount to (count of windows)
		set winTitle to title of window 1 # check if tab closed by title change (reclaimFocus)
      # check if weird window that dissapears on switch (eg: "Colors" ((cmd+shift+c) in many apps like Stickies/Script Editor)) & for dialog windows & AXFullScreen windows
		set isFullScreen to value of attribute "AXFullScreen" of window 1
		set wid to (attributes of window 1) whose (name is equal to "AXIdentifier")
		if count of wid > 0 then set wid to value of attribute "AXIdentifier" of window 1
		set sub to subrole of window 1 # window subrole
		set floats to (sub is equal to "AXSystemFloatingWindow" or sub is equal to "AXFloatingWindow")
		if wid is equal to "open-panel" or isFullScreen or floats or sub is equal to "AXDialog" or sub is equal to "Quick Look"
			tell application "BetterTouchTool" to trigger_named "commandW"
			if winCount is equal to (count of windows) then click ((window 1)'s buttons whose subrole is "AXCloseButton")
			return my quitAt0({tarApp, "'nextApp'", "floating window closed (with cycling)"})
		end if

      # tab apps - tab exists? by process
      if tarApp is equal to "Xcode"
			tell group 2 of splitter group 1 of splitter group 1 of group 2 of splitter group 1 of window 1
				set tabCount to 0
				if exists tab group 1 then set tabCount to count of radio buttons of tab group 1
				if tabCount > 0 then set closeTab to true
			end tell
      end if
		# test title of window 1 (look for " Ñ " OR " Ð "  (YES, THEY'RE DIFFERENT))
		if tarApp is equal to "Visual Studio Code" or tarAppPName is equal to "PyCharm"
			set windowTitle to title of window 1
			set lastTabPipe to -1 # testing title for " Ñ " (meaning there is a tab open)
			set lastSpace to -1
			set i to 0
			repeat with curLetter in characters of windowTitle
				set l to item (i + 1) of characters of windowTitle
				if lastSpace is equal to i - 1 and (l is equal to "Ñ" or l is equal to "Ð") then set lastTabPipe to i
				if l is equal to "Ê" then
					set lastSpace to i
					if lastTabPipe is equal to i - 1 then
						set closeTab to true
						exit repeat
					end if
				end if
				set i to (i + 1)
			end repeat
			if windowTitle is equal to "Get Started" then set closeTab to true # VSCode
		end if
		if tarApp is equal to "Maps" then if exists tab group 1 of window 1 then set closeTab to true # 1 tab left when element DNE
		if tarApp is equal to "Maps" or tarApp is equal to "Mail" or tarApp is equal to "Terminal" or tarApp is equal to "Finder" or tarApp is equal to "Script Editor"
			set tabCount to 1 # these app windows can't have less than 1 tabs
			if exists tab group 1 of window 1 then set tabCount to ((count of UI elements of tab group 1 of window 1) - 1) # minus the "+" button (add tab button)
			if tabCount > 1 then set closeTab to true
		end if
	end tell
end tell

# tab apps - tab exists? by app
if tarApp is equal to "Google Chrome" then tell application "Google Chrome" to if count of (tabs of window 1) > 1 then set closeTab to true
if tarApp is equal to "Chromium" then tell application "Chromium" to if count of (tabs of window 1) > 1 then set closeTab to true
if tarApp is equal to "Safari" then tell application "Safari" to if count of (tabs of window 1) > 1 then set closeTab to true
if tarApp is equal to "iTerm" then tell application "iTerm2" to if count of (tabs of window 1) > 1 then set closeTab to true

# fallback to always trigger commandW (in tab apps / reclaimFocus is true)
set reclaimFocus to false	# unscriptable & un-GUI scriptable apps (eg: electron based apps, Firefox, etc.) === Fallback to commandW + reclaimFocus   </3
# if line order: impossibleApps, ChatApps, API build Apps, MailApps (since comments on "Â" lines breaks builds)
if (tarApp is equal to "Firefox" or tarAppPName is equal to "Adobe Illustrator" or tarApp is equal to "Termius" or tarApp is equal to "Sublime Text"Â
	or tarApp is equal to "Slack"Â
	or tarApp is equal to "Postman" or tarApp is equal to "Insomnia"Â
	or tarApp is equal to "Postbox")Â
		then set reclaimFocus to true # tab apps w/ no count tab method / unscriptable
if closeTab or reclaimFocus
	tell application "BetterTouchTool" to trigger_named "commandW"
	if tarAppPName is equal to "Adobe Illustrator"
		set isHome to do shell script "osascript -e 'tell application \"" & tarApp & "\" to return homescreenvisible'"
		tell application "System Events" to tell process tarAppPName to if ((count of windows) is equal to 1 and isHome is equal to "true") then set visible to false
	end if
	if reclaimFocus
		-- tell application "System Events" # make sure a window is getting closed (if not closeTab)
		-- 	tell process tarAppPName
		-- 		if count of windows is equal to winCount and not (closeTab) and winTitle is equal to title of (window 1)
		-- 			click ((window 1)'s buttons whose subrole is "AXCloseButton")
		-- 			return my quitAt0({tarApp, "'nextApp'", "unreclaimed focus"})
		-- 		end if
		-- 	end tell
		-- end tell
		delay 0.05
		do shell script ("cd " & RECLAIMFOCUS_PATH & " && ./reclaimFocus")
		return my quitAt0({tarApp, "'nextApp'", "reclaimed focus"})
	end if
	return my quitAt0({tarApp, "'nextApp'", "fallback to close the tab"})
end if

if tarAppPName is equal to "Photoshop" then return my closeAdobeWindowTab(tarApp)

# get new active app
tell application "AltTab" to trigger
delay 0.05 # let app fully activate
tell application "BetterTouchTool" to set nextAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set nextApp to name of application id nextAppID


# close by app
tell application tarApp
   try
      set winCount to (count of windows)
      if winCount is equal to 0 then return my quitAt0({tarApp, nextApp, "0 windows"})
		set tarWin to window 1
		if nextApp is equal to tarApp and winCount > 1 then set tarWin to window 2
		close tarWin
		if (tarApp is equal to "iTerm" and winCount is equal to 1) # iTerm is weird (leaves no app activated after close)
			delay 0.0625
			tell application "AltTab" to trigger
		end if
		return my quitAt0({tarApp, nextApp, "application"})
   end try
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
      click (tarWin's buttons whose subrole is "AXCloseButton")
		return my quitAt0({tarApp, nextApp, "process2"})
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

on hackClose(tarApp, nextApp)
	if tarApp is equal to nextApp
		tell application "AltTab" to trigger
		delay 0.05
		tell application "BetterTouchTool" to trigger_named "commandW"
		return my quitAt0({tarApp, nextApp, "uncycle close"})
	else
		tell application "AltTab" to trigger
		delay 0.05
		tell application "BetterTouchTool" to trigger_named "commandW"
		tell application "AltTab" to trigger
		return my quitAt0({tarApp, nextApp, "re-cycle close (with cycling :C)"})
	end if
end hackClose

on closeAdobeWindowTab(tarApp)
	tell application tarApp to set documentCount to (count of documents)
	tell application "System Events"
		tell process tarAppPName
			if (title of window 1 is equal to tarApp)
				set visible to false
				return my quitAt0({tarApp, "'nextApp'", "hid adobe home 1"})
			end if
			set winCount to (count of windows)
		end tell
	end tell

	# switch
	tell application "AltTab" to trigger
	delay 0.05 # let app fully activate
	tell application "BetterTouchTool" to set nextAppID to get_string_variable "BTTActiveAppBundleIdentifier"
	set nextApp to name of application id nextAppID
	set nextAppPName to getPName(nextApp)
	
	if documentCount is equal to 0 then return my hackClose(tarApp, nextApp)
	# close the tab
	tell application tarApp
		if (documentCount > 0) then do shell script "osascript -e 'tell application \"" & tarApp & "\" to close current document'"
		set documentCount2 to (count of documents)
	end tell
	-- if (documentCount is equal to documentCount2)
	tell application "System Events"
		tell process tarAppPName
			if (count of windows) is equal to winCount
				if (title of window 1 is equal to tarApp)
					set visible to false
					return my quitAt0({tarApp, nextApp, "hid adobe home 2"})
				end if
				if documentCount is equal to documentCount2 then return my hackClose(tarApp, nextApp)
				tell application "AltTab" to trigger
				return my quitAt0({tarApp, nextApp, "holy diver"})
			end if
		end tell
	end tell
	my quitAt0({tarApp, nextApp, "closed by closeAdobeWindowTab"})
end closeAdobeWindowTab

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
