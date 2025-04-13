set uname to do shell script "whoami"
set dialogText to "Enter your text:"
set r to (display dialog dialogText default answer "" buttons {"Cancel", "OK"} default button "OK")
set response to text returned of r

# add the date
set response to "[" & ((current date) as string) & "] " & response
if button returned of r is "OK" then
	set filePath to "/Users/" & uname & "/Documents/receipts/receipts.txt" -- Replace this with your desired file path
	set fileHandle to open for access filePath with write permission
	write response & return to fileHandle starting at eof
	close access fileHandle
end if
