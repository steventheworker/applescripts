set waitTime to text returned of (display dialog "Enter seconds to wait:" default answer "3")
delay waitTime as integer
tell application "System Events"
	key code 36 -- This sends the "Return" key
end tell