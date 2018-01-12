//
//  DTMCityDataModel.m
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMCityDataModel.h"

@implementation DTMCityDataModel

- (id)copyWithZone:(nullable NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy)
    {
        // Copy NSObject subclasses
        [copy setCityName:[self.cityName copyWithZone:zone]];
        [copy setCountryName:[self.countryName copyWithZone:zone]];
        
        // Set primitives
        [copy setCityId:self.cityId];
    }
    return copy;
}

@end
