set STEPSFINISHED to 4 # "config" (the only difference between trio & quad)

# read & update counter
tell application "BetterTouchTool"
   set runCounter to get_number_variable "iTerm-profile-runCounter"
   if runCounter is equal to missing value then set runCounter to 1
   set newVal to runCounter + 1
   if (runCounter equals STEPSFINISHED) then set newVal to 1 # reset runCounter (finished)
   set_number_variable "iTerm-profile-runCounter" to newVal
end tell

set kcodes to {18, 19, 20, 21}  # 1 (18) 2 (19) 3 (20) 4 (21) ... 0 (29)
tell application "iTerm"
   set T to (current tab) of (current window)

   # if finished, cmd+k all panels (then refocus 1st panel)
   if (runCounter equals STEPSFINISHED) then
      set i to 0
      repeat with sesh in sessions of T
         tell application "System Events"
            set i to (i + 1)
               key code (item i) of kcodes using {option down} # opt i (go to panel i)
               keystroke "K" using {command down} # clear (cmd + k)
         end tell
      end repeat
      # refocus 1st panel
      tell application "System Events" to key code ((item 1) of kcodes) using {option down} # opt 1
      return
   end if

   # split a new panel / session
   if (runCounter equals 1) then
      tell (current session) of T to split vertically with same profile # right pane
   else if (runCounter equals 2) then
      tell (session 2)       of T to split horizontally with same profile # bottom right pane
   else if (runCounter equals 3) then
      tell (current session) of T to split horizontally with same profile # bottom left pane
   end if
end tell

return # prevent log @ top of terminal

# sessions = panes
-- tell application "System Events"
--   tell application "iTerm"
--     activate
--     sessions of tab 1 of (current window)
--   end tell
-- end tell
