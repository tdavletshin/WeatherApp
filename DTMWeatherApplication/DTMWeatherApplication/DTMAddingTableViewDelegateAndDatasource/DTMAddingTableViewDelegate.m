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
    DTMCityDataModel *cityModel = [DTMCityDataModelService sharedService].dataForTable[indexPath.section];
    
    CGFloat height = [DTMAddingTableViewCell heightForCellForCityName:cityModel.cityName andCountryName:cityModel.countryName];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get a cityID from dataForTable
    DTMCityDataModel *currentCellDataModel = [DTMCityDataModelService sharedService].dataForTable[indexPath.section];
    int64_t cityId = currentCellDataModel.cityId;
    
    //reqest to Web-service
    // ------------------------------------------------------------------------
    NSString *dataUrl = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?id=%lld&units=metric&APPID=9174e54fa42ba3f00260dfec4cc770cf", cityId];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:url completionHandler:
    ^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (error)
        {
            NSLog(@"error with download task");
            exit(0);
        }
    
        [DTMJSONToDTMWeatherDataModelMapper saveInCoreDataDTMWeatherDataModelFromJSON:data completion: ^(NSError *error)
        {
            if (error)
            {
                NSLog(@"error with saving core data context");
            }
        }];
        
        //return to main view controller
        dispatch_sync(dispatch_get_main_queue(),
        ^{
            UIApplication *application = [UIApplication sharedApplication];
            UINavigationController *navigationController = ((AppDelegate *) (application.delegate)).navigationController;
            [navigationController popViewControllerAnimated:YES];
        });
    
    }];
    
    [downloadTask resume];
    // --------------------------------------------------------------------------
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = cell.frame;
    [cell setFrame:CGRectMake(0, tableView.frame.size.height, frame.size.width, frame.size.height)];
    [   UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve  animations:
     ^{
         [cell setFrame:frame];
     }
                        completion:^(BOOL finished) {}
     ];
}


@end
