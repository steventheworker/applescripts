# todo: iterm2 isVisible ? screeenhook: onspacechange reopen currentSpace's floating windows (they currently hide themselves after leaving space)
global CLICLICK_PATH
set CLICLICK_PATH to "/opt/homebrew/bin/cliclick"
on clickRectangleLowerCenter(x, y, w, h)
	do shell script (CLICLICK_PATH & " c:" & (round (x + w / 2)) & "," & (round (y + h / 2)))
end clickRectangleLowerCenter


tell application "iTerm"
	set srcWin to current window
	if (srcWin is equal to missing value) then return "no window available to float/unfloat"
	set srcWinID to id of srcWin
	set srcTab to current tab of srcWin
	set srcTabSessionCount to count of sessions of srcTab
	set srcSession to current session of srcTab
	set winProfile to profile name of srcSession
	
	if winProfile starts with "Default Floating" then # move to new regular window
		tell srcSession to set name to "Default" # this sets the (new) profile name!
		set tarWin to create window with default profile # make new default window
	else -- 									   # move to new floating window:  find availableHotKeyWindow
		set availableHotKeyWindows to {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
		repeat with el in windows # filter out unavailable floating windows
			set elProfile to profile name of current session of tab 1 of el
			if elProfile starts with "Default Floating" then
				set hotKeyIndex to (text -1 of elProfile) as integer
				# unavailable => remove from availableHotKeyWindows
				set filteredAvailableHotKeyWindows to {}
				repeat with n from 1 to count of availableHotKeyWindows
					set value to item n of availableHotKeyWindows
					if value is not equal to hotKeyIndex then
						set end of filteredAvailableHotKeyWindows to value
					end if
				end repeat
				set availableHotKeyWindows to filteredAvailableHotKeyWindows
			end if
		end repeat
		if (count of availableHotKeyWindows) is equal to 0 then
			return display dialog "You've maxxed out the 10 floating hot key window's!"
		end if
		set floatingProfile to "Default Floating " & (item 1 of availableHotKeyWindows)
		tell srcSession to set name to floatingProfile # this sets the (new) profile name!
		set tarWin to create hotkey window with profile (floatingProfile) # make new hotkey window  -- (individual profile w/ floating hotkey window) = ctrl+opt+cmd+shift + [0-9]		
	end if
	set tarSession to session 1 of tab 1 of tarWin
	set tarSessionID to id of tarSession
	
	set bad to {"Default", "bash", "login", " ", "ShellLauncher", "ps", "sudo", "path_helper", "env", "sw_vers"} # title takes many names before ready (to give up focus)
	set goodCount to 0
	set confidence to 2 # 1 didn't work, 3 was too slow...
	repeat # delay until new window *ready* to be swapped (title not in bad)
		if not (bad contains name of window 1) then # good
			set goodCount to goodCount + 1
			if goodCount is equal to confidence then exit repeat
		else
			set goodCount to 0 # reset if ever bad
		end if
		delay 0.1
	end repeat
end tell

# swap old current session with new floating/regular window session
tell application "BetterTouchTool" to trigger_named "iTerm2CycleAndMoveSessionToSplitPane"

# we should use same x, y, w, h, so we know exactly where to click!
tell application "System Events"
	tell process "iTerm2"
		set w1 to window 1 #srcwin
		set w2 to window 2 #tarwin
		set {x, y} to position of w1
		set {w, h} to size of w1
		set {x2, y2} to position of w2
		set {w2, h2} to size of w2
		
		set position of window 2 to {x, y}
		set size of window 2 to {w, h}
		
		if not (winProfile is equal to "Default") then # hide floating window (in case of complete overlap)
			# hide floating window 			#tell application "iTerm" to toggle hotkey window tarWin   # <--- not working
			set THRU9 to {")", "!", "@", "#", "$", "%", "^", "&", "*", "("}
			keystroke (item ((item 1 of availableHotKeyWindows) + 1) of THRU9) using {command down, option down, control down} # toggle			
			delay 0.333
		end if
		
		my clickRectangleLowerCenter(x, y, w, h)
		delay 0.333
		tell application "iTerm"
			repeat with s in every session of tab 1 of window 1
				if id of s is equal to tarSessionID then
					tell s to close
					exit repeat
				end if
			end repeat
		end tell
		if not (winProfile is equal to "Default") then
			# todo: reshow floating window (if has other sessions)
			# if srcTabSessionCount > 0 then keystroke (item ((item 1 of availableHotKeyWindows) + 1) of THRU9) using {command down, option down, control down}
		end if
	end tell
end tell
