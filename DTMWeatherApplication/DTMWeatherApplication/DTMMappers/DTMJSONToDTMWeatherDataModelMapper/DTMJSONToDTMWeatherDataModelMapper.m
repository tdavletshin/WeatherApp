//
//  DTMJSONToDTMWeatherDataModelMapper.m
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMJSONToDTMWeatherDataModelMapper.h"
#import <CoreData/CoreData.h>
#import "DTMWeatherDataModel+CoreDataClass.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"
#import "DTMCoreDataController.h"

@interface DTMJSONToDTMWeatherDataModelMapper ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

@end

@implementation DTMJSONToDTMWeatherDataModelMapper

+ (void)saveInCoreDataDTMWeatherDataModelFromJSON:(NSData *)json completionHandler:(DTMMapperCompletionBlock)completion
{
    
    DTMCoreDataController *coreDataController = [DTMCoreDataController sharedController];
    NSPersistentContainer *container = coreDataController.persistentContainer;
    NSManagedObjectContext *coreDataContext = container.viewContext;
    
    NSError *error;
    
    NSDictionary *tmpDictionary = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    
    DTMWeatherDataModel *dataModel = [NSEntityDescription insertNewObjectForEntityForName:@"DTMWeatherDataModel" inManagedObjectContext:coreDataContext];
    
    dataModel.city_id = [tmpDictionary[@"id"] integerValue];
    dataModel.city_name = tmpDictionary[@"name"];
    dataModel.date = [NSDate date];
    dataModel.humidity = [tmpDictionary[@"main"][@"humidity"] doubleValue];
    dataModel.icon_id = tmpDictionary[@"weather"][0][@"icon"];
    dataModel.pressure = [tmpDictionary[@"main"][@"pressure"] doubleValue];
    dataModel.temperature = [tmpDictionary[@"main"][@"temp"] doubleValue];
    dataModel.wind_direction = [tmpDictionary[@"wind"][@"deg"] doubleValue];
    dataModel.wind_speed = [tmpDictionary[@"wind"][@"speed"] doubleValue];
    
    [dataModel.managedObjectContext save:&error];
    
    completion(error);
}



@end
