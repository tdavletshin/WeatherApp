//
//  DTMAddingSearchBarDelegate.h
//  DTMWeatherApplication
//
//  Created by user on 13.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTMAddingViewController.h"


@interface DTMAddingSearchBarDelegate : NSObject <UISearchBarDelegate>


@property (nonatomic, weak, nullable) DTMAddingViewController *viewController;


@end
