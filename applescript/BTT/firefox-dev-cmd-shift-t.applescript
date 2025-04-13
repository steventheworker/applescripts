# todo: ffCloseOrder max length? 1000.

tell application "System Events" # block prevents unecessary ffCloseOrder change on PIP
   tell process "Firefox Developer Edition"
      set x to 1
      set focusedWIndex to 0
      repeat with w in windows
         if value of attribute "AXMain" of w is equal to true -- if focused of w is equal to true
            set focusedWIndex to x
            exit repeat
         end if
         set x to (x + 1)
      end repeat
      if count of windows > 0 and title of window focusedWIndex is equal to "Picture-In-Picture" then return "won't work on PIP"
   end tell
end tell

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
