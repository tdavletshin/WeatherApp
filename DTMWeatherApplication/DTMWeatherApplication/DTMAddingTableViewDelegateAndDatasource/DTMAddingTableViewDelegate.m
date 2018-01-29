//
//  DTMAddingTableViewDelegate.m
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import "DTMAddingTableViewDelegate.h"
#import "DTMAddingTableViewCell.h"
#import "DTMCityDataModelService.h"
#import "AppDelegate.h"
#import "DTMJSONToDTMWeatherDataModelMapper.h"
#import "DTMNetworkService.h"


static const CGFloat DTMCellInterval = 44.0;


@implementation DTMAddingTableViewDelegate


#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DTMCellInterval;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.clearColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    DTMCityDataModel *cityModel = [DTMCityDataModelService sharedService].dataForTable[indexPath.row];
    DTMAddingTableViewCell *cell = [[DTMAddingTableViewCell alloc] init];
    return [cell heightForCellWithCityName:cityModel.cityName withCountryName:cityModel.countryName];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMCityDataModel *currentCellDataModel = [DTMCityDataModelService sharedService].dataForTable[indexPath.row];
    int64_t cityId = currentCellDataModel.cityId;
    [DTMNetworkService getDataWithCityId:cityId completionHandler:^(NSError * _Nullable error, NSData * _Nullable data){
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.viewController transiteToAlertControllerWithError:error withDescription:error.description];
            });
        }
        
        else
        {
            [self saveInCoreDataWeatherDataModelFromJSON:data];
        }
    }];
}

- (void)saveInCoreDataWeatherDataModelFromJSON: (NSData *)json
{
    [DTMJSONToDTMWeatherDataModelMapper saveInCoreDataDTMWeatherDataModelFromJSON:json completionHandler: ^(NSError *error){
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.viewController transiteToAlertControllerWithError:error withDescription:error.description];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.viewController transiteToMainViewController];
            });
        }
    }];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = cell.frame;
    [cell setFrame:CGRectMake(0, tableView.frame.size.height, frame.size.width, frame.size.height)];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve  animations:^{
        [cell setFrame:frame];
    }completion:^(BOOL finished) {}];
}


@end
