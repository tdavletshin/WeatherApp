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
#import <Masonry/Masonry.h>
#import "DTMAddingTableViewDelegate.h"
#import "DTMAddingTableViewDataSource.h"
#import "DTMAddingTableViewCell.h"


extern NSString *const DTM_ADDING_CELL_IDENTIFIER;

@interface DTMAddingViewController ()

@property (nonatomic, strong) UITableView *addingCitiesTableView;
@property (nonatomic, strong) id<UITableViewDelegate> addingCitiesTableViewDelegate;
@property (nonatomic, strong) id<UITableViewDataSource> addingCitiesTableViewDataSource;


@end

@implementation DTMAddingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setUpNavigationBar];
    
    self.addingCitiesTableView = [[UITableView alloc] init];
    self.addingCitiesTableViewDelegate = [[DTMAddingTableViewDelegate alloc] init];
    self.addingCitiesTableView.delegate = self.addingCitiesTableViewDelegate;
    self.addingCitiesTableViewDataSource = [[DTMAddingTableViewDataSource alloc] init];
    self.addingCitiesTableView.dataSource = self.addingCitiesTableViewDataSource;
    [self.addingCitiesTableView registerClass:[DTMAddingTableViewCell class] forCellReuseIdentifier:DTM_ADDING_CELL_IDENTIFIER];
    self.addingCitiesTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.jpg"]];
    self.addingCitiesTableView.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    self.addingCitiesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.addingCitiesTableView];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLayoutSubviews
{
    [   self.addingCitiesTableView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.equalTo(self.view.mas_top);
             make.bottom.equalTo(self.view.mas_bottom);
             make.right.equalTo(self.view.mas_right);
             make.left.equalTo(self.view.mas_left);
         }
     ];
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



@end
