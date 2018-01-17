//
//  DTMAddingTableViewDataSource.m
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMAddingTableViewDataSource.h"
#import "DTMAddingTableViewCell.h"
#import "DTMCityDataModelService.h"

NSString *const DTM_ADDING_CELL_IDENTIFIER = @"DTM.ADDING_CELL.IDENTIFIER";

@interface DTMAddingTableViewDataSource ()

@end

@implementation DTMAddingTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DTMCityDataModelService sharedService].dataForTable.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMCityDataModel *cityModel = [DTMCityDataModelService sharedService].dataForTable[indexPath.row];

    DTMAddingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DTM_ADDING_CELL_IDENTIFIER forIndexPath:indexPath];

    cell.cityLabel.text = cityModel.cityName;
    cell.countryLabel.text = cityModel.countryName;
    
    return cell;
}




@end
