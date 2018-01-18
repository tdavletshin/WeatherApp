//
//  DTMMainViewController.m
//  DTMWeatherApplication
//
//  Created by user on 31.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//


#import "DTMMainViewController.h"
#import "DTMMainTableViewDelegate.h"
#import "DTMAddingViewController.h"
#import "DTMExtendedUITableViewDataSourceProtocol.h"
#import <Masonry/Masonry.h>
#import <Foundation/Foundation.h>
#import "DTMMainTableViewCell.h"
#import "DTMCityDataModelService.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


const CGFloat NavigationBarFontSize = 26.0;
const int NavigationBarColor = 0x00aeda;
NSString *const DTMCustomMainTableCellReuseIdentifier = @"DTM.Custom.Weather.Cell";


@interface DTMMainViewController ()


@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) id<UITableViewDelegate, DTMExtendedUITableViewDataSource> mainTableViewDelegateAndDataSource;


@end


@implementation DTMMainViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpTableView];
    [self addConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mainTableViewDelegateAndDataSource updateDataForMainTableView];
    [self.mainTableView reloadData];
}


#pragma mark - Adding constrains with masonry

- (void)addConstraints
{
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).with.offset(CGRectGetMaxY(self.navigationController.navigationBar.frame));
            make.bottom.equalTo(self.view.mas_bottom);
            make.right.equalTo(self.view.mas_right);
            make.left.equalTo(self.view.mas_left);
    }];
}


#pragma mark - seting up of UI elements

- (void)setUpTableView
{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableViewDelegateAndDataSource = [[DTMMainTableViewDelegate alloc] init];
    self.mainTableView.delegate = self.mainTableViewDelegateAndDataSource;
    self.mainTableView.dataSource = self.mainTableViewDelegateAndDataSource;
    [self.mainTableView registerClass:[DTMMainTableViewCell class] forCellReuseIdentifier:DTMCustomMainTableCellReuseIdentifier];
    self.mainTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.jpg"]];
    self.mainTableView.backgroundView.contentMode = UIViewContentModeScaleToFill;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
}

- (void)setUpNavigationBar
{
    [self.navigationController.navigationBar setBarTintColor: UIColorFromRGB(NavigationBarColor)];
    [self.navigationController.navigationBar setTintColor: UIColor.whiteColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = UIColor.blackColor;
    shadow.shadowOffset = CGSizeMake(0, 1);
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      UIColor.whiteColor, NSForegroundColorAttributeName,
                                                                      shadow, NSShadowAttributeName,
                                                                      [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:NavigationBarFontSize], NSFontAttributeName, nil]];
    self.navigationItem.title = @"Weather for date";
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(transiteToAddingViewController)];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action: @selector(deleteSelectedCell)];
    self.navigationItem.leftBarButtonItem = addItem;
    self.navigationItem.rightBarButtonItem = deleteItem;
    self.navigationItem.leftBarButtonItem.tintColor = UIColor.whiteColor;
    self.navigationItem.rightBarButtonItem.tintColor = UIColor.whiteColor;
}


#pragma mark - Transition to adding view controller

- (void)transiteToAddingViewController
{
    [self.navigationController pushViewController:[[DTMAddingViewController alloc] init] animated:YES];
}

#pragma mark - Deleting of selected cell

- (void)deleteSelectedCell
{
    if ([self.mainTableView numberOfRowsInSection:0] == 0)
        return;
    
    NSIndexPath *deleteIndexPath = [self.mainTableView indexPathForSelectedRow];
    if (deleteIndexPath == nil)
    {
        [self.mainTableViewDelegateAndDataSource removeElementFromDataModelForIndex:0];
        deleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.mainTableView deleteRowsAtIndexPaths:@[deleteIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        NSUInteger deleteIndex = deleteIndexPath.row;
        [self.mainTableViewDelegateAndDataSource removeElementFromDataModelForIndex:deleteIndex];
        [self.mainTableView deleteRowsAtIndexPaths:@[deleteIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}


@end
