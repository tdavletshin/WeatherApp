//
//  DTMAddingViewController.m
//  DTMWeatherApplication
//
//  Created by user on 03.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMAddingViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DTMAddingViewController ()

@end

@implementation DTMAddingViewController

- (void)viewDidLoad
{

    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUpNavigationBar];
    
    [super viewDidLoad];
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

@end
