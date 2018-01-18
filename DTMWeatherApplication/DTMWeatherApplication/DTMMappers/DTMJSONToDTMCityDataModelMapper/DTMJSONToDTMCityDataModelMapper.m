//
//  DTMJSONToDTMCityDataModelMapper.m
//  DTMWeatherApplication
//
//  Created by user on 12.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import "DTMJSONToDTMCityDataModelMapper.h"
#import "DTMCityDataModel.h"


@implementation DTMJSONToDTMCityDataModelMapper


+ (NSArray *)arrayOfDTMCityDataModelFromJSON:(NSData *)jsonData completionHandler:(DTMMapperCompletionBlock)completion
{
    NSError *error;
    NSArray *arrayFromJsonData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSMutableArray <DTMCityDataModel*> *preResultData = [NSMutableArray array];
    for(NSDictionary *dictionary in arrayFromJsonData)
    {
        DTMCityDataModel *dataModel = [[DTMCityDataModel alloc] init];
        dataModel.cityId = [dictionary[@"id"] longLongValue];
        dataModel.cityName = dictionary[@"name"];
        dataModel.countryName = dictionary[@"country"];
        
        [preResultData addObject:dataModel];
    }
    NSArray *resultData = [preResultData copy];
    if (completion)
    {
        completion(error);
    }
    return resultData;
}


@end
