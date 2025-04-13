set Storage to do shell script "/opt/homebrew/bin/cliclick p"
tell application "System Events"
	do shell script "/opt/homebrew/bin/cliclick m:0,0"
	key code 160 # trigger f3
	do shell script "/opt/homebrew/bin/cliclick m:" & Storage
end tell
