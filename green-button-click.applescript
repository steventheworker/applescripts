tell application "BetterTouchTool"
	set tarAppID to get_string_variable "BTTActiveAppBundleIdentifier"
if tarAppID is equal to "com.apple.finder" or tarAppID is equal to "com.apple.preview"
   -- keystroke "f" using {control down, command down} # full screen
   trigger_named "default green button"
else
   tell application "System Events"
      key code 36 using {control down, option down, command down} # full size rectangle shortcut
   end tell
end if
end tell
