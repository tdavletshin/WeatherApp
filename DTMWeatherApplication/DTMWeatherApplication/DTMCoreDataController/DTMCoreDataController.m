//
//  DTMCoreDataController.m
//  DTMWeatherApplication
//
//  Created by user on 29.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import "DTMCoreDataController.h"

@implementation DTMCoreDataController

- (instancetype)init
{
    self = [super init];
    
    if (!self) return nil;
    
    _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DTMWeatherApplication"];
    [_persistentContainer loadPersistentStoresWithCompletionHandler:
     ^(NSPersistentStoreDescription *description, NSError *error)
    {
        if (error != nil)
        {
            //To do: replace abort with another action
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];
    return self;
}

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
