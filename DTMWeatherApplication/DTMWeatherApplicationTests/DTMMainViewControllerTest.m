//
//  DTMMainViewControllerTest.m
//  DTMWeatherApplicationTests
//
//  Created by user on 10.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>
#import "DTMMainViewController.h"

@interface DTMMainViewControllerTests : XCTestCase

@property (nonatomic, strong) DTMMainViewController* mainViewController;

@end

@implementation DTMMainViewControllerTests

- (void)setUp
{
    [super setUp];
    self.mainViewController = OCMPartialMock([[DTMMainViewController alloc] init]);
}

- (void)tearDown
{
    self.mainViewController = nil;
    [super tearDown];
}

- (void)testMethod
{
   
}

@end
