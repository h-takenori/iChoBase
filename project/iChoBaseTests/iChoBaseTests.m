//
//  iChoBaseTests.m
//  iChoBaseTests
//
//  Created by 平尾 毅雅 on 12/04/07.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "iChoBaseTests.h"
#import "ChoBase.h"
@implementation iChoBaseTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    for(int i=0 ; i < 100 ; i ++){
        [[ChoBase cb] setS:@"val" key_s:@"k"];
    }
    STAssertTrue([@"val" isEqualToString:[[ChoBase cb] s:@"k"]],@"check value" );

    [[ChoBase cb] del:@"k"];
    STAssertFalse([[ChoBase cb]hasKey:@"k"],@"check is deleted" );
    
    
}

@end
