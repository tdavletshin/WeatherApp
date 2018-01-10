//
//  DTMJSONToDTMWeatherDataModelMapper.m
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMJSONToDTMWeatherDataModelMapper.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "DTMWeatherDataModel+CoreDataClass.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"

@interface DTMJSONToDTMWeatherDataModelMapper ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

@end

@implementation DTMJSONToDTMWeatherDataModelMapper

+ (void)saveInCoreDataDTMWeatherDataModelFromJSON:(NSData *)json competion:(DTMMapperCompletionBlock)completion
{
    
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *) (application.delegate)).coreDataController.persistentContainer;
    NSManagedObjectContext *coreDataContext = container.viewContext;
    
    NSError *error;
    
    NSDictionary *tmpDictionary = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"3RROЯ WITH SERIALIZATIOИ!!!");
        exit(0);
    }
    
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
