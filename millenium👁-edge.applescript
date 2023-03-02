with timeout of 1 second
	tell application "System Events"
		tell process "Automator Workflow Runner (BetterTouchTool, open-remote)"
			set frontmost to true
			tell window 1
				# screen = 2560 x 1600 -> 1440x900
				# automator workflow = 500 x 311
				set position to {0, 563} # bottom-left (somehow 907 = bottom-right?)
			end tell
		end tell
	end tell
end timeout
