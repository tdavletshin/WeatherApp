//
//  DTMWeatherDataModel+CoreDataProperties.m
//  DTMWeatherApplication
//
//  Created by user on 10.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//
//


#import "DTMWeatherDataModel+CoreDataProperties.h"


@implementation DTMWeatherDataModel (CoreDataProperties)


@dynamic city_id;
@dynamic city_name;
@dynamic date;
@dynamic humidity;
@dynamic icon_id;
@dynamic pressure;
@dynamic temperature;
@dynamic wind_direction;
@dynamic wind_speed;


+ (NSFetchRequest<DTMWeatherDataModel *> *)fetchRequest
{
	return [[NSFetchRequest alloc] initWithEntityName:@"DTMWeatherDataModel"];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"city_id: %lld\n city_name: %@\n date: %@\n humidity: %f\n icon_id: %@\n pressure: %f\n temperature: %f\n wind_direction: %f\n wind_speed: %f",
            self.city_id,
            self.city_name,
            self.date,
            self.humidity,
            self.icon_id,
            self.pressure,
            self.temperature,
            self.wind_direction,
            self.wind_speed];
}


@end
