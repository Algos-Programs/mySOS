//
//  mySOSTests.m
//  mySOSTests
//
//  Created by Marco Velluto on 06/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "mySOSTests.h"
#import "FirstViewController.h"
#import <CoreLocation/CoreLocation.h>
@implementation mySOSTests

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
    STFail(@"Unit tests are not implemented yet in mySOSTests");
}

- (void)testLocation {
    
    FirstViewController *fv = [[FirstViewController alloc] init];
    CLLocation *location = [[CLLocation alloc] init];
    location = [fv findCurrentLocation];
    [fv sendMessageWithNumbers:[[NSArray alloc] initWithObjects:@"3460602722", nil] withText:@"Aiuto!!!" withLocation:location];

}

@end
