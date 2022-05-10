# screenhook - EXCLUSIVE script
tell application "BetterTouchTool"
      set_number_variable "cornerRight" to 1.0
      delay 0.1
      tell application "System Events"
            key down 63
            key code 45
            key up 63
      end tell
end tell
