# "config"
set BASH_INSTANCE_APP_PATH to "/Applications/MyApps/" # Folder where VLC / Blender resides

# activate app under mouse (in dock)
# iterate over menu items and trigger the one starting with "New"
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

using terms from scripting additions
	set deskpath to ((path to desktop) as text)  # path for new finder window
end using terms from
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
				if subrole of el is equal to "AXApplicationDockItem" and X ≥ elX and X ≤ elX + W and Y ≥ elY and Y ≤ elY + H then
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
	else # activate app & make new window
		# handle bash instances (Blender / VLC)
		if tarApp is equal to "Blender" or tarApp is equal to "VLC"
			set theTask to current application'sNSTask's alloc()'s init()
			theTask's setLaunchPath_(BASH_INSTANCE_APP_PATH & tarApp & ".app/Contents/MacOS/" & tarApp)
			theTask's |launch|()
			return tarApp & " bash-forced to open a new window"
		end if
		# Speedy finder hack (as it's far slower via menu iteration)
		if tarApp is equal to "Finder"
			tell application "Finder" to make new Finder window to folder deskpath
			tell application "Finder" to activate
			tell process "Finder" to perform action "AXRaise" of window 1
			return "Finder hack (quickly)"
		end if
		# new window - trigger menu item by menu iteration
		tell application tarApp to activate
		set tarAppPName to my getPName(tarApp)
		tell process tarAppPName
			if count of windows is equal to 0 then set frontmost to true # don't shift window orders if you don't have to
			tell menu bar 1
				# handle hard coded menu items first (non-standard (eg: "New Window" item not in "File" menu) menu paths)
				if tarApp is equal to "BetterTouchTool"
					click menu item "New Window" of menu 1 of menu bar item "View"
				else if tarApp is equal to "iTerm"
					click menu item "New Window" of menu 1 of menu bar item "Shell"
				else if tarApp is equal to "Terminal"
					click menu item "New Window with Profile - Pro" of menu 1 of menu item "New Window" of menu 1 of menu bar item "Shell"
				else
					# iterate through "File" / "File->New" menu
					if not (menu bar item "File" exists) then return "Activated app, couldn't make a new window" # File submenu DNE
					tell menu 1 of menu bar item "File"
						# check for "New" submenu
						if menu 1 of menu item "New" exists
							tell menu 1 of menu item "New"
								if menu item "Project…" exists # Xcode uses: ellipsis
									click menu item "Project…"
								else if menu item "Project..." exists # Adobe Premiere 2021 uses: dot dot dot
									click menu item "Project..."
								else
									click menu item 1 # todo stop hard coding item 1 (currenlty only affects Tiled)
									# click 1st "New*" item in "New" submenu instead
									-- ala repeat with el in UI elements end repeat
								end if
							end tell
						else if menu item "New Window" exists
							click menu item "New Window"
						else
						# "New" submenu DNE, iterate through "File" submenu items
							set tarEl to missing value
							repeat with el in UI elements
								set elEnabled to the value of attribute "AXEnabled" of el
								set elTitle to the title of el
								
								# split(" ") elTitle into words
								set cachedTID to AppleScript's text item delimiters
								set AppleScript's text item delimiters to " "
								if elTitle is equal to missing value or elTitle is equal to "" then set elTitle to " "
								set titleWords to text items of elTitle
								set AppleScript's text item delimiters to cachedTID
								
								# set tarEl
								if elEnabled then
									if item 1 of titleWords is equal to "New" or item 1 of titleWords is equal to "New..." or item 1 of titleWords is equal to "New…"
										if not (exists menu 1 of el) #isn't a submenu itself
											if tarEl is equal to missing value then set tarEl to el
										-- ORRR -- if (first and third word "new" and "window")
											if count of titleWords is equal to 3
												if (item 2 of titleWords is equal to "Private") or (item 2 of titleWords is equal to "Incognito")
													0 # do nothing
												else
													if (item 3 of titleWords is equal to "Window") then set tarEl to el
												end if
											end if
										end if
									end if
								end if
							end repeat

							# click tarEl
							if tarEl is not equal to missing value then click menu item (title of tarEl)
						end if
					end tell
				end if
			end tell
		end tell
	end if
end tell

tell application tarApp to activate
tell application "System Events" to tell process tarAppPName
	perform action "AXRaise" of window 1
end tell




# (if tarApp === Xcode)    xcode-show-recent-projects.scpt
if (tarApp is equal to "Xcode")
	tell application "System Events"
		tell application "Xcode" to activate
		delay 0.333 # allow enough time to activate app
		key down 63 # fn down
		delay 0.333
		key code 100 using {control down} # Ctrl+F8 (reveal/navigate menu bar w/ keyboard) (or F2)
		key up 63 #fn up
		tell process "Xcode"
			click menu bar item "File" of menu bar 1
			click menu item "Open Recent" of menu 1 of menu bar item "File" of menu bar 1
		end tell
	end tell

end if




return {(tarApp & " successfully activated & made a new window")}






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
