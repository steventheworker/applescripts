-- delay 2 # (debugging) run and then click on the app you want to close

# get active app name
set tarApp to ""
set nextApp to ""
tell application "System Events"
	tell (first process whose frontmost is true)
		set tarApp to displayed name
		set tarWin to window 1
	end tell
	# switch to next window w/ cmd+tab (could be the same app or a different one) 
	key code 48 using {command down}
	delay 0.01
	key code 55 # make sure AltTab is closed... CMD (55 works) / SPACE (49 works) / ESC (53 - doesn't work due to BTT mapping)
	delay 0.01
	tell (first process whose frontmost is true) to set nextApp to displayed name
end tell
# check if next window is from same app (ie: window 1 => window 2, then closeIndex = 2)
set closeIndex to 1
if nextApp is equal to tarApp then set closeIndex to 2

# close active window (and DO NOT cycle next window afterwards (if it's not the next window))
# by telling the application:
set c to 9999 # no. of windows   -   impossible no. of windows
tell application tarApp
   try
      set c to -(count of windows)
      if c is equal to 0 then return "0 windows"
		if tarApp is equal to nextApp
			if closeIndex > -c then set closeIndex to 1 # happens in System Preferences/Finder/iTerm?????
		end if
      close (first window whose index is closeIndex)
		set c to -(c)
   end try
end tell

# on success: return;
if c is not equal to 9999 and c > 0 then return {tarApp, nextApp, closeIndex, c, "SUCCESS"}

# else, try again: by telling the process
set tarAppPName to getPName(tarApp)
tell application "System Events"
	tell process tarAppPName
		set c to -(count of windows)
		if c is equal to 0 then return "0 windows"
		if tarApp is equal to nextApp
			if closeIndex > -c then set closeIndex to 1 # happens in system preferences and iTerm ?????
		end if
		-- set tarWin to window closeIndex
		try
			-- set tarWin to (first window whose index is closeIndex)
			close tarWin
			set c to -(c)
		end try
		# app is not scriptable (couldn't close)
		if c < 0 then click (tarWin's buttons whose subrole is "AXCloseButton")
	end tell
end tell

# on script finished: return;
return {tarApp, nextApp, closeIndex, c, "FINISHED"}









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