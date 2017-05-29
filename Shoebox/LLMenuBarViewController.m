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
    NSLog(@"%@", [self.text_input stringValue]);
    
    // Clear the contents
    [self.text_input setStringValue:@""];

    AppDelegate *appDelegate = (AppDelegate *)[NSApp delegate];
    [appDelegate closePopover:self];
}
@end
