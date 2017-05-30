//
//  AppDelegate.m
//  Shoebox
//
//  Created by PP on 5/15/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import "AppDelegate.h"
#import "LLCodeRunner.h"
#import "LLMenuBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    NSImage* image = [NSImage imageNamed:@"StatusBarImageButton"];
    if(image == NULL) {
        NSLog(@"Bad image");
    }
    // [self setupenu];
    [self.statusItem setImage:[NSImage imageNamed:@"StatusBarImageButton"]];
    [self.statusItem.button setAction:@selector(togglePopover:)];
    self.pop_over = [[NSPopover alloc] init];
    [self.pop_over setContentViewController:
    [[LLMenuBarViewController alloc] initWithNibName:@"LLMenuBarViewController" bundle:nil]];
    
    // Setup MQTT
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = @"192.168.5.137";
    transport.port = 1883;

    MQTTSession *session = [[MQTTSession alloc] init];
    session.transport = transport;
	session.delegate = self;
	[session connectAndWaitTimeout:30];
    
    NSString* payload = @"Hola que ase?";
    [session publishAndWaitData:[payload dataUsingEncoding:NSUTF8StringEncoding]
                    onTopic:@"topic"
                     retain:NO
	                qos:MQTTQosLevelAtLeastOnce]; // this is part of the asynchronous API

}

-(void)setupMenu {
    
    self.menu = [[NSMenu alloc] init];

    NSMenuItem* first_item = [[NSMenuItem alloc] initWithTitle:@"Run Python"
                                                        action:@selector(runPythonScript:)
                                                 keyEquivalent:@"P"];
    
    NSMenuItem* runCommandItem = [[NSMenuItem alloc] initWithTitle:@"Run Terminal"
                                                            action:@selector(openTerminal:)
                                                     keyEquivalent:@"R"];
    
    NSMenuItem* getInputItem = [[NSMenuItem alloc] initWithTitle:@"Get Input"
                                                            action:@selector(getInput:)
                                                     keyEquivalent:@"I"];
    
    NSMenuItem* showPopoverMenuItem = [[NSMenuItem alloc] initWithTitle:@"Show Popover"
                                                            action:@selector(showPopover:)
                                                     keyEquivalent:@"S"];
    
    
    NSMenuItem* second_item = [[NSMenuItem alloc] initWithTitle:@"Quit Program" action:@selector(terminate:) keyEquivalent:@"q"];
    
    [self.menu addItem:first_item];
    [self.menu addItem:runCommandItem];
    [self.menu addItem:getInputItem];
    [self.menu addItem:showPopoverMenuItem];
    [self.menu addItem:[NSMenuItem separatorItem]];
    [self.menu addItem:second_item];
    
    [self.statusItem setMenu:self.menu];
}

-(void) showPopover:(id)sender {
    NSButton* b = self.statusItem.button;
    if(b != nil) {
        [self.pop_over showRelativeToRect:b.bounds ofView:b preferredEdge:NSMinYEdge];
    }
}

-(void) closePopover:(id)sender {
    [self.pop_over performClose:sender];
}

-(void)openMenu:(id)sender {
    if([self.pop_over isShown])
    {
        [self closePopover:sender];
    }
    
    if([NSMenu menuBarVisible]) {
        [self.menu cancelTracking];
    } else {
        [self.statusItem popUpStatusItemMenu:self.menu];
    }
    
    
}

-(void)togglePopover:(id)sender
{
    if([self.pop_over isShown])
    {
        [self closePopover:sender];
    }
    else
    {
        [self showPopover:sender];
    }
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

-(void)runCommandWithAppleScript:(id)sender {
    NSString* command = @"pwd";
    NSString *s = [NSString stringWithFormat:
     @"tell application \"Terminal\" to do script \"%@\"", command];

    NSAppleScript *as = [[NSAppleScript alloc] initWithSource: s];
    
    [as executeAndReturnError:nil];
}

-(void)openTerminal:(id)sender {
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
        NSLog(@"%@", inputThing);
    } else if (button == NSAlertSecondButtonReturn) {
        // The user cancelled
    }
}



@end
