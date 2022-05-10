tell application "Safari"
    make new document
    activate
end tell

# old script
-- tell application "System Events"
	-- tell process "Safari"
	-- 	click menu item "Open Location…" of menu "File" of menu bar 1
	-- end tell
-- end tell

# below is implemented on BTT (or it runs slower here)
# make sure new windows are full sized (consistently)
# otherwise, it will always be the size of the previous window
-- tell application "System Events"
-- 	#ctrl, opt, cmd + enter
-- 	key code 36 using {control down, option down, command down}
-- end tell

