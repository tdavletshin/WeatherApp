//
//  DTMAddingSearchBarDelegate.m
//  DTMWeatherApplication
//
//  Created by user on 13.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import "DTMAddingSearchBarDelegate.h"
#import "DTMCityDataModelService.h"


@implementation DTMAddingSearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    DTMCityDataModelService *service = [DTMCityDataModelService sharedService];
    [service updateDataForTableForSearchText:searchText];
    
    if (self.viewController)
    {
        [self.viewController reloadDataInAddingCitiesTableView];
    }
}


@end
