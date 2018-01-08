
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

const CGFloat DTMCellInterval = 22.0;
extern NSString *const DTM_CUSTOM_CELL_REUSE_IDENTIFIER;

@interface DTMMainTableViewDelegate ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, copy, nonnull) NSArray<DTMWeatherDataModel *> *dataForTable;

@end

@implementation DTMMainTableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cityName = self.dataForTable[(int)indexPath.row].city_name;
    return [DTMMainTableViewCell heightForCellForCityName: cityName];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
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


#pragma mark - Main Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataForTable.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DTMWeatherDataModel *data = self.dataForTable[indexPath.section];
    
    DTMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DTM_CUSTOM_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    if ((int)data.temperature > 0)
        cell.temperatureLabel.text = [NSString stringWithFormat:@" +%d \u00B0C", (int)data.temperature];
    else
        cell.temperatureLabel.text = [NSString stringWithFormat:@" %d \u00B0C", (int)data.temperature];
    
    cell.cityLabel.text = data.city_name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy  HH:mm"];
    cell.dateLabel.text = [formatter stringFromDate:data.date];
    
    
    NSString *imageName = [[NSString alloc] initWithFormat:@"%@.png", data.icon_id];
    cell.weatherImageView.image = [UIImage imageNamed:imageName];
        
    return cell;
}

#pragma mark - CoreDataContext getter

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *) (application.delegate)).coreDataController.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

#pragma mark - Refresh dataForTable

- (void)updateDataForMainTableView
{
    NSError *error = nil;
    NSArray *result = [self.coreDataContext executeFetchRequest:[DTMWeatherDataModel fetchRequest] error:&error];
    
    if (error)
    {
        NSLog(@"не удалось выполнить fetch request");
        NSLog(@"%@ %@", error, error.localizedDescription);
    }
    
    else
    {
        self.dataForTable = result;
    }
}

@end
