//
//  LLMenuBarViewController.h
//  Shoebox
//
//  Created by PP on 5/28/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LLMenuBarViewController : NSViewController

- (IBAction)okPressed:(id)sender;

@property (weak) IBOutlet NSTextField *text_input;


@end
