//
//  DTMCoreDataController.h
//  DTMWeatherApplication
//
//  Created by user on 29.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DTMCoreDataController : NSObject


@property (strong, nonatomic) NSPersistentContainer *persistentContainer;


+ (DTMCoreDataController *)sharedController;
- (void)saveContext;


@end
