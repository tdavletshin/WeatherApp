//
//  DTMAddingViewController.m
//  DTMWeatherApplication
//
//  Created by user on 03.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMAddingViewController.h"
#import "AppDelegate.h"
#import "DTMWeatherDataModel+CoreDataClass.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"



@interface DTMAddingViewController ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

@end

@implementation DTMAddingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUpNavigationBar];
    
//        DTMWeatherDataModel *data = [NSEntityDescription insertNewObjectForEntityForName:@"DTMWeatherDataModel" inManagedObjectContext:self.coreDataContext];
//        data.city_name = @"NU nnnnn nnn nnn nnn nnn city";
//        data.temperature = -5;
//        data.date = [NSDate date];
//        data.icon_id = @"10d";
//    
//        NSError *error = nil;
//    
//        if (![data.managedObjectContext save:&error])
//        {
//            NSLog(@"не удалось выполнить fetch request");
//            NSLog(@"%@ %@", error, error.localizedDescription);
//        }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - set up navigation bar

- (void)setUpNavigationBar
{    
    self.navigationItem.title = @"Select city";
    //self.navigationItem.prompt = @"hello";
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(transiteToMainViewController)];
    self.navigationItem.rightBarButtonItem = addItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem.tintColor = UIColor.whiteColor;
}

#pragma mark - transition to main view controller

- (void)transiteToMainViewController
{
    [self.navigationController popViewControllerAnimated:YES];
    //NSLog(@"%@", self.navigationController.viewControllers);
}


#pragma mark - CoreDataContext getter

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *) (application.delegate)).coreDataController.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}


@end
