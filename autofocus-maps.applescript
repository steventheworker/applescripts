tell application "Maps" to activate
tell application "System Events"
    tell process "Maps"
        -- click text field 1 of group 1 of splitter group 1 of window 1
        tell window 1
            -- delay 0.2
            -- key code 48
            tell group 1 of group 1 of group 1 of group 1 of group 1
                click text field 1 of group 1 of group 1 of group 1 of group 1 of group 1 of  group 1 of group 1 of group 2 of group 1 of group 1 of group 2
            end tell
        end tell
    end tell
end tell
