// compile it with swiftc in terminal and then run output binary as shell script within BetterTouchTool.
import Cocoa

func reclaimFocus() {
	let options = CGWindowListOption(arrayLiteral: CGWindowListOption.excludeDesktopElements, CGWindowListOption.optionOnScreenOnly)
	let windowListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
	guard
	let infoList = windowListInfo as NSArray? as? [[String: AnyObject]] else {
		return
	}
	if let window = infoList.first(where: { ($0["kCGWindowLayer"] as? Int32) == 0 }), let pid = window["kCGWindowOwnerPID"] as? Int32 {
		let app = NSRunningApplication(processIdentifier: pid)
		app?.activate(options: .activateIgnoringOtherApps)
	} else {
		let finder = NSRunningApplication.runningApplications(withBundleIdentifier: "com.apple.finder")
		finder[0].activate(options: .activateIgnoringOtherApps)
	}
}

reclaimFocus()
