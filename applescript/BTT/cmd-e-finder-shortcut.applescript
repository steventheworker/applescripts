tell application "System Events" to set uname to name of current user
tell application "Finder"
   make new Finder window to folder "Desktop" of folder uname of folder "Users" of startup disk
   activate
   -- make new Finder window
   -- set target of window 1 to folder "Desktop" of folder "super" of folder "Users" of startup disk
end tell
