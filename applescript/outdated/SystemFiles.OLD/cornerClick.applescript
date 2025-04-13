# screenhook - EXCLUSIVE script
tell application "BetterTouchTool"
      set_number_variable "commitTopRight" to 2.0
      delay 0.1
      tell application "System Events"
            key down 63
            key code 45
            key up 63
      end tell
end tell
