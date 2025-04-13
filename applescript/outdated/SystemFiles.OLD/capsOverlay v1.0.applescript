-- use framework "Foundation"

set shouldTriggerEscape to 0.0
set shouldShowDesktop to 0.0
tell application "BetterTouchTool"
	-- set now to current application's NSProcessInfo's processInfo()'s systemUptime()
	
	# get state & last run time
	set state to get_number_variable "capsOverlayState"
	-- set lastT to get_number_variable "lastShowCapsOverlayT"
	if state is missing value then
		set_number_variable "capsOverlayState" to 0.0
		set state to 0.0
	end if
	-- if lastT is missing value then
	-- 	set_number_variable "lastShowCapsOverlayT" to now
	-- 	set lastT to now
	-- end if
	
	# misc fn
	if state is equal to 2.0 then
		set shouldTriggerEscape to 1.0
		set state to 0.0
	end if
	if state is equal to 3.0 then
		set shouldShowDesktop to 1.0
		set state to 0.0
	end if
	
	
	# update btt variables
	if state is equal to 0.0 then
		set_number_variable "capsOverlayState" to 1.0
	end if
	
	# based on time
	-- set diff to now - lastT
	-- if diff >= 7.2 then set state to 0.0 #probably closed the overlay other way than this script (get ready for new preview (eg: reset state to 0)
	#if diff >= 4 then
	#	set state to 1.0 #probably afk with overlay still open (5minutes w/o triggering script)
	#	set_number_variable "lastShowCapsOverlayT" to now
	#end if
	
	-- if state is equal to 0.0 then set_number_variable "lastShowCapsOverlayT" to now
	if state is equal to 1.0 then
		set_number_variable "capsOverlayState" to 0.0
	end if
end tell

# send events
tell application "System Events"
	if shouldTriggerEscape is equal to 1.0 then
		set state to 0.0
		key code 53 #esc
		delay 0.3
	end if
	if shouldShowDesktop is equal to 1.0 then
		set state to 0.0
		key code 118 #f4
		delay 0.3
	end if
	if state is equal to 0.0 then
		# show AltTab
		-- key code 48 using {command down} #Show AltTab (cmd+tab)
		-- delay 0.008
		-- key code 123 #leftArrow
		set Storage to do shell script "/opt/homebrew/bin/cliclick p"
		do shell script "/opt/homebrew/bin/cliclick m:0,0"
		key code 160 # f3 (show mission control)
		do shell script "/opt/homebrew/bin/cliclick m:" & Storage
	end if
	-- if state is equal to 1.0 then key code 55 #cmd (hide AltTab)
	if state is equal to 1.0 then key code 53 #esc
end tell
