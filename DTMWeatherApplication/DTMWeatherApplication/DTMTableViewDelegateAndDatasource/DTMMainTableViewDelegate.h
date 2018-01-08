//
//  DTMTableViewDelegate.h
//  DTMWeatherApplication
//
//  Created by user on 31.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTMExtendedUITableViewDataSourceProtocol.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"
#import "DTMWeatherDataModel+CoreDataClass.h"

@interface DTMMainTableViewDelegate : NSObject <UITableViewDelegate, DTMExtendedUITableViewDataSource>

- (void)updateDataForMainTableView;

@end
