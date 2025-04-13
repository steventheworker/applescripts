# helper - debugging click-cmd-cycle   --when dock on left/right on external monitor, it doesn't work (due to position/margin (of the monitor?))

-- tell application "Firefox" to activate
set pathStr to "Macintosh HD:users:super:Desktop:important:SystemFiles:click-cmd-cycle-windows.scpt"
set p to POSIX path of pathStr
log (run script p)
delay 1
log (run script p)
delay 1
log (run script p)
delay 1
log (run script p)
