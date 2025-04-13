# delay 1
set phoneName to "iPhone" # phone name as it appears under menu:  Safari -> Develop

# opens an inspector for all tabs currently open on iPhone safari
tell application "System Events"
	set activeAppProcess to first application process whose frontmost is true
	
	tell activeAppProcess
		set activeWinTitle to title of window 1
		try # floating iterm2 window doesn't have attr AXIdentifier!
			set activeWinIdentifier to value of attribute "AXIdentifier" of window 1
		on error
			set activeWinIdentifier to ""
		end try
		set targetWebApp to activeWinIdentifier starts with "WebAppWindow"
	end tell
	
	tell application "Safari" to activate -- and Wait until Safari is ready
	set i to 0
	repeat until (title of (first application process whose frontmost is true) is equal to "Safari")
		if i is equal to 30 then exit repeat
		set i to i + 1
		delay 0.111
	end repeat
	
	# Ctrl+F8 (reveal/navigate menu bar w/ keyboard) (or F2)
	key down 63 # fn down
	delay 0.333
	key code 100 using {control down}
	key up 63 #fn up
	
	# loop through Develop->se2020
	tell process "Safari"
		if not (targetWebApp) and Â
			title of (menu item 5 of menu 1 of menu bar item "Develop" of menu bar 1) is equal to "" Â
			then return "No phone available" # should be "se2020"
		tell menu 1 of menu bar item "Develop" of menu bar 1
			set deviceEl to menu item 4 # macEl
			if not (targetWebApp) then set deviceEl to item 1 of (menu items whose title is equal to phoneName) # phoneEl
			
			# todo: if targetWebApp then match ONLY elTitle mostsimilar to activeWinTitle
			# reason we haven't implemented this is: shows "open.spotify.com Ð search" under develop, yet activeWinTitle="Spotify Ð Search"
			
			tell menu 1 of deviceEl
				repeat with el in UI elements
					repeat 1 times # inner loop (which you CAN "continue"(by exit) out of) helps to simulate "continue" in parent repeat
						set elTitle to title of el
						# options we don't want
						if elTitle is equal to "Safari" or not enabled of el then exit repeat # no titular elements
						if elTitle is equal to "JSContext" then exit repeat
						if elTitle is equal to "AdGuard Ñ Extension Background Page" then exit repeat # extension background pages
						if elTitle is equal to "Dark Reader Ñ Extension Background Page" then exit repeat
						if elTitle is equal to "Userscripts Ñ Extension Background Page" then exit repeat
						if elTitle is equal to "Automatically Show Web Inspector for JSContexts" then exit repeat # checkboxes @ bottom
						if elTitle is equal to "Automatically Pause Connecting to JSContexts" then exit repeat
						if elTitle is equal to "Connect via Network" then exit repeat
						if elTitle ends with " Ñ _generated_background_page.html" then exit repeat # no generated background pages   --   last 34 chars === " Ñ _generated_background_page.html" (beginning 36 chars === "CB96A3CA-5A31-413B-AOFE-65A0D8CF3839") (34+36 = 70 chars total)
						# open anything else
						click el
						log elTitle
					end repeat
				end repeat
			end tell
		end tell
	end tell
end tell
