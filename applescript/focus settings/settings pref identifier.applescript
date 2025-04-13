

-- Open System Preferences.app and click into desired pane/setting. Then, run this script to find out name (Pane ID) and any anchors.

tell application "System Settings"
	set AppleScript's text item delimiters to ", "
	set CurrentPane to the id of the current pane
	get the name of every anchor of pane id CurrentPane
	set CurrentAnchors to get the name of every anchor of pane id CurrentPane
	set the clipboard to CurrentPane
	display dialog "Current Pane ID: " & CurrentPane & return & return & "Pane ID has been copied to the clipboard." & return & return & "Current Anchors: " & return & (CurrentAnchors as string)
end tell