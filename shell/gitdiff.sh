printf "\033]1337;ClearScrollback\007" # https://unix.stackexchange.com/questions/320180/tell-fswatch-to-clear-screen-before-running-command
git diff | grep '^[+-]' | grep -Ev '^(--- a/|\+\+\+ b/)'
# git diff --unified=0
# git diff -U0 | grep '^[+-]' | grep -Ev '^(--- a/|\+\+\+ b/)'