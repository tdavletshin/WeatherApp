//
//  AppDelegate.m
//  DTMWeatherApplication
//
//  Created by user on 24.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import "AppDelegate.h"
#import "DTMNavigationControllerDelegate.h"
#import "DTMMainViewController.h"
#import "DTMCoreDataController.h"

#import "DTMAddingViewController.h" //  *for test*

@interface AppDelegate ()

@property (nonatomic, strong, nullable) id<UINavigationControllerDelegate> navigationControllerDelegate;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    DTMMainViewController *firstViewController = [[DTMMainViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    self.navigationControllerDelegate = [[DTMNavigationControllerDelegate alloc] init];
    self.navigationController.delegate = self.navigationControllerDelegate;
    
   
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = self.navigationController;
//  *for test*
//    self.window.rootViewController = [DTMAddingViewController new];
//  *end test*
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    DTMCoreDataController *coreDataController = [DTMCoreDataController sharedController];
    [coreDataController saveContext];
}


@end
