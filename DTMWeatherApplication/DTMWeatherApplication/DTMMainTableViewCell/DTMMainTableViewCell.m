//
//  DTMMainTableViewCell.m
//  DTMWeatherApplication
//
//  Created by user on 07.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMMainTableViewCell.h"
#import <Masonry/Masonry.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const CGFloat DTMElementsOffset = 10.f;
static const CGSize DTMWeatherImageViewSize = {50.f, 50.f};
static NSString *const DTMTestDate = @"07/01/2018 15:40";
static NSString *const DTMTemperatureLabelFontName = @"Georgia-BoldItalic";
static NSString *const DTMCityLabelFontName = @"Courier-Bold";
static NSString *const DTMDateLabelFontName = @"Georgia-BoldItalic";

@implementation DTMMainTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    
    _weatherImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_weatherImageView];
    
    _temperatureLabel = [[UILabel alloc] init];
    _temperatureLabel.font = [UIFont fontWithName: DTMTemperatureLabelFontName size:21.0];
    [self.contentView addSubview:_temperatureLabel];
    
    _cityLabel = [[UILabel alloc] init];
    _cityLabel.numberOfLines = 0;
    _cityLabel.font = [UIFont fontWithName: DTMCityLabelFontName size:21.0];
    [self.contentView addSubview:_cityLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont fontWithName: DTMDateLabelFontName size:14.0];
    [self.contentView addSubview:_dateLabel];
    
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell.jpg"]];
    
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedCell.png"]];
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.weatherImageView.frame = CGRectMake(DTMElementsOffset, DTMElementsOffset, DTMWeatherImageViewSize.width, DTMWeatherImageViewSize.height);
    
    self.temperatureLabel.frame = CGRectMake(CGRectGetMaxX(self.weatherImageView.frame) + DTMElementsOffset, DTMElementsOffset, 2 * DTMWeatherImageViewSize.width, CGRectGetMaxY(self.contentView.frame) - 2 * DTMElementsOffset);
    
    CGFloat cityLabelWidth = CGRectGetMaxX(self.contentView.frame) - CGRectGetMaxX(self.temperatureLabel.frame) - 2 * DTMElementsOffset;
    
    CGSize cityLabelSize = [self.cityLabel sizeThatFits:CGSizeMake(cityLabelWidth, CGFLOAT_MAX)];
    
    self.cityLabel.frame = CGRectMake(CGRectGetMaxX(self.temperatureLabel.frame) + DTMElementsOffset, DTMElementsOffset, cityLabelWidth, cityLabelSize.height);
    
    self.dateLabel.frame = CGRectMake(CGRectGetMaxX(self.temperatureLabel.frame) + DTMElementsOffset, CGRectGetMaxY(self.cityLabel.frame) + DTMElementsOffset, cityLabelWidth, DTMWeatherImageViewSize.width/2);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForCellForCityName: (NSString *_Nonnull)cityName
{
    DTMMainTableViewCell *testCell = [[DTMMainTableViewCell alloc] init];
    testCell.cityLabel.text = cityName;
    testCell.dateLabel.text = DTMTestDate;
    [testCell layoutSubviews];
    
    CGFloat height = CGRectGetMaxY(testCell.dateLabel.frame) + DTMElementsOffset;
    
    if (CGRectGetMaxY(testCell.imageView.frame) > height) return CGRectGetMaxY(testCell.imageView.frame);
    
    return height;
}

@end
