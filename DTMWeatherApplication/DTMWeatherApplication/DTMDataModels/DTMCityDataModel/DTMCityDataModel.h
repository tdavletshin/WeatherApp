//
//  DTMCityDataModel.h
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTMCityDataModel : NSObject <NSCopying>

@property (nonatomic, copy, nonnull) NSString *cityName;
@property (nonatomic, copy, nonnull) NSString *countryName;
@property (nonatomic, assign) int64_t cityId;

@end
