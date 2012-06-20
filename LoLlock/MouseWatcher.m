//
//  EJEjectKeyWatcher.m
//  Ejectulate
//
//  Created by Nolan Waite on 10-12-04.
//  Copyright 2010 Nolan Waite. All rights reserved.
//

#import "MouseWatcher.h"


@interface MouseWatcher ()

// Enable the event tap, installing it first if needed.
- (void)listenForEject;

@end


@implementation MouseWatcher

#if 0
#pragma mark -
#pragma mark Properties
#endif

#if 0
#pragma mark -
#pragma mark Init
#endif

- (id)init
{
    if ((self = [super init]))
    {
        [self listenForEject];
    }
    return self;
}

+ (id)watcher
{
    return [[[self alloc] init] autorelease];
}

#if 0
#pragma mark -
#pragma mark Event tap
#endif


CGFloat snapTo(CGFloat value, CGFloat minValue, CGFloat size) {
    CGFloat newValue = value;
    if (newValue < minValue) newValue = minValue;
    if (newValue >= (minValue+size)) newValue = (minValue+size) - 1;
    return newValue;
}

static NSScreen *lockToScreen;
static NSRect lockToRect;

// Thanks to Kevin Gessner's post on CocoaDev for the code in the following 
// function and its following method.
// http://www.cocoabuilder.com/archive/cocoa/222356-play-pause-rew-ff-keys.html
static CGEventRef MouseMoveCallback(CGEventTapProxy proxy, 
                                    CGEventType type,
                                    CGEventRef event,
                                    void *refcon)
{
    // For whatever reason the system seems to disable the event tap after a few 
    // minutes without being used (or maybe after being enabled, not sure). If 
    // that happens, just reenable it and all's well.
    if (type == kCGEventTapDisabledByTimeout)
    {
        [(MouseWatcher *)refcon listenForEject];
        return NULL;
    }
    
    if (kCGEventMouseMoved & type) {
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		if (refcon) {
            CGPoint point = CGEventGetLocation(event);
            CGPoint target = CGPointMake(point.x,point.y);
            target.x = snapTo(point.x, lockToRect.origin.x, lockToRect.size.width);
            target.y = snapTo(point.y, lockToRect.origin.y, lockToRect.size.height);
            if (point.x != target.x || point.y != target.y) {
                CGWarpMouseCursorPosition(target);
            }
		}
		[pool drain];
	}
    // return NULL;
    return event;
}

#if 0
#pragma mark -
#pragma mark API
#endif

- (void)listenForEject
{
    if (!eventTap)
    {
        lockToScreen = [NSScreen mainScreen];
        lockToRect = [lockToScreen frame];
        CGEventMask eventMask = CGEventMaskBit(kCGEventMouseMoved);
        CGSetLocalEventsSuppressionInterval(0.0);
        eventTap = CGEventTapCreate(kCGSessionEventTap, kCGHeadInsertEventTap, 0,
                                    eventMask, MouseMoveCallback, self);
        if (!eventTap)
        {
            NSLog(@"%@ no tap; universal access?", NSStringFromSelector(_cmd));
            return;
        }
        CFRunLoopSourceRef runLoopSource = CFMachPortCreateRunLoopSource(NULL,
                                                                         eventTap, 0);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, 
                           kCFRunLoopCommonModes);
        CFRelease(runLoopSource);
    }
    CGEventTapEnable(eventTap, true);
}

@end
