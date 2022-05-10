tell application "App Store" to activate
tell application "System Events"
    tell process "App Store"
        -- click text field 1 of group 1 of splitter group 1 of window 1
        tell window 1
            click text field 1 of group 1 of splitter group 1
            key code 48
            -- set value of UI element 1 of group 1 of splitter group 1 to "boo"
        end tell
        -- properties of text field 1 of group 1 of splitter group 1 of window 1
    end tell
end tell
