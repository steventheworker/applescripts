# Option + /      global shortcut, focuses the 1st input on the safari automator instance
with timeout of 1 second
	tell application "System Events"
		tell process "Automator Workflow Runner (BetterTouchTool, open-remote)"
         set frontmost to true
         tell window 1
            set focused of text field 1 of text area 1 of UI element 1 of scroll area 1 to true
         end tell
		end tell
	end tell
end timeout

