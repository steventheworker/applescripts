on installSafariPWA(urlToOpen)
	tell application "System Events"
		set isRunning to (count of (every process whose name is "Safari")) > 0
		tell application "Safari"
			# activate & open url in new window
			set doc to make new document
			activate
			open location urlToOpen
			# repeat until url loaded
			repeat
				set loading to (do JavaScript "document.readyState" in document 1)
				if loading is "complete" then exit repeat
				log loading
				delay 0.333
			end repeat
		end tell
		
		# add to dock
		tell process "Safari"
			delay 5
			tell menu of menu bar item "File" of menu bar 1
				click menu item "Add to Dock…"
			end tell
			
			delay 2 # give time for "Add to Dock…"
			
			# click Add btn w/ tab + space
			key code 48 # tab
			key code 48 # tab
			key code 48 # tab
			key code 48 # tab
			delay 1
			key code 49 # space
			
			delay 2 # give time for Add btn
			
			# close the window
			tell menu of menu bar item "File" of menu bar 1
				click menu item "Close Window"
			end tell
		end tell
		
		delay 1 # give time to close window
		if not isRunning then tell application "Safari" to quit # finished, quit if wasn't running
	end tell
end installSafariPWA

# installSafariPWA("https://kfc.com")

# use the below code if 
# on installSafariPWA(urlToOpen)
# 	tell application "Safari"
# 		set doc to make new document
# 		activate
# 		open location urlToOpen
# 	end tell
# 	log URL of doc
# 	delay 2.231 # give time to load page
# 	tell application "System Events"
# 		# click menubar Add to Dock…
# 		tell process "Safari"
# 			tell menu of menu bar item "File" of menu bar 1
# 				click menu item "Add to Dock…"
# 			end tell
# 		end tell
# 		
# 		delay 0.666
# 		
# 		# click Add btn w/ tab + space
# 		key code 48 # tab
# 		key code 48 # tab
# 		key code 48 # tab
# 		key code 48 # tab
# 		delay 0.1
# 		key code 49 # space
# 		
# 		delay 0.666 * 2
# 		# close the window
# 		tell process "Safari"
# 			tell menu of menu bar item "File" of menu bar 1
# 				click menu item "Close Window"
# 			end tell
# 		end tell
# 	end tell
# end installSafariPWA

