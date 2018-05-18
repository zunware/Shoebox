//
//  LLCodeRunner.h
//  Shoebox
//
//  Created by PP on 5/27/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLCodeRunner : NSObject

+(id)getInstance;

-(NSString*)runPythonFromPath:(NSString*)path;
-(NSString*)runPythonFromResources:(NSString*)script_name;
-(void)runBunchOfScripts;
-(void)launchTerminal;

@end
