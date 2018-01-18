//
//  DTMJSONToDTMCityDataModelMapper.h
//  DTMWeatherApplication
//
//  Created by user on 12.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef void (^DTMMapperCompletionBlock)(NSError *error);


@interface DTMJSONToDTMCityDataModelMapper : NSObject


+ (NSArray *)arrayOfDTMCityDataModelFromJSON:(NSData *)jsonData completionHandler:(DTMMapperCompletionBlock)completion;


@end
