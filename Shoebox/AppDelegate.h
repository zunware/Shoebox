//
//  AppDelegate.h
//  Shoebox
//
//  Created by PP on 5/15/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MQTTClient.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, MQTTSessionDelegate>

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL darkModeOn;
@property NSPopover* pop_over;
@property NSMenu* menu;

-(void) closePopover:(id)sender;


@end

