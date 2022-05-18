# Install

After cloning, in the "BTT Settings" folder, open "triggers.bttpreset", then replace all:

&nbsp; &nbsp; &nbsp;"\\/Users\\/super\\/Desktop\\/important\\/SystemFiles\\/" &nbsp; --with the path you've placed the applescripts (and don't forget to add backslashes back in!)

Change line 1 of "cmd-w-close.applescript" to that same path (minus the blackslashes)

Compile all .applescript to .scpt by running &nbsp; `bash ./compile-all.sh`

and finally, import the triggers (in "BTT Settings" folder) to BetterTouchTool in order to use the scripts

&nbsp;

# Window management:

"click-cmd-cycle-windows" & "click-shift-file-new" gives Windows™️ dock behavior where holding shift/cmd while clicking a dock icon creates a new window / cycles an apps windows.

The cmd-m, cmd-w, & cmd-shift-w scripts minimize/close tabs or windows WITHOUT cycling (just like on Windows™️).

Note: if an app isn't closing, remap cmd+w/cmd+shift+w (for that specific app) on BTT to itself w/ "prevent recursive triggers" checked (for default behavior). And please raise an issue here. Cheers 🍺

&nbsp;

# BetterTouchTool features

[System Preferences Setup](https://www.youtube.com/channel/UCBcY4PTKNWXDXTt6RsHGRjQ/videos) (video coming soon)

## Global Keyboard Shortcuts

-   Autofocus textinput of many apps (eg: app store/maps/notes etc.) (With "/" or Cmd+/)
-   Cmd+Shift+E (reveal in finder / open Finder path in iTerm2/terminal)
-   Cmd+9 = switch to last space, Cmd+8 = switch to 2nd to last, Cmd 7 = switch to 3rd last
-   Cmd+0 = zoom 100%
-   Cmd+Option+Delete = Activity Monitor
-   Cmd+Control+B = Connect Airpods
-   Cmd+Option+Control+N = HTML/Network Inspector for mobile devices (Safari) (Must rename device se2020->yourdevicename)
-   Cmd+Control+[ or ] = Move mouse left/right whole monitor in pixels
-   Personal: I use f4 = show desktop, CapsLock = mission control (via karabiner elements)
-   Cmd+Option+LeftArrow or RightArrow = move to next/previous tab
-   Cmd+Option+Enter = Duplicate Tab (Safari/iTerm2)

## Trackpad Gestures

-   Tip tap to close window (middle, index, ring, and then pinky)
-   Corner click bottom left &&& 2 finger tap = right click
-   5 finger swipe left/right = move to tab previous / next tab
-   3 finger clickswipe up / down = Trigger (AltTab) Shortcut 1 & 2
-   4 finger swipe up/down = Show/Hide (AltTab) without switching apps
-   pinch with thumb and fingers = (Rectangle) restore default window size/position
-   spread with thumb and fingers = (Rectangle) maximize window

## Miscellaneous / Caveats

-   Double click menu whitespace = show desktop
-   Move mouse to Corner (right) = show desktop (with delay)
-   Cmd+Shift+H = hide on some apps (VSCode/text editors)
    -   Cmd+H = find/replace on these apps
-   Cmd+Shift+Q = quit on some apps (so I won't accidentally quit heavy apps)
    -   Cmd+Q will trigger Cmd+W (Safari/Xcode/few others)
