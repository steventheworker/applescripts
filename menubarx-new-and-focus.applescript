# open a new window (cmd+n or cmd+t) and attaches it (cmd+shift+d) it (detached by default)
set max to 3
set i to 0

tell application "MenubarX" to activate
tell application "System Events"
	tell process "MenubarX"
		tell menu bar 2
			set iconCount to (count of menu bar items)
			keystroke "n" using {command down}
			delay 2
			repeat while i < max
				set i to i + 1
				if (i is equal to max) then return
				log "..."
				delay 2
				if (count of menu bar items) > iconCount
					keystroke "d" using {command down, shift down}
					-- perform action "AXPress" of menu bar item (count of menu bar items)
					exit repeat
				else
					log "nope"
				end if
			end repeat
		end tell
	end tell
end tell



-- tell application "MenubarX" to activate
-- tell application "System Events"
-- 	tell process "MenubarX"
-- 		tell menu bar 2
-- 			set iconCount to (count of menu bar items)
-- 			set popupCount to (count of pop overs)
-- 			keystroke "n" using {command down}
-- 		end tell
-- 	end tell
-- end tell
-- return
-- delay 2
-- set max to 3
-- set i to 0
-- repeat while i < max
-- 	set i to i + 1
-- 	if (i is equal to max) then return
-- 	delay 2
-- 	tell application "System Events"
-- 		tell process "MenubarX"
-- 			tell menu bar 2
-- 				if (count of menu bar items) > iconCount then
-- 					perform action "AXPress" of menu bar item (count of menu bar items) # if (i < max) then perform action "AXPress" of menu bar item (count of menu bar items)
-- 					if not ((count of pop overs) > popupCount) then
-- 						keystroke "x" using {option down}
-- 						set i to 0
-- 					else
-- 						exit repeat
-- 					end if
-- 				end if
-- 			end tell
-- 		end tell
-- 	end tell
-- end repeat

