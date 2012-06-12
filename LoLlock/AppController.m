//
//  AppController.m
//  LoLlock
//
//  Created by Jan Brdo on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

@implementation AppController
// GetEventMonitorTarget
// CoreGraphics:CGEventTapCreate()
// CGEventTap
- (IBAction)lock:(id)sender {
    lockToScreen = [NSScreen mainScreen];
    lockToRect = [lockToScreen frame];
    mouseWatcher = [MouseWatcher watcher];    
}

- (IBAction)unlock:(id)sender {
    [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}
@end
