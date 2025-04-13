-- tell application "Firefox Developer Edition"
-- 	open ":"
-- 	activate
-- end tell

tell application "System Events"
	tell process "Firefox"
		tell menu 1 of menu bar item "File" of menu bar 1
			click menu item "New Window"
			tell menu 1 of menu item "New Container Tab"
				click menu item 1 # first profile
			end tell
		end tell
	end tell
end tell

# tell application "Firefox" to activate # will raise all windows
do shell script "open -a Firefox" # will raise frontmost window only

on screens(aspectRatio)
	set x to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution:/{ printf \"%s %s\\n\", $2, $4 }'")
	set resolutions to {}
	repeat with p in paragraphs of x
		set resolutions to resolutions & {{(word 1 of p as number) / aspectRatio, (word 2 of p as number) / aspectRatio}}
	end repeat
	return resolutions
end screens
set res to item 1 of my screens(16 / 9)

tell application "System Events"
	#key code 48 using {control down}
	#keystroke "w" using {command down}
	tell process "Firefox"
		set newPosition to {235, 100}
		set newSize to {(item 1 of res) - 235 * 2, (item 2 of res) - 100 * 2}
		tell (first window whose value of attribute "AXMain" is equal to true)
			set position to newPosition
			set size to newSize
		end tell
	end tell
end tell
