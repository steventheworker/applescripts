use AppleScript version "2.4" -- Yosemite (10.10) or later
use framework "Foundation"
use framework "AppKit"
use scripting additions

current application's NSWorkspace's sharedWorkspace()'s openURL:(current application's NSURL's URLWithString:"x-apple.systempreferences:com.apple.systempreferences.GeneralSettings")

delay 0.666
tell application "System Events"
	tell process "System Settings"
		tell scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			# general tab subgroups 1-4 (updates is in 1, time machine is in 4)
			tell group 2
				click button 2 # about, (software update), storage, airdrop & handoff, login items
			end tell
		end tell
	end tell
end tell

