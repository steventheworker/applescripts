tell application "Notes" to activate
tell application "System Events"
   tell process "Notes"
      set w to first window whose value of attribute "AXMain" is equal to true
      tell toolbar 1 of w
         set groupCount to count of every group
         set lastGroup to group groupCount
         tell lastGroup
            set focused of text field 1 to true
         end tell
      end tell
   end tell
end tell
