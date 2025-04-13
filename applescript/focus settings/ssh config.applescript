set appPath to "/Applications/MyApps/dev/Open With Vim.app"
set filePath to (POSIX path of (path to home folder)) & ".ssh/config"
do shell script "open -a '" & appPath & "' '" & filePath & "'"