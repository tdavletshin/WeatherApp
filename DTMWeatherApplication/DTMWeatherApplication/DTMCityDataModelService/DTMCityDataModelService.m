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
    
    NSString *nameOfFileWithData = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"city.list.json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile: nameOfFileWithData];
    
    NSArray *preGeneralData = [DTMJSONToDTMCityDataModelMapper arrayOfDTMCityDataModelFromJSON:jsonData completion:^(NSError *error)
    {
        
        // to do: catch an error!
    }];
    
    _generalData = [[NSArray alloc] initWithArray:preGeneralData copyItems:YES];
    _dataForTable = [[NSArray alloc] initWithArray:preGeneralData copyItems:YES];
    
    return self;
}


@end
