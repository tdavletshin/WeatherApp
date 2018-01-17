//
//  DTMWeatherDataModel+CoreDataProperties.h
//  DTMWeatherApplication
//
//  Created by user on 10.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//
//

#import "DTMWeatherDataModel+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTMWeatherDataModel (CoreDataProperties)

@property (nonatomic) int64_t city_id;
@property (nonatomic, copy, nullable) NSString *city_name;
@property (nonatomic, copy, nullable) NSDate *date;
@property (nonatomic) double humidity;
@property (nonatomic, copy, nullable) NSString *icon_id;
@property (nonatomic) double pressure;
@property (nonatomic) double temperature;
@property (nonatomic) double wind_direction;
@property (nonatomic) double wind_speed;

+ (NSFetchRequest<DTMWeatherDataModel *> *)fetchRequest;

@end

NS_ASSUME_NONNULL_END
