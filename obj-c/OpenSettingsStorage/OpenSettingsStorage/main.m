//
//  main.m
//  OpenSettingsStorage
//
//  Created by Steven G on 7/22/23.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"x-apple.systempreferences:com.apple.settings.Storage"]];
    }
    return 0;
}
