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
#import <Masonry/Masonry.h>

static CGFloat const ELEMENTS_OFFSET = 15.0;
static CGFloat const BUTTONS_HEIGHT = 44.0;


@interface DTMMainViewController ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) DTMTableViewDelegate *mainTableViewDelegate;
@property (nonatomic, strong) DTMTableViewDataSource *mainTableViewDataSource;

@end

@implementation DTMMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.yellowColor;
    
    self.addButton = [[UIButton alloc] init];
    self.addButton.backgroundColor = UIColor.greenColor;
    [self.view addSubview:self.addButton];
    
    self.deleteButton = [[UIButton alloc] init];
    self.deleteButton.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.deleteButton];
    
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self.mainTableViewDelegate;
    self.mainTableView.dataSource = self.mainTableViewDataSource;
    [self.view addSubview:self.mainTableView];
    
    
}

- (void)viewDidLayoutSubviews
{
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *leftButtonConstraint)
     {
         leftButtonConstraint.bottom.equalTo(self.mainTableView.mas_top).with.offset(-1 * ELEMENTS_OFFSET);
         leftButtonConstraint.top.equalTo(self.view.mas_top).with.offset(ELEMENTS_OFFSET);
         leftButtonConstraint.right.equalTo(self.deleteButton.mas_left).with.offset(-1 * ELEMENTS_OFFSET);
         leftButtonConstraint.left.equalTo(self.view.mas_left).with.offset(ELEMENTS_OFFSET);
         leftButtonConstraint.width.equalTo(self.deleteButton.mas_width);
         leftButtonConstraint.height.mas_equalTo(BUTTONS_HEIGHT);
     }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *rightButtonConstraint)
     {
         rightButtonConstraint.bottom.equalTo(self.mainTableView.mas_top).with.offset(-1 * ELEMENTS_OFFSET);
         rightButtonConstraint.top.equalTo(self.view.mas_top).with.offset(ELEMENTS_OFFSET);
         rightButtonConstraint.right.equalTo(self.view.mas_right).with.offset(-1 * ELEMENTS_OFFSET);
         rightButtonConstraint.left.equalTo(self.addButton.mas_right).with.offset(ELEMENTS_OFFSET);
         rightButtonConstraint.width.equalTo(self.addButton.mas_width);
         rightButtonConstraint.height.mas_equalTo(BUTTONS_HEIGHT);
     }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.view.mas_bottom);
         make.right.equalTo(self.view.mas_right);
         make.left.equalTo(self.view.mas_left);
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
