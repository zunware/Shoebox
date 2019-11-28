//
//  LLMenuBarViewController.m
//  Shoebox
//
//  Created by PP on 5/28/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import "LLMenuBarViewController.h"
#import "AppDelegate.h"

@interface LLMenuBarViewController ()
@end

@implementation LLMenuBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup font
    [self.text_input setFont:[NSFont fontWithName:@"Operator Mono Book" size:13]];
    
}

- (IBAction)okPressed:(id)sender {
    NSString* command = [self.text_input stringValue];
    NSLog(@"%@", [self.text_input stringValue]);
    
    // Clear the contents
    [self.text_input setStringValue:@""];
    
    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    
    if( [command hasPrefix:@"terminal"]) {
        NSArray* wordInputs = [command componentsSeparatedByString:@"terminal"];
        if([[wordInputs firstObject] isEqualToString:@""]){
            if( [wordInputs count] > 1) {
                // Parse Arguments separated by space
                NSArray* args = [[wordInputs objectAtIndex:1] componentsSeparatedByString:@" "];
                if([[args objectAtIndex:1] isEqualToString:@"ux"]){
                    NSString* project = [args objectAtIndex:2];
                    [appDelegate runCommandWithAppleScript:self];
                }
                
            } else {
                // Just launch terminal
                [appDelegate openTerminal:self];
            }
        } else {
            // Matches prefix, but not command!
            // TODO: Did you mean?
        }
    } else if ( [command hasPrefix:@"python"] ){
        
    }

    // Close it at the end
    [appDelegate closePopover:self];
}
@end
