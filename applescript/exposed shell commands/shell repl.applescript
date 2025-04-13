# use do shell script rather than trying to directly do things on terminal (prevents polluting the history)
on shellRepl(dialogText)
	set r to (display dialog dialogText default answer "" buttons {"Cancel", "Execute"} default button "Execute")
	set txt to text returned of r
	if button returned of r is "Execute" then
		try
			shellRepl(">> " & txt & "
<< " & (do shell script txt))
		on error err
			shellRepl("ERROR:

" & err)
		end try
	end if
end shellRepl
shellRepl("Welcome to shell \"repl\", Enter a command:")
