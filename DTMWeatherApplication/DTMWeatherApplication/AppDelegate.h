//
//  AppDelegate.h
//  DTMWeatherApplication
//
//  Created by user on 24.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DTMCoreDataController/DTMCoreDataController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) DTMCoreDataController *coreDataController;

@end

