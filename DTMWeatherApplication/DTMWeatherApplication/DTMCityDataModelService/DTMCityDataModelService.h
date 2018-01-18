//
//  DTMCityDataModelService.h
//  DTMWeatherApplication
//
//  Created by user on 12.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DTMCityDataModel.h"


@interface DTMCityDataModelService : NSObject


@property (nonatomic, copy, nonnull) NSArray <DTMCityDataModel *> *dataForTable;


+ (DTMCityDataModelService *_Nonnull)sharedService;
- (void)updateDataForTableForSearchText:(NSString *_Nonnull) searchText;


@end
