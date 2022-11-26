# Install

1. After cloning, in the "BTT Settings" folder, open "triggers.bttpreset", then replace all:

&nbsp; &nbsp; &nbsp;"\\/Users\\/super\\/Desktop\\/important\\/SystemFiles\\/" &nbsp; --with the path you've placed the applescripts (and don't forget to add backslashes back in!)

2. Change APPLESCRIPTS_FOLDER in "afterBTTLaunched.applescript" to that same path (minus the blackslashes)

3. Compile all .applescript to .scpt by running &nbsp; `bash ./compile-all.sh`

4. and finally, import the triggers (in "BTT Settings" folder) to BetterTouchTool in order to use the scripts

&nbsp;

# Windows™ window management: (requires [AltTab mod](https://github.com/steventheworker/alt-tab-macos/releases/download/1.1/DockAltTab.AltTab.v6.46.1.zip))

🟢 (green-button-click.applescript) clicking the green button will maximize the windows or restore the old window size & position like on Windows™ (w/ exceptions eg: Finder QuickLook Preview windows)

The 🌕 cmd-m, 🔴 cmd-w, & cmd-shift-w scripts minimize/close tabs or windows WITHOUT cycling (just like on Windows™).

🖱️ "click-cmd-cycle-windows" & "click-shift-file-new" &nbsp; &nbsp; &nbsp;--holding shift/cmd while clicking a dock icon creates a new window / cycles an apps windows

**<u>Troubleshoot</u>**: if an apps tabs or popup windows aren't closing (unimplemented in the script), remap cmd+w/cmd+shift+w (for that specific app) on BTT to cmd+w w/ "prevent recursive triggers" checked (for default behavior). And [report it!](https://github.com/steventheworker/applescripts/issues) &nbsp; &nbsp; --or disable BTT with [Fn + Ctrl + Opt + Cmd + D], close the window, and use the shortcut again to reenable BTT

&nbsp;

# BetterTouchTool bindings

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

-   always show spaces thumbnails in mission control
-   show desktop: (Fn+D)
    -   Double click menu whitespace
    -   Move mouse to Corner (right) (peak w/ delay using sceenhook)
-   Cmd+Shift+H = hide on some apps (VSCode/text editors)
    -   Cmd+H = find/replace on these apps
-   Cmd+Shift+Q = quit on some apps (so I won't accidentally quit heavy apps)
    -   Cmd+Q will trigger Cmd+W (Safari/Xcode/few others)
-   Multiple instances of VLC / Blender (line 1 (APP_PATH) in click-shift-file-new)
-   Alt+Drag to move window around

Finder

-   Cmd+Opt+N = new file prompt
-   Cmd+Opt+T = new blank typescript file prompt
-   Enter = Open file/app
-   Cmd+I => Cmd+Opt+I &nbsp; &nbsp; && &nbsp; &nbsp; Cmd+Opt+I => Cmd+I &nbsp; &nbsp; (prevent multiple info popups for selected items)

## "SteviaOS" -aka the almagamation of these files and these apps:

-   required:
    -   **[BetterTouchTool](https://folivora.ai/)** &nbsp; &nbsp; --most scripts don't rely much, if at all on BTT and can be rewritten to work with other automation apps (eg: [Karabiner Elements](https://github.com/pqrs-org/Karabiner-Elements) (for mouse & key bindings only))
    -   **[scriptable AltTab](https://github.com/steventheworker/alt-tab-macos/releases/)**
        -   (global Keyboard Shortcuts) change the behavior of cmd-shift-w, cmd-w, cmd-m (cycle macOS windows like Windows™)
        -   (BTT trackpad gestures) 4 swipe up/down &nbsp; &nbsp;--displays AltTab (all/single app view)
        -   (BTT trackpad gestures) 3 clickswipe up/down &nbsp; &nbsp; --displays AltTab (all/single app view) &nbsp; &nbsp; &nbsp;... waits 250 milliseconds & triggers a switch (select 1st preview in list)
    -   **[screenhook](https://github.com/steventheworker/screenhook)** (listen to clicks without modifers / on the corners of the screen & run applescripts when monitors are attached)
        -   used in "cornerRightTowards" Desktop peak (BTT named triggers) &nbsp; &nbsp; --keep Desktop Exposé showing even after "cornerRightAway" triggers
        -   when monitor is attached: run applescript to clean/sort desktop icons
    -   [Rectangle](https://rectangleapp.com/) (or whatever lets you map Cmd+Opt+Enter => maximize window & Cmd+Opt+Delete => restore window size) &nbsp; --used in green-button-click.applescript
-   recommended:
    -   DockAltTab

## ... and these System Settings

-   F4 = show desktop (via karabiner elements (via simple modifications tab))
-   Trackpad -> More Gesture -> Mission Control Off
-   Trackpad -> More Gesture -> App Exposé Off
    -   handled by BTT
