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
@property (nullable, nonatomic, copy) NSString *city_name;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) double humidity;
@property (nullable, nonatomic, copy) NSString *icon_id;
@property (nonatomic) double pressure;
@property (nonatomic) double temperature;
@property (nonatomic) double wind_direction;
@property (nonatomic) double wind_speed;

+ (NSFetchRequest<DTMWeatherDataModel *> *)fetchRequest;

@end

NS_ASSUME_NONNULL_END
