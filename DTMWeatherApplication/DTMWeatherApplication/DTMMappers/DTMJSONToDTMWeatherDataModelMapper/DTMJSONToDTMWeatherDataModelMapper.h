//
//  DTMJSONToDTMWeatherDataModelMapper.h
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef void (^DTMMapperCompletionBlock)(NSError *error);


@interface DTMJSONToDTMWeatherDataModelMapper : NSObject


+ (void)saveInCoreDataDTMWeatherDataModelFromJSON:(NSData *)json completionHandler:(DTMMapperCompletionBlock)completion;


@end
