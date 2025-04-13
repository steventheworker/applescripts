tell application "System Events"
    set Storage to do shell script "/opt/homebrew/bin/cliclick p"
    do shell script "/opt/homebrew/bin/cliclick m:0,0"
    key code 160 # f3 (show mission control)
    do shell script "/opt/homebrew/bin/cliclick m:" & Storage
end tell

tell application "BetterTouchTool"
    set_number_variable "TaskSwitcherOpen" to 0.0
end tell