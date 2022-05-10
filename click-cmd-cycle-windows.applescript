# activate app under mouse (in dock)
set X to 0
set Y to 0
use framework "AppKit" # get mouse position w/ objC (aka: use framework "AppKit")
tell the current application
	set H to NSHeight(its NSScreen's mainScreen's frame)
	tell [] & its NSEvent's mouseLocation
		set X to (item 1)
		set Y to H - (item 2)
	end tell
end tell


# get active app
tell application "BetterTouchTool" to set displayedAppID to get_string_variable "BTTActiveAppBundleIdentifier"
set displayedAppName to name of application id displayedAppID
# get app under mouse
set tarApp to ""
set tarAppIsRunning to false
tell application "System Events"
	tell application process "Dock"
		# list 2 === monitor 2 ?????? EXTERNAL MONITOR SUPPORT (ITERATE!!)
		tell list 1
			repeat with el in UI elements
				set xy to position of el
				set wh to size of el
				set elX to item 1 of xy
				set elY to item 2 of xy
				set W to item 1 of wh
				set H to item 2 of wh
				set appTitle to title of el
				if subrole of el is equal to "AXApplicationDockItem" and X � elX and X � elX + W and Y � elY and Y � elY + H then
					set appIsRunning to the value of attribute "AXIsApplicationRunning" of el
					set tarApp to appTitle
					set tarAppIsRunning to appIsRunning
				end if
			end repeat
		end tell
	end tell
	
	# no dock item under cursor => end script here
	if tarApp is equal to "" then return "No target app"
	
	# launch / iterate menu items + new window
	if not tarAppIsRunning then # launch app (via "do script" / AppleScriptObjC)
		my runApplescript("tell application \"" & tarApp & "\" to activate")
		return "App successfully launched"
	else # activate app, if not activated
		if displayedAppName is not equal to tarApp then tell application tarApp to activate
		set tarAppPName to my getPName(tarApp)


		# using AltTab
		-- keystroke "`" using {command down}
		-- delay 0.2
		-- key code 123

		# or swap windows (instead of adding one by one)  -  part1
		-- set tarAppPName to my getPName(tarApp)
		-- tell process tarAppPName
		-- 	set winCount to count of windows # todo: minus windows not on desktop (Safari)
		-- 	if winCount < 2 then return "Can't cycle " & winCount & " window(s)"
		-- end tell
	end if
end tell

# or swap windows (instead of adding one by one)  -  part 2
-- tell application tarApp
-- 	activate
	-- set index of window 1 to winCount
-- end tell
-- tell application "System Events" to tell process tarAppPName
-- 	perform action "AXRaise" of window 1
-- end tell

# or regular (click-shift-file-new (only bring forward first window))
tell application tarApp to activate
tell application "System Events" to tell process tarAppPName
	perform action "AXRaise" of window 1
end tell

return {(tarApp & " successfully activated & activated a new window")}






## <=======> helper library / functions <=======> ##
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

# "do script" fn --but via AppleScriptObjC (since I couldn't figure out how to mix frameworks w/ AppKit)
on runApplescript(theAppleScriptText)
	try
		set theNewNSAppleScriptObject to current application's NSAppleScript's alloc()'s initWithSource:theAppleScriptText
		if theNewNSAppleScriptObject is equal to missing value then return "Error! The Xojo NSAppleScript library was unable to create the NSAppleScript object with NSAppleScript's initWithSource: method."
	on error
		return "Error! The Xojo NSAppleScript library was unable to create the NSAppleScript object with NSAppleScript's initWithSource: method."
	end try
	set theNewNSAppleScriptObjectsClass to theNewNSAppleScriptObject's isKindOfClass:(current application's NSAppleScript's |class|())
	if theNewNSAppleScriptObjectsClass is equal to 1.0 then return "Error! A non NSAppleScript object was created by the Xojo NSAppleScript library's createCompileAndExecuteAppleScriptiObjectWithText: method."
	try
		set theNewNSAppleScriptObjectResult to theNewNSAppleScriptObject's executeAndReturnError:(missing value)
		if theNewNSAppleScriptObjectResult is equal to missing value then
			return "Error! The Xojo NSAppleScript library was unable to compile or execute the newly created NSAppleScript object with NSAppleScript's executeAndReturnError: method."
		end if
	on error
		return "Error! The Xojo NSAppleScript library was unable to compile or execute the newly created NSAppleScript object with NSAppleScript's executeAndReturnError: method."
	end try
	return "Success creating compiling and executing the NSApplescript object from the supplied AppleScript text string."
end runApplescript
