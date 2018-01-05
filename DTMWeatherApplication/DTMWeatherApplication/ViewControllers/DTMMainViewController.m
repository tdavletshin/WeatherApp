//
//  DTMMainViewController.m
//  DTMWeatherApplication
//
//  Created by user on 31.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import "DTMMainViewController.h"
#import "DTMTableViewDelegate.h"
#import "DTMTableViewDataSource.h"
#import "DTMAddingViewController.h"
#import "DTMExtendedUITableViewDataSourceProtocol.h"
#import <Masonry/Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


const CGFloat NAVIGATION_BAR_FONT_SIZE = 36.0;
const int NAVIGATION_BAR_COLOR = 0x005df4;

@interface DTMMainViewController ()

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) id<UITableViewDelegate> mainTableViewDelegate;
@property (nonatomic, strong) id<UITableViewDataSource> mainTableViewDataSource;


@end

@implementation DTMMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUpNavigationBar];
    
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableViewDataSource = [[DTMTableViewDataSource alloc] init];
    self.mainTableViewDelegate = [[DTMTableViewDelegate alloc] init];
    self.mainTableView.delegate = self.mainTableViewDelegate;
    self.mainTableView.dataSource = self.mainTableViewDataSource;
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DTM.Weather.Cell"];
    [self.view addSubview:self.mainTableView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLayoutSubviews
{
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.navigationController.navigationBar.mas_bottom);
         make.bottom.equalTo(self.view.mas_bottom);
         make.right.equalTo(self.view.mas_right);
         make.left.equalTo(self.view.mas_left);
     }];
}

#pragma mark - Setting up a navigation bar

- (void)setUpNavigationBar
{
    [self.navigationController.navigationBar setBarTintColor: UIColorFromRGB(NAVIGATION_BAR_COLOR)];
    [self.navigationController.navigationBar setTintColor: UIColor.whiteColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = UIColor.blackColor;
    shadow.shadowOffset = CGSizeMake(0, 1);
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      UIColor.whiteColor, NSForegroundColorAttributeName,
                                                                      shadow, NSShadowAttributeName,
                                                                      [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:NAVIGATION_BAR_FONT_SIZE], NSFontAttributeName, nil]];
    
    
    self.navigationItem.title = @"Weather for date";
    //self.navigationItem.prompt = @"hello";
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(transiteToAddingViewController)];
    self.navigationItem.leftBarButtonItem = addItem;
    self.navigationItem.leftBarButtonItem.tintColor = UIColor.whiteColor;
}

#pragma mark - Transition to adding view controller

- (void)transiteToAddingViewController
{
    [self.navigationController pushViewController:[DTMAddingViewController new] animated:YES];
}




@end
