# Install

After cloning, in the "BTT Settings" folder, open "triggers.bttpreset", then replace all:

&nbsp; &nbsp; &nbsp;"\\/Users\\/super\\/Desktop\\/important\\/SystemFiles\\/" &nbsp; --with the path you've placed the applescripts (and don't forget to add backslashes back in!)

Change line 1 of "cmd-w-close.applescript" to that same path (minus the blackslashes)

Compile all .applescript to .scpt by running &nbsp; `bash ./compile-all.sh`

and finally, import the triggers (in "BTT Settings" folder) to BetterTouchTool in order to use the scripts

&nbsp;

&nbsp;

# Window management:

"click-cmd-cycle-windows" & "click-shift-file-new" gives Windows™️ dock behavior where holding shift while clicking a dock icon gives a new window & holding cmd (while clicking) will cycle windows.

The cmd-m, cmd-w, & cmd-shift-w scripts minimize/close tabs or windows WITHOUT cycling (just like on Windows™️).

Note: if an app doesn't work, remap on BTT cmd-w/cmd-shift-w to send a keyboard shortcut w/ "prevent recursive triggers" checked (for default behavior). And please raise an issue here.
