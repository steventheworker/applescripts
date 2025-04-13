on calc(xstr)
	set base to 10
	set AppleScript's text item delimiters to "_"
	set logParts to text items of xstr
	
	if (count of logParts) is greater than 1 then
		if (item 1 of logParts is equal to "e") then
			set base to 2.718281828
		else
			set base to item 1 of logParts as number
		end if
		set x to item 2 of logParts as number
	else
		set x to xstr as number
	end if
	
	set r to do shell script "echo \"l(" & x & ")/l(" & base & ")\" | bc -l"
	display dialog r
end calc
# calc("e_8")
# calc("2_8")
# calc("10")