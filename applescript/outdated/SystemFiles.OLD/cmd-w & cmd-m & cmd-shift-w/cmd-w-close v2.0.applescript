# if document/tab app - only close tabs (not windows) (apps SHOULD handle closing windows @ last/single tab)
# handle: Xcode, Visual Studio Code, Terminal, Safari, PyCharm, Maps, iTerm2, Firefox, Finder, Adobe Photoshop & Illustrator & Premiere 2021
# else close window
# check apps that should be quit after closing @ zero windows
# handle: Activity Monitor, Apollo, Calendar, Maps, Messages, Notes, Preview, Sublime Text, Terminal, TextEdit

# use to close tab (or if number of windows unchanged (like color picker window (impossible to close!!)))
tell application "BetterTouchTool" to trigger_named "commandW"
