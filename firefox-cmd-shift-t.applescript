# todo: ffCloseOrder max length? 1000.

tell application "BetterTouchTool"
   set ffCloseOrder to get_string_variable "ffCloseOrder"
   if count of ffCloseOrder < 2
      set_string_variable "ffCloseOrder" to ""
      set reopenType to ffCloseOrder
   else
      set_string_variable "ffCloseOrder" to text 1 thru -2 of ffCloseOrder # string slice last char
      set reopenType to text -1 thru -1 of ffCloseOrder # string last char
   end if
   if (reopenType is equal to "w")
      trigger_named "ffReopenWindow"
   else
      trigger_named "ffReopenTab"
   end if
end tell

-- tell application "System Events"
--    tell process "Firefox"

--    end tell
-- end tell
