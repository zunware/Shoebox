//
//  AppDelegate.m
//  Shoebox
//
//  Created by PP on 5/15/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import "AppDelegate.h"
#import "LLCodeRunner.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage* image = [NSImage imageNamed:@"StatusBarImageButton"];
    if(image == NULL) {
        NSLog(@"Bad image");
    }
    [self.statusItem setImage:[NSImage imageNamed:@"StatusBarImageButton"]];
    
    NSMenu* menu = [[NSMenu alloc] init];
    
    NSMenuItem* first_item = [[NSMenuItem alloc] initWithTitle:@"Run Python"
                                                        action:@selector(runPythonScript:)
                                                 keyEquivalent:@"P"];
    
    NSMenuItem* runCommandItem = [[NSMenuItem alloc] initWithTitle:@"Run Terminal"
                                                            action:@selector(openTerminal:)
                                                     keyEquivalent:@"R"];
    
    NSMenuItem* getInputItem = [[NSMenuItem alloc] initWithTitle:@"Get Input"
                                                            action:@selector(getInput:)
                                                     keyEquivalent:@"I"];
    
    
    NSMenuItem* second_item = [[NSMenuItem alloc] initWithTitle:@"Quit Program" action:@selector(terminate:) keyEquivalent:@"q"];
    
    [menu addItem:first_item];
    [menu addItem:runCommandItem];
    [menu addItem:getInputItem];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:second_item];
    
    [self.statusItem setMenu:menu];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void) runPythonScript:(id)sender {
    NSString* return_code = [[LLCodeRunner getInstance] runPythonFromResources:@"test_python"];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:return_code];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert runModal];
}

-(void)openTerminal:(id)sender {
//    NSString* command = @"pwd";
//    NSString *s = [NSString stringWithFormat:
//     @"tell application \"Terminal\" to do script \"%@\"", command];

//    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: s];
    
//    [as executeAndReturnError:nil];

    [[LLCodeRunner getInstance] launchTerminal];
}

-(void)getInput:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Some input?"];
    [alert addButtonWithTitle:@"Ok"];
    [alert addButtonWithTitle:@"Cancel"];

    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input setStringValue:@""];
    [alert setAccessoryView:input];
    NSInteger button = [alert runModal];
    if (button == NSAlertFirstButtonReturn) {
        NSString* inputThing = [input stringValue];
    } else if (button == NSAlertSecondButtonReturn) {
        // The user cancelled
    }
}



@end
