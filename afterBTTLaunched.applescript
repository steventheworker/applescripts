# set vars
tell application "BetterTouchTool"
	set_number_variable "AltTabSwitcherOpen" to 0.0
	set_number_variable "steviaOS" to 1.0 # let apps (eg: DockAltTab) know you're using steventheworker's applescripts (BTT triggers)
	set_string_variable "ffCloseOrder" to "" # firefox-cmd-shift-t.applescript  helper
end tell
