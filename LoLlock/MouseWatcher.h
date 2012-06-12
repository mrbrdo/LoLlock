//
//  EJEjectKeyWatcher.h
//  Ejectulate
//
//  Created by Nolan Waite on 10-12-04.
//  Copyright 2010 Nolan Waite. All rights reserved.
//

#import <Cocoa/Cocoa.h>


// Sends delegate a message when the eject key is pressed (unmodified).
@interface MouseWatcher : NSObject
{
    CFMachPortRef eventTap;
}

// Returns autoreleased instance using default initializer.
+ (id)watcher;

@end
