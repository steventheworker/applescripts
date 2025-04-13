set mas to "/opt/homebrew/bin/mas" # mas (or: mac app store)
set masPackagesToUpdate to do shell script (mas & " outdated")

if masPackagesToUpdate is equal to "" then
	display dialog "Already up to date."
	return
end if

display dialog "Mac App Store Apps with Updates:" & return & masPackagesToUpdate buttons {"Update", "Cancel"} default button "Update" cancel button "Cancel"
set userChoice to button returned of the result

if userChoice is "Update" then
	display dialog (do shell script (mas & " upgrade"))
end if
