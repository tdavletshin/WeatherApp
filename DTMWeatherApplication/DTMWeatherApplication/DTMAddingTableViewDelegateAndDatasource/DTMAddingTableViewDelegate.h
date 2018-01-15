//
//  DTMAddingTableViewDelegate.h
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTMExtendedUITableViewDataSourceProtocol.h"

typedef void (^TransiteToMainViewControllerBlock)(void);
typedef void (^TransiteToAlertControllerBlock)(NSError *_Nonnull error, NSString * _Nullable description);

@interface DTMAddingTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, copy, nonnull) TransiteToMainViewControllerBlock transiteToMainViewControllerBlock;
@property (nonatomic, copy, nonnull) TransiteToAlertControllerBlock transiteToAlertControllerBlock;

@end
