
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
extern NSString *const DTM_CUSTOM_CELL_REUSE_IDENTIFIER;

@interface DTMMainTableViewDelegate ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

@end

@implementation DTMMainTableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTMWeatherDataModel *data = self.dataForTable[self.dataForTable.count - indexPath.row - 1];
    NSString *cityName = data.city_name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy  HH:mm"];
    NSString *date = [formatter stringFromDate:data.date];
    
    DTMMainTableViewCell *cell = [[DTMMainTableViewCell alloc] init];
    
    return [cell heightForCellWithCityName:cityName andDate:date];
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
    [   UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve  animations:
        ^{
             [cell setFrame:frame];
         }
        completion:^(BOOL finished) {}
     ];
}


#pragma mark - Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataForTable.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //for inversion order of cells
    DTMWeatherDataModel *data = self.dataForTable[self.dataForTable.count - indexPath.row - 1];
    
    DTMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DTM_CUSTOM_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];

    if ((int)data.temperature > 0)
        cell.temperatureLabel.text = [NSString stringWithFormat:@"+%d \u00B0C", (int)data.temperature];
    else
        cell.temperatureLabel.text = [NSString stringWithFormat:@"%d \u00B0C", (int)data.temperature];
    
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
    DTMCoreDataController *coreDataController = [DTMCoreDataController sharedController];
    NSPersistentContainer *container = coreDataController.persistentContainer;
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


- (void)removeElementFromDataModelForIndex:(NSUInteger)index
{
    DTMWeatherDataModel *data = self.dataForTable[self.dataForTable.count - index - 1];
    
    if(!data) return;
    
    [self.coreDataContext deleteObject:data];
        
    if ([data isDeleted])
    {
        [self.coreDataContext save:nil];
        [self updateDataForMainTableView];
    }
}


@end
