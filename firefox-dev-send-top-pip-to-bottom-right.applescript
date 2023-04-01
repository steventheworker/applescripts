# bound to cmd+shift+p

# get mouse position w/ objC (aka: use framework "AppKit")
set X to 0
set Y to 0
use framework "AppKit"
tell the current application
	set W to NSWidth(its NSScreen's mainScreen's frame)
	set H to NSHeight(its NSScreen's mainScreen's frame)
end tell

tell application "System Events"
	tell process "Firefox Developer Edition"
		if not(title of window 1 is equal to "Picture-in-Picture") then return
		set _ws to size of window 1
		set winWidth to item 1 of _ws
		set winHeight to item 2 of _ws
		set position of window 1 to {W - winWidth, H - winHeight}
	end tell
end tell
