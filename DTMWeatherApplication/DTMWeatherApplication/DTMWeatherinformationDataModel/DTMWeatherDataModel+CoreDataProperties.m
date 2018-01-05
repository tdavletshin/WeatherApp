//
//  DTMWeatherDataModel+CoreDataProperties.m
//  DTMWeatherApplication
//
//  Created by user on 04.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//
//

#import "DTMWeatherDataModel+CoreDataProperties.h"

@implementation DTMWeatherDataModel (CoreDataProperties)

+ (NSFetchRequest<DTMWeatherDataModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DTMWeatherDataModel"];
}

@dynamic city_id;
@dynamic city_name;
@dynamic date;
@dynamic humidity;
@dynamic icon_id;
@dynamic pressure;
@dynamic rain_value;
@dynamic snow_value;
@dynamic temperature;
@dynamic wind_direction;
@dynamic wind_speed;

@end
