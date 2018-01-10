//
//  DTMMainTableViewTests.m
//  DTMWeatherApplicationTests
//
//  Created by user on 10.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>
#import "DTMMainTableViewCell.h"

static NSString *const DTMTestCityName = @"London";

@interface DTMMainTableViewCellTests : XCTestCase

@property (nonatomic, strong) DTMMainTableViewCell *cell;

@end

@implementation DTMMainTableViewCellTests

- (void)setUp
{
    [super setUp];
    self.cell = OCMPartialMock([[DTMMainTableViewCell alloc] init]);
}

- (void)tearDown
{
    self.cell = nil;
    [super tearDown];
}

- (void)testHeightForCellForCityName
{
    CGFloat height = [DTMMainTableViewCell heightForCellForCityName:DTMTestCityName];
    
    expect(height).toNot.equal(0);
    expect(height).beGreaterThanOrEqualTo(1);
}

@end


//+ (CGFloat)heightForCellForCityName: (NSString *_Nonnull)cityName
//{
//    DTMMainTableViewCell *testCell = [[DTMMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IDENTIFY"];
//
//    testCell.cityLabel.text = cityName;
//    testCell.dateLabel.text = DTMTestDate;
//
//    [testCell layoutSubviews];
//
//    CGFloat height = testCell.cityLabel.frame.size.height + testCell.dateLabel.frame.size.height + 3 * DTMElementsOffset;
//
//    if (CGRectGetMaxY(testCell.imageView.frame) > height) return CGRectGetMaxY(testCell.imageView.frame);
//
//        return height;
//}
//





