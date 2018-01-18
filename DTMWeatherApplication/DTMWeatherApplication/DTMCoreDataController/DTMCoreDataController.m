//
//  DTMCoreDataController.m
//  DTMWeatherApplication
//
//  Created by user on 29.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//


#import "DTMCoreDataController.h"
#import "AppDelegate.h"


@implementation DTMCoreDataController


static DTMCoreDataController *sharedInstance = nil;

+ (DTMCoreDataController *)sharedController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[DTMCoreDataController alloc] initSharedInstance];
    });
    return sharedInstance;
}

- (instancetype)initSharedInstance
{
    self = [super init];
    
    if (!self) return nil;
    
    _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DTMWeatherApplication"];
    [_persistentContainer loadPersistentStoresWithCompletionHandler:
     ^(NSPersistentStoreDescription *description, NSError *error)
    {
        if (error)
        {
            UIApplication *application = [UIApplication sharedApplication];
            AppDelegate *applocationDelegate = (AppDelegate *)application.delegate;
            UINavigationController *navigationController = applocationDelegate.navigationController;
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your action can not be done" message:[NSString stringWithFormat:@"Failed to load Core Data stack: %@", error] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [navigationController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:ok];
            [navigationController presentViewController:alert animated:YES completion:nil];
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
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *applocationDelegate = (AppDelegate *)application.delegate;
        UINavigationController *navigationController = applocationDelegate.navigationController;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your action can not be done" message:[NSString stringWithFormat:@"Unresolved error of Core Data stack: %@", error] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [navigationController presentViewController:alert animated:YES completion:nil];
    }
}


@end
