//
//  DTMDetailViewController.m
//  DTMWeatherApplication
//
//  Created by user on 19.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import "DTMDetailViewController.h"
#import "DTMCoreDataController.h"
#import "DTMWeatherDataModel+CoreDataClass.h"
#import "DTMWeatherDataModel+CoreDataProperties.h"
#import <Masonry/Masonry.h>
#import "AppDelegate.h"


static const CGFloat DTMUIElementsOffset = 30.0;
static NSString *const DTMCityNameLabelFontName = @"HelveticaNeue-CondensedBlack";
static NSString *const DTMTemperatureLabelFontName = @"HelveticaNeue-CondensedBlack";
static NSString *const DTMHumidityLabelFontName = @"HelveticaNeue-CondensedBlack";
static NSString *const DTMPressureLabelFontName = @"HelveticaNeue-CondensedBlack";
static NSString *const DTMWindSpeedLabelFontName = @"HelveticaNeue-CondensedBlack";
static NSString *const DTMWindDirectionLabelFontName = @"HelveticaNeue-CondensedBlack";
static const CGFloat DTMCityNameLabelFontSize = 44.0;
static const CGFloat DTMTemperatureLabelFontSize = 20.0;
static const CGFloat DTMHumidityLabelFontSize = 20.0;
static const CGFloat DTMPressureLabelFontSize = 20.0;
static const CGFloat DTMWindSpeedLabelFontSize = 20.0;
static const CGFloat DTMWindDirectionLabelFontSize = 20.0;
static NSString *const DTMNavigationItemTitle = @"Detail information";


@interface DTMDetailViewController ()


@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, assign) NSUInteger indexOfDataModel;
@property (nonatomic, strong, nonnull) UILabel *cityNameLabel;
@property (nonatomic, strong, nonnull) UILabel *temperatureLabel;
@property (nonatomic, strong, nonnull) UILabel *humidityLabel;
@property (nonatomic, strong, nonnull) UILabel *pressureLabel;
@property (nonatomic, strong, nonnull) UILabel *windSpeedLabel;
@property (nonatomic, strong, nonnull) UILabel *windDirectionLabel;
@property (nonatomic, strong, nonnull) UIImageView *backgroundImageView;


@end


@implementation DTMDetailViewController


#pragma mark - Lifecycle

- (instancetype)initWithDataModelIndex: (NSUInteger)index
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    _indexOfDataModel = index;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSError *error = nil;
    NSArray <DTMWeatherDataModel *> *result = [self.coreDataContext executeFetchRequest:[DTMWeatherDataModel fetchRequest] error:&error];
    if (error)
    {
        UIApplication *application = [UIApplication sharedApplication];
        AppDelegate *applocationDelegate = (AppDelegate *)application.delegate;
        UINavigationController *navigationController = applocationDelegate.navigationController;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your action can not be done" message:[NSString stringWithFormat:@"Unresolved error of Core Data: %@", error] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:ok];
        [navigationController presentViewController:alert animated:YES completion:nil];
    }
    DTMWeatherDataModel *dataModel = result[self.indexOfDataModel];
    
    [self setUpNavigationBar];
    [self setUpBackgroundImage];
    [self setUpCityNameLabelWithDataModel:dataModel];
    [self setUpTemperatureLabelWithDataModel:dataModel];
    [self setUpHumidityLabelWithDataModel:dataModel];
    [self setUpPressureLabelWithDataModel:dataModel];
    [self setUpWindSpeedLabelWithDataModel:dataModel];
    [self setUpWindDirectionLabelWithDataModel:dataModel];
    [self addConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - adding constraints for ui

- (void)addConstraints
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
    }];
    [self.cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).with.offset(CGRectGetMaxY(self.navigationController.navigationBar.frame) + DTMUIElementsOffset);
        make.bottom.equalTo(self.temperatureLabel.mas_top).with.offset(-DTMUIElementsOffset);
        make.right.equalTo(self.view.mas_right).with.offset(-DTMUIElementsOffset);
        make.left.equalTo(self.view.mas_left).with.offset(DTMUIElementsOffset);
    }];
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.cityNameLabel.mas_bottom).with.offset(-DTMUIElementsOffset);
        make.bottom.equalTo(self.humidityLabel.mas_top).with.offset(-DTMUIElementsOffset);
        make.right.equalTo(self.view.mas_right).with.offset(-DTMUIElementsOffset);
        make.left.equalTo(self.view.mas_left).with.offset(DTMUIElementsOffset);
    }];
    [self.humidityLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.temperatureLabel.mas_bottom).with.offset(-DTMUIElementsOffset);
        make.bottom.equalTo(self.pressureLabel.mas_top).with.offset(-DTMUIElementsOffset);
        make.right.equalTo(self.view.mas_right).with.offset(-DTMUIElementsOffset);
        make.left.equalTo(self.view.mas_left).with.offset(DTMUIElementsOffset);
    }];
    [self.pressureLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.humidityLabel.mas_bottom).with.offset(-DTMUIElementsOffset);
        make.bottom.equalTo(self.windSpeedLabel.mas_top).with.offset(-DTMUIElementsOffset);
        make.right.equalTo(self.view.mas_right).with.offset(-DTMUIElementsOffset);
        make.left.equalTo(self.view.mas_left).with.offset(DTMUIElementsOffset);
    }];
    [self.windSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.pressureLabel.mas_bottom).with.offset(-DTMUIElementsOffset);
        make.bottom.equalTo(self.windDirectionLabel.mas_top).with.offset(-DTMUIElementsOffset);
        make.right.equalTo(self.view.mas_right).with.offset(-DTMUIElementsOffset);
        make.left.equalTo(self.view.mas_left).with.offset(DTMUIElementsOffset);
    }];
    [self.windDirectionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.windSpeedLabel.mas_bottom).with.offset(-DTMUIElementsOffset);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-DTMUIElementsOffset);
        make.right.equalTo(self.view.mas_right).with.offset(-DTMUIElementsOffset);
        make.left.equalTo(self.view.mas_left).with.offset(DTMUIElementsOffset);
    }];
}


#pragma mark - setting up ui elements

- (void)setUpBackgroundImage
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper.jpg"]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.backgroundImageView];
}

- (void)setUpNavigationBar
{
    self.navigationItem.title = DTMNavigationItemTitle;
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(transiteToMainViewController)];
    self.navigationItem.leftBarButtonItem = returnItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.leftBarButtonItem.tintColor = UIColor.whiteColor;
}

- (void)setUpCityNameLabelWithDataModel: (DTMWeatherDataModel *)dataModel
{
    self.cityNameLabel = [[UILabel alloc] init];
    self.cityNameLabel.font = [UIFont fontWithName:DTMCityNameLabelFontName size:DTMCityNameLabelFontSize];
    self.cityNameLabel.numberOfLines = 0;
    self.cityNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.cityNameLabel.text = dataModel.city_name;
    [self.view addSubview:self.cityNameLabel];
}

- (void)setUpTemperatureLabelWithDataModel: (DTMWeatherDataModel *)dataModel
{
    self.temperatureLabel = [[UILabel alloc] init];
    self.temperatureLabel.font = [UIFont fontWithName:DTMTemperatureLabelFontName size:DTMTemperatureLabelFontSize];
    if (dataModel.temperature > 0)
    {
        self.temperatureLabel.text = [NSString stringWithFormat:@"Temperature:  +%.2f \u00B0C", dataModel.temperature];
    }
    else
    {
        self.temperatureLabel.text = [NSString stringWithFormat:@"Temperature:  %.2f \u00B0C", dataModel.temperature];
    }
    [self.view addSubview:self.temperatureLabel];
}

- (void)setUpHumidityLabelWithDataModel: (DTMWeatherDataModel *)dataModel
{
    self.humidityLabel = [[UILabel alloc] init];
    self.humidityLabel.font = [UIFont fontWithName:DTMHumidityLabelFontName size:DTMHumidityLabelFontSize];
    self.humidityLabel.text = [NSString stringWithFormat:@"Humidity:  %.2f %%", dataModel.humidity];
    [self.view addSubview:self.humidityLabel];
}

- (void)setUpPressureLabelWithDataModel: (DTMWeatherDataModel *)dataModel
{
    self.pressureLabel = [[UILabel alloc] init];
    self.pressureLabel.font = [UIFont fontWithName:DTMPressureLabelFontName size:DTMPressureLabelFontSize];
    self.pressureLabel.text = [NSString stringWithFormat:@"Pressure:  %.2f kPa", dataModel.pressure];
    [self.view addSubview:self.pressureLabel];
}

- (void)setUpWindSpeedLabelWithDataModel: (DTMWeatherDataModel *)dataModel
{
    self.windSpeedLabel = [[UILabel alloc] init];
    self.windSpeedLabel.font = [UIFont fontWithName:DTMWindSpeedLabelFontName size:DTMWindSpeedLabelFontSize];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"Wind speed:  %.2f m/s", dataModel.wind_speed];
    [self.view addSubview:self.windSpeedLabel];
}

- (void)setUpWindDirectionLabelWithDataModel: (DTMWeatherDataModel *)dataModel
{
    self.windDirectionLabel = [[UILabel alloc] init];
    self.windDirectionLabel.font = [UIFont fontWithName:DTMWindDirectionLabelFontName size:DTMWindDirectionLabelFontSize];
    self.windDirectionLabel.text = [NSString stringWithFormat:@"Wind direction:  %.2f \u00B0", dataModel.wind_direction];
    [self.view addSubview:self.windDirectionLabel];
}


#pragma mark - Transition to main ViewController

- (void)transiteToMainViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - custom coreDataContext getter

- (NSManagedObjectContext *)coreDataContext
{
    DTMCoreDataController *coreDataController = [DTMCoreDataController sharedController];
    NSPersistentContainer *container = coreDataController.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    return context;
}


@end
