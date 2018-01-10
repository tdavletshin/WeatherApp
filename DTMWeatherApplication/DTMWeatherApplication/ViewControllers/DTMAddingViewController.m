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
#import "DTMJSONToDTMWeatherDataModelMapper.h"


@interface DTMAddingViewController ()

@end

@implementation DTMAddingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUpNavigationBar];
    
//        DTMWeatherDataModel *data = [NSEntityDescription insertNewObjectForEntityForName:@"DTMWeatherDataModel" inManagedObjectContext:self.coreDataContext];
//        data.city_name = @"NU city";
//        data.temperature = -55;
//        data.date = [NSDate date];
//        data.icon_id = @"01d";
//
//        NSError *error = nil;
//
//        if (![data.managedObjectContext save:&error])
//        {
//            NSLog(@"не удалось выполнить fetch request");
//            NSLog(@"%@ %@", error, error.localizedDescription);
//        }

    // 1
    NSString *dataUrl = @"https://api.openweathermap.org/data/2.5/weather?id=1497337&units=metric&APPID=9174e54fa42ba3f00260dfec4cc770cf";
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
        
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [DTMJSONToDTMWeatherDataModelMapper saveInCoreDataDTMWeatherDataModelFromJSON:data competion: ^(NSError *error)
            {
                if (error)
                {
                    NSLog(@"error with saving core data context");
                }
            }];
        });
    }];
    
    [downloadTask resume];
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
