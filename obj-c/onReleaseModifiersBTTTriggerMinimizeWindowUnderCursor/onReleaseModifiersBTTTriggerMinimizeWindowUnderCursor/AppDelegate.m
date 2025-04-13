//
//  AppDelegate.m
//  onReleaseModifiersBTTTriggerMinimizeWindowUnderCursor
//
//  Created by Steven G on 8/18/23.
//

// minimize window under cursor trigger doesn't work unless 0 modifiers are down when called
// app runs until option key released, if not held down: ends immediately
// (debug build) symbolically linked to /Users/super/Desktop/important/SystemFiles

#import "AppDelegate.h"
#import <Cocoa/Cocoa.h>

void* monitor = nil;

void exitProcess(void) {[NSApp terminate:nil];}
NSString* runApplescript(NSString* scriptTxt) {
    NSDictionary *error = nil;
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource: scriptTxt];
    if (error) {
        NSLog(@"run error: %@", error);
        return @"";
    }
    return [[script executeAndReturnError:&error] stringValue];
}

void onRelease(void) {
    runApplescript(@"tell application \"BetterTouchTool\" to trigger_named \"onReleaseModifiersBTTTriggerMinimizeWindowUnderCursor\"");
    exitProcess();
}


@interface AppDelegate ()
@property (strong) IBOutlet NSWindow *window;
@end
@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3000 * 1000000L), dispatch_get_main_queue(), ^{
        // timeout
        NSLog(@"timed out");
        exitProcess();
    });
    __block BOOL optionKeyDown = YES; // no way to check on finish launching, assume this app is called while some modifier is held
    monitor = (__bridge void *)([NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskFlagsChanged handler:^(NSEvent *event) {
        if (event.modifierFlags & NSEventModifierFlagOption) {
            optionKeyDown = YES;
        } else {
            optionKeyDown = NO;
            onRelease();
        }
    }]);
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    if (monitor) [NSEvent removeMonitor: (__bridge id _Nonnull)(monitor)];
}
@end
