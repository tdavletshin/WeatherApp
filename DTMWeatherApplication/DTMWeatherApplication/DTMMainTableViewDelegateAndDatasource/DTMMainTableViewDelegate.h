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
#import "DTMMainViewController.h"


@interface DTMMainTableViewDelegate : NSObject <UITableViewDelegate, DTMExtendedUITableViewDataSource>


@property (nonatomic, copy, nonnull) NSArray<DTMWeatherDataModel *> *dataForTable;
@property (nonatomic, weak, nullable) DTMMainViewController *viewController;


- (void)updateDataForMainTableView;
- (void)removeElementFromDataModelForIndex:(NSUInteger) index;


@end
