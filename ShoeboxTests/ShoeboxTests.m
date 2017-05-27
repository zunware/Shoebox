//
//  ShoeboxTests.m
//  ShoeboxTests
//
//  Created by PP on 5/15/17.
//  Copyright © 2017 Llau Systems. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LLCodeRunner.h"

@interface ShoeboxTests : XCTestCase

@end

@implementation ShoeboxTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_run_python {
    XCTAssertNotNil([[LLCodeRunner getInstance] runPython:@"test_python"]);
}

-(void)test_run_bunch_of_scripts {
    [[LLCodeRunner getInstance] runBunchOfScripts];
}

@end
