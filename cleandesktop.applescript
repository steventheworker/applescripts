# screenhook - EXCLUSIVE script
tell application "System Events"
	delay 6
	key code 103
	delay 0.1
	activate application "Finder"
	set autohide_status to autohide of dock preferences
	if autohide_status is equal to false then
		set autohide of dock preferences to true
		delay 1.2 #give time for hide to be noticed by clean fn
	else
		delay 0.1 #give time for clean fn to work (after showing desktop & activating finder)
	end if
	key code 19 using {command down, option down}
	if autohide_status is equal to false then set autohide of dock preferences to false
	key code 103
end tell
