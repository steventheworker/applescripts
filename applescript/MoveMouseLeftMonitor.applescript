set dimensions to (do shell script "system_profiler SPDisplaysDataType | grep Resolution")
set primWidth to (word 2 of dimensions) + 0 # str -> number
set primHeight to (word 4 of dimensions) + 0 # str -> number

on split(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end split

tell application "System Events"
	set posStr to do shell script "/opt/homebrew/bin/cliclick p"
	set posRay to my split(posStr, ",")
	set x to ((item 1 of posRay) - primWidth) # the difference between the two scripts (- vs +)
	set y to ((item 2 of posRay) + 0)
	
	set cliclick_path to "/opt/homebrew/bin/cliclick"
	do shell script cliclick_path & " m:" & x & "," & y
	return {x, y}
end tell

