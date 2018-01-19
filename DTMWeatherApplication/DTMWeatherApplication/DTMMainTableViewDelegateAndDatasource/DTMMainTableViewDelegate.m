
//
//  DTMTableViewDelegate.m
//  DTMWeatherApplication
//
//  Created by user on 31.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//


#import "DTMMainTableViewDelegate.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "DTMMainTableViewCell.h"
#import "DTMCoreDataController.h"


static const CGFloat DTMCellInterval = 22.0;
extern NSString *const DTMCustomMainTableCellReuseIdentifier;
static NSString *const DTMDateFomatString = @"dd/MM/yyyy  HH:mm";


@interface DTMMainTableViewDelegate ()


@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;


@end


@implementation DTMMainTableViewDelegate 


#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMWeatherDataModel *data = self.dataForTable[self.dataForTable.count - indexPath.row - 1];
    NSString *cityName = data.city_name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DTMDateFomatString];
    NSString *date = [formatter stringFromDate:data.date];
    
    DTMMainTableViewCell *cell = [[DTMMainTableViewCell alloc] init];
    
    return [cell heightForCellWithCityName:cityName withDate:date];
}

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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = cell.frame;
    [cell setFrame:CGRectMake(0, tableView.frame.size.height, frame.size.width, frame.size.height)];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [cell setFrame:frame];
        }
    completion:^(BOOL finished) {}];
}


#pragma mark - TableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataForTable.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DTMWeatherDataModel *data = self.dataForTable[self.dataForTable.count - indexPath.row - 1];
    
    DTMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DTMCustomMainTableCellReuseIdentifier forIndexPath:indexPath];

    if ((int)data.temperature > 0)
    {
        cell.temperatureLabel.text = [NSString stringWithFormat:@"+%d \u00B0C", (int)data.temperature];
    }
    else
    {
        cell.temperatureLabel.text = [NSString stringWithFormat:@"%d \u00B0C", (int)data.temperature];
    }
    
    cell.cityLabel.text = data.city_name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DTMDateFomatString];
    cell.dateLabel.text = [formatter stringFromDate:data.date];
    
    NSString *imageName = [[NSString alloc] initWithFormat:@"%@.png", data.icon_id];
    cell.weatherImageView.image = [UIImage imageNamed:imageName];
    
    
    NSUInteger index = self.dataForTable.count - indexPath.row - 1;
    cell.indexInDataModel = index;
    
    __weak typeof(self)weakSelf = self;
    cell.buttonBlock = ^(NSUInteger indexInDataModel) {
        __strong typeof(self)self = weakSelf;
        if (self.viewController)
        {
            [self.viewController transiteToDetailViewControllerWithDataModelIndex:indexInDataModel];
        }
    };
    
    return cell;
}


#pragma mark - custom coreDataContext getter

- (NSManagedObjectContext *)coreDataContext
{
    DTMCoreDataController *coreDataController = [DTMCoreDataController sharedController];
    NSPersistentContainer *container = coreDataController.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    return context;
}


#pragma mark - Updating dataForTable

- (void)updateDataForMainTableView
{
    NSError *error = nil;
    NSArray <DTMWeatherDataModel *> *result = [self.coreDataContext executeFetchRequest:[DTMWeatherDataModel fetchRequest] error:&error];
    
    if (error)
    {
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *applocationDelegate = (AppDelegate *)application.delegate;
        UINavigationController *navigationController = applocationDelegate.navigationController;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your action can not be done" message:[NSString stringWithFormat:@"Unresolved error of Core Data: %@", error] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [navigationController presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        self.dataForTable = result;
    }
}


#pragma mark - Removing element from data model

- (void)removeElementFromDataModelForIndex:(NSUInteger)index
{
    DTMWeatherDataModel *data = self.dataForTable[self.dataForTable.count - index - 1];
    
    if(!data)
    {
        return;
    }
    [self.coreDataContext deleteObject:data];
    if ([data isDeleted])
    {
        [self.coreDataContext save:nil];
        [self updateDataForMainTableView];
    }
}


@end
