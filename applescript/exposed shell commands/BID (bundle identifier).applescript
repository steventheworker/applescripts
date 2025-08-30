use framework "Foundation"
use framework "AppKit"
use scripting additions

-- Function to get the bundle identifier from the application path
on bidWithPath(appPath)
	set appURL to current application's |NSURL|'s fileURLWithPath:appPath
	set appBundle to current application's NSBundle's bundleWithURL:appURL
	if appBundle is equal to missing value then return appPath
	set bundleIdentifier to appBundle's bundleIdentifier() as text
	return bundleIdentifier
end bidWithPath

on trim(txt)
	set oldTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ""
	set txt to words of txt as string
	set AppleScript's text item delimiters to oldTIDs
	return txt
end trim

set txt to text returned of (display dialog "bundle identifier / app path (drag .app here):" default answer "") # app path
set bid to my bidWithPath(txt)
if txt is equal to "" or my trim(txt) is equal to "" then return
if (bid is equal to txt or bid as string is equal to "missing value") then
	if txt is equal to "firefox dev" then set txt to "Firefox Developer Edition"
	if txt is equal to "safari" then set txt to "Safari"
	tell application "System Events"
		# return bundle identifier of application process txt
		keystroke " " using {command down}
		delay 0.2
		keystroke txt
		delay 1
		key down 55
		delay 0.2
		key code 36 using {command down}
		delay 2
		tell application "Finder"
			set s to selection
			set n to name of first item of s
			set f to folder of first item of s
			set p to POSIX path of (f as alias) & "/" & n
			close window 1
		end tell
		display dialog my bidWithPath(p)
	end tell
else
	display dialog my bidWithPath(bid)
end if
