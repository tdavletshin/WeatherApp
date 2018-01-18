//
//  DTMCityDataModelService.m
//  DTMWeatherApplication
//
//  Created by user on 12.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import "DTMCityDataModelService.h"
#import "DTMJSONToDTMCityDataModelMapper.h"


static DTMCityDataModelService *sharedInstance = nil;


@interface DTMCityDataModelService ()


@property (nonatomic, copy, nonnull) NSArray <DTMCityDataModel *> *generalData;


@end


@implementation DTMCityDataModelService


#pragma mark - Lifecycle

+ (DTMCityDataModelService *_Nonnull)sharedService
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
    ^{
        sharedInstance = [[DTMCityDataModelService alloc] initSharedInstance];
    });
    return sharedInstance;
}

-(instancetype) initSharedInstance
{
    self = [super init];
    
    if (!self) return nil;
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        NSString *nameOfFileWithData = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"city.list.json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile: nameOfFileWithData];
        
        NSArray *preGeneralData = [DTMJSONToDTMCityDataModelMapper arrayOfDTMCityDataModelFromJSON:jsonData completionHandler:^(NSError *error) {}];
        
        _generalData = preGeneralData;
        _dataForTable = [[NSArray alloc] initWithArray:preGeneralData copyItems:YES];
    });
    
    return self;
}

-(instancetype) initSharedInstanceWithFakeData
{
    self = [super init];
    
    if (!self) return nil;
    
    DTMCityDataModel *fakeModel = [[DTMCityDataModel alloc] init];
    fakeModel.cityId = 131313;
    fakeModel.cityName = @"FakeCityName";
    fakeModel.countryName = @"FakeCountryName";
    
    _dataForTable = [NSArray arrayWithObject:fakeModel];
    _generalData = [NSArray arrayWithObject:fakeModel];
    
    return self;
}


#pragma mark - Update Data For Table for search text

- (void)updateDataForTableForSearchText:(NSString *) searchText
{
    if ([searchText isEqualToString:@""])
    {
        self.dataForTable = self.generalData;
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cityName contains %@",searchText];
    NSArray *newDataForTable = [NSMutableArray arrayWithArray:[self.generalData filteredArrayUsingPredicate:predicate]];
    self.dataForTable = newDataForTable;
}


@end
