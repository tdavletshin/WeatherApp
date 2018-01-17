//
//  DTMAddingViewController.h
//  DTMWeatherApplication
//
//  Created by user on 03.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTMAddingViewController : UIViewController

- (void)transiteToMainViewController;
- (void)transiteToAlertControllerWithError: (NSError *)error andDescription: (NSString *)description;
- (void)reloadDataInAddingCitiesTableView;
@end
