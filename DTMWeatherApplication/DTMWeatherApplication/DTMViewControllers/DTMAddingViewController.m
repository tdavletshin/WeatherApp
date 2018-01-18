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
#import "DTMAddingSearchBarDelegate.h"
#import "DTMCityDataModelService.h"


extern NSString *const DTMCustomAddingTableReuseIdentifier;


@interface DTMAddingViewController ()


@property (nonatomic, strong) UITableView *addingCitiesTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) id<UITableViewDelegate> addingCitiesTableViewDelegate;
@property (nonatomic, strong) id<UITableViewDataSource> addingCitiesTableViewDataSource;
@property (nonatomic, strong) id<UISearchBarDelegate> searchBarDelegate;


@end


@implementation DTMAddingViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self setUpNavigationBar];
    [self setUpSearchBar];
    [self setUpTableView];
    [self addConstraints];
    if ([DTMCityDataModelService sharedService].dataForTable.count == 0)
        [self transiteToAlertControllerWithError:nil withDescription:@"Something goes wrong. Please restart app and try again."];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Adding constrains with masonry

- (void)addConstraints
{
    [ self.searchBar mas_makeConstraints:^(MASConstraintMaker *make){
             make.top.equalTo(self.view.mas_top).with.offset(CGRectGetMaxY(self.navigationController.navigationBar.frame));
             make.bottom.equalTo(self.addingCitiesTableView.mas_top);
             make.right.equalTo(self.view.mas_right);
             make.left.equalTo(self.view.mas_left);
    }];
    
    [ self.addingCitiesTableView mas_makeConstraints:^(MASConstraintMaker *make){
             make.top.equalTo(self.searchBar.mas_bottom);
             make.bottom.equalTo(self.view.mas_bottom);
             make.right.equalTo(self.view.mas_right);
             make.left.equalTo(self.view.mas_left);
    }];
}


#pragma mark - seting up of UI elements

- (void)setUpNavigationBar
{    
    self.navigationItem.title = @"Select city";
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(transiteToMainViewController)];
    self.navigationItem.rightBarButtonItem = addItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.rightBarButtonItem.tintColor = UIColor.whiteColor;
}


- (void)setUpTableView
{
    self.addingCitiesTableView = [[UITableView alloc] init];
    DTMAddingTableViewDelegate *addingTableViewDelegate = [[DTMAddingTableViewDelegate alloc] init];
    addingTableViewDelegate.viewController = self;
    self.addingCitiesTableViewDelegate = addingTableViewDelegate;
    self.addingCitiesTableView.delegate = self.addingCitiesTableViewDelegate;
    self.addingCitiesTableViewDataSource = [[DTMAddingTableViewDataSource alloc] init];
    self.addingCitiesTableView.dataSource = self.addingCitiesTableViewDataSource;
    [self.addingCitiesTableView registerClass:[DTMAddingTableViewCell class] forCellReuseIdentifier:DTMCustomAddingTableReuseIdentifier];
    self.addingCitiesTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.jpg"]];
    self.addingCitiesTableView.backgroundView.contentMode = UIViewContentModeScaleToFill;
    self.addingCitiesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.addingCitiesTableView];
}


- (void)setUpSearchBar
{
    self.searchBar = [[UISearchBar alloc] init];
    DTMAddingSearchBarDelegate *searchBarDelegate = [[DTMAddingSearchBarDelegate alloc] init];
    searchBarDelegate.viewController = self;
    self.searchBarDelegate = searchBarDelegate;
    self.searchBar.delegate = self.searchBarDelegate;
    [self.view addSubview:self.searchBar];
    
}


#pragma mark - transition to another view controller

- (void)transiteToMainViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)transiteToAlertControllerWithError: (NSError *)error withDescription: (NSString *)description
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your action can not be done" message:description preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self dismissViewControllerAnimated:YES completion:nil];
        [self transiteToMainViewController];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - reload data in tableView

- (void)reloadDataInAddingCitiesTableView
{
    [self.addingCitiesTableView reloadData];
}


@end
