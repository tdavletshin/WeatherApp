//
//  DTMExtendedUITableViewDataSourceProtocol.h
//  DTMWeatherApplication
//
//  Created by user on 05.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTMWeatherDataModel+CoreDataClass.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"

@protocol DTMExtendedUITableViewDataSource <UITableViewDataSource>

@required

@property (nonatomic, copy, nonnull) NSArray *dataForTable;

- (void)updateDataForMainTableView;

@optional

- (void)removeElementFromDataModelForIndex:(NSUInteger) index;

@end
