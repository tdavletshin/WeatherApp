//
//  DTMAddingTableViewDelegate.h
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTMAddingViewController.h"


@interface DTMAddingTableViewDelegate : NSObject <UITableViewDelegate>


@property (nonatomic, weak, nullable) DTMAddingViewController *viewController;


@end
