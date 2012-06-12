//
//  AppController.h
//  LoLlock
//
//  Created by Jan Brdo on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MouseWatcher.h"

@interface AppController : NSObject {
    IBOutlet NSButton *lockButton;
    MouseWatcher *mouseWatcher;
    NSScreen *lockToScreen;
    NSRect lockToRect;
}

- (IBAction)lock:(id)sender;

@end
