set brew to "/opt/homebrew/bin/brew"
set brewPackagesToUpdate to do shell script (brew & " outdated")

if brewPackagesToUpdate is equal to ""
	display dialog "Already up to date."
	return
end if

display dialog "Brew Packages with Updates:" & return & brewPackagesToUpdate buttons {"Update", "Cancel"} default button "Update" cancel button "Cancel"
set userChoice to button returned of the result

if userChoice is "Update" then
	display dialog (do shell script (brew & " update && " & brew & " upgrade"))
end if
