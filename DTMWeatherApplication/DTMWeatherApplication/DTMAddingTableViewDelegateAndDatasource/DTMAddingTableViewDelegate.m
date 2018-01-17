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

extern NSString *const DTM_ADDING_CELL_IDENTIFIER;
static const CGFloat DTMCellInterval = 44.0;

@implementation DTMAddingTableViewDelegate

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
    
    return [cell heightForCellWithCityName:cityModel.cityName andCountryName:cityModel.countryName];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMCityDataModel *currentCellDataModel = [DTMCityDataModelService sharedService].dataForTable[indexPath.row];
    
    int64_t cityId = currentCellDataModel.cityId;

    [DTMNetworkService getDataWithCityId:cityId completionHandler:^(NSError * _Nullable error, NSData * _Nullable data)
    {
        if (error)
        {
             NSLog(@"error with download task");
            
            __block NSError *networkError = error;
            __block NSString *networkErrorDescription = @"Something goes wrong with network. Please check your connection and try again.";
            dispatch_sync(dispatch_get_main_queue(),
            ^{
                self.transiteToAlertControllerBlock(networkError, networkErrorDescription);
            });
        }
        
        else
        {
            [DTMJSONToDTMWeatherDataModelMapper saveInCoreDataDTMWeatherDataModelFromJSON:data completionHandler: ^(NSError *error)
            {
                if (error)
                {
                    NSLog(@"error with saving core data context");
                    __block NSError *networkError = error;
                    __block NSString *networkErrorDescription = @"Something goes wrong. Please restart app and try again.";
                    dispatch_sync(dispatch_get_main_queue(),
                    ^{
                        self.transiteToAlertControllerBlock(networkError, networkErrorDescription);
                    });
                }
                
                else
                {
                    dispatch_sync(dispatch_get_main_queue(),
                    ^{
                        self.transiteToMainViewControllerBlock();
                    });
                }
            }];
        }
     }];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = cell.frame;
    [cell setFrame:CGRectMake(0, tableView.frame.size.height, frame.size.width, frame.size.height)];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve  animations:
        ^{
            [cell setFrame:frame];
        }
        completion:^(BOOL finished) {}
     ];
}


@end
