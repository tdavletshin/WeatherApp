//
//  DTMTableViewDataSource.m
//  DTMWeatherApplication
//
//  Created by user on 31.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import "DTMTableViewDataSource.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "DTMWeatherDataModel+CoreDataClass.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"

@interface DTMTableViewDataSource ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSArray<DTMWeatherDataModel *> *dataForTable;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;

@end

@implementation DTMTableViewDataSource


- (instancetype)init
{
    
//    self = [super init];
//    if (self == nil) return nil;
//
//    DTMWeatherDataModel *data = [NSEntityDescription insertNewObjectForEntityForName:@"DTMWeatherDataModel" inManagedObjectContext:self.coreDataContext];
//    data.city_name = @"Digerovsk";
//    data.city_id = 6666;
//
//    NSError *error = nil;
//
//    if (![data.managedObjectContext save:&error])
//    {
//        NSLog(@"не удалось выполнить fetch request");
//        NSLog(@"%@ %@", error, error.localizedDescription);
//    }
//
//
    [self updateDataForMainTableView];
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataForTable.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DTMWeatherDataModel *data = self.dataForTable[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DTM.Weather.Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%lld %@", data.city_id, data.city_name];

    return cell;
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

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
