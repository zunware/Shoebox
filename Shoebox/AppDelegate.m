//
//  AppDelegate.m
//  Shoebox
//
//  Created by PP on 5/15/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    

    // Insert code here to initialize your application
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage* image = [NSImage imageNamed:@"StatusBarImageButton"];
    if(image == NULL) {
        NSLog(@"Suck it");
    }
    [self.statusItem setImage:[NSImage imageNamed:@"StatusBarImageButton"]];
    [self.statusItem setAction:@selector(printQuote:)];
    
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void) printQuote:(id)sender {
    NSString* quoteText = @"Queso queso queso";
    NSString* quoteAuthor = @"Me";
    
    NSLog(@"%@ %@", quoteText, quoteAuthor);
}


@end
