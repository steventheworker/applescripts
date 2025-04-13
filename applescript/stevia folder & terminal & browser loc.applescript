# ssh'ing into UTM VM is pointless, since we can see the HDD under network in finder
# this scpt opens new iterm2 window, and runs my zsh alias, stevia, which:
# 	- open finder @ VM
# 	- iterm2 path @ VM
# 	- runs:  open default browser @ VM:8080
# ie:  alias stevia="/Volumes/stevia && open . && open \"http://stevias-virtual-machine.local:8080/\""

tell application "iTerm"
	activate
	set newWindow to (create window with default profile)
	tell current session of newWindow
		write text "stevia"
	end tell
end tell
