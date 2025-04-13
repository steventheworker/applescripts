on screens(aspectRatio)
	set x to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution:/{ printf \"%s %s\\n\", $2, $4 }'")
	set resolutions to {}
	repeat with p in paragraphs of x
		set resolutions to resolutions & {{(word 1 of p as number) / aspectRatio, (word 2 of p as number) / aspectRatio}}
	end repeat
	return resolutions
end screens

# display dialog
set resStr to ""

# actual dimensions
repeat with res in my screens(1)
	set x to item 1 of res
	set y to item 2 of res
	set resStr to resStr & (x as string) & " x " & (y as string) & "
"
end repeat

# w/ aspect ratio/scaling (16:9)
set resStr to resStr & "
or w/ aspect ratio/scaling (16:9)

"
repeat with res in my screens(16 / 9)
	set x to (item 1 of res)
	set y to (item 2 of res)
	set resStr to resStr & (x as string) & " x " & (y as string) & "
"
end repeat

display dialog resStr
