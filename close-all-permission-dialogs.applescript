# sometimes apps popup too many permission dialogs, this will close 100 of them quickly
set numDialogs to 100
  delay 0.5
repeat numDialogs times
	delay 0.07
	tell application id "com.apple.accessibility.universalAccessAuthWarn"
		
		activate
		
	end tell
	
	keystroke " "
	
end repeat
