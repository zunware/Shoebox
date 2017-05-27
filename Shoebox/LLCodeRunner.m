//
//  LLCodeRunner.m
//  Shoebox
//
//  Created by PP on 5/27/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import "LLCodeRunner.h"

@implementation LLCodeRunner

+(id) getInstance {
    static LLCodeRunner* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    if(self = [super init]) {
        // Init here
    }
    
    return self;
}

-(NSString*)runPython:(NSString*)script_name {
    NSString* scriptPath = [[NSBundle mainBundle] pathForResource:script_name ofType:@"py"];
    if(scriptPath == nil){
        NSLog(@"Bad path");
        return nil;
    }
    
    NSTask* task = [[NSTask alloc] init];
    task.launchPath = @"/usr/local/bin/python";
    task.arguments = [NSArray arrayWithObjects:scriptPath, nil];
    
    [task setStandardInput:[NSPipe pipe]];
    
    NSPipe* std_out = [NSPipe pipe];
    [task setStandardOutput:std_out];
    
    NSPipe* std_err = [NSPipe pipe];
    [task setStandardError:std_err];
    
    // Launch the script
    [task launch];
    NSData* data = [[std_out fileHandleForReading] readDataToEndOfFile];
    [task waitUntilExit];
    
    int exit_code = task.terminationStatus;
    if(exit_code != 0){
        NSLog(@"Error");
        return nil;
    }
    
    return [[NSString alloc] initWithBytes:data.bytes
                                    length:data.length
                                  encoding:NSUTF8StringEncoding];
    
}

-(void)runBunchOfScripts {
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray* results = [NSMutableArray array];
    for(NSUInteger i = 0; i < 10; i++){
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString* result = [self runPython:@"test_python"];
            @synchronized (results) {
                [results addObject:result];
            }
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self scriptsFinishedWithResults:results];
    });
}

-(void)scriptsFinishedWithResults:(NSArray*)results {
    // Check the results for scripts here
    NSLog(@"%@", results);
}

@end
