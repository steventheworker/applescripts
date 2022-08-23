tell application "BetterTouchTool"
   trigger_named "ffReopenWindow"
   set ffCloseOrder to get_string_variable "ffCloseOrder"
   # pop last restore (w)indow
   set_string_variable "ffCloseOrder" to my replaceLastInstanceOfChar(ffCloseOrder, "w", "")
end tell

to lastIndexOfChar(haystack, needle) # case insensitive
   set ray to text items of haystack
   set charCount to count of ray
   set i to charCount
   repeat charCount times
      set cur_char to text item i of ray
      if (cur_char is equal to needle) then exit repeat
      set i to i - 1
   end repeat
   return i
end lastIndexOfChar

to replaceLastInstanceOfChar(haystack, needle, replaceWith)
   set i to lastIndexOfChar(haystack, needle)
   set charCount to count of haystack
   if (i is equal to 0) then return haystack
   if (i is equal to 1 and charCount is equal to 1) then return replaceWith
   if (i is equal to 1) then return replaceWith & text (text item (i + 1)) thru (text item (-1)) of haystack # last instance = char 0
   if (i is equal to charCount) then return text (text item 1) thru (text item (i - 1)) of haystack & replaceWith # last instance = last char
   return text (text item 1) thru (text item (i - 1)) of haystack & replaceWith & text (text item (i + 1)) thru (text item (-1)) of haystack # last instance in the middle
end replaceLastInstanceOfChar

# replace first instance of needle
-- to str_replace(haystack, needle, replaceWith)
--    set AppleScript's text item delimiters to needle
--    return text item 1 of haystack & replaceWith & text (text item 2) thru (text item -1) of haystack
-- end str_replace
