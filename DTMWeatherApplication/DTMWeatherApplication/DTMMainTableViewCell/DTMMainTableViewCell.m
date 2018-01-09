//
//  DTMMainTableViewCell.m
//  DTMWeatherApplication
//
//  Created by user on 07.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMMainTableViewCell.h"
#import <Masonry/Masonry.h>


static const CGFloat DTMElementsOffset = 10.f;
static const CGSize DTMWeatherImageViewSize = {50.f, 50.f};
static const CGSize DTMDetailButtonSize = {50.f, 50.f};
static NSString *const DTMTestDate = @"07/01/2018 15:40";
static NSString *const DTMTemperatureLabelFontName = @"Georgia-BoldItalic";
static NSString *const DTMCityLabelFontName = @"Courier-Bold";
static NSString *const DTMDateLabelFontName = @"Georgia-BoldItalic";
static CGFloat DTMCellAlphaValue = 0.7;

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
    
    _detailButton = [[UIButton alloc] init];
    [_detailButton setImage:[UIImage imageNamed:@"arrow.jpg"] forState:UIControlStateNormal];
    _detailButton.imageView.layer.cornerRadius = DTMDetailButtonSize.height/2;
    [self.contentView addSubview:_detailButton];
    
    [self.contentView setBackgroundColor:UIColor.clearColor];
    [self.backgroundView setBackgroundColor:UIColor.clearColor];
    [self setBackgroundColor:UIColor.clearColor];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell.jpg"]];
    self.backgroundView.alpha = DTMCellAlphaValue;
    
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell.jpg"]];
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.weatherImageView.frame = CGRectMake(DTMElementsOffset, DTMElementsOffset, DTMWeatherImageViewSize.width, DTMWeatherImageViewSize.height);
    
    CGSize temperatureLabelSize = [self.temperatureLabel sizeThatFits:CGSizeMake(2 * DTMWeatherImageViewSize.width, CGFLOAT_MAX)];
    
    self.temperatureLabel.frame = CGRectMake(CGRectGetMaxX(self.weatherImageView.frame) + DTMElementsOffset, DTMElementsOffset, 1.5 * DTMWeatherImageViewSize.width, temperatureLabelSize.height);
    
    CGFloat cityLabelWidth = CGRectGetMaxX(self.contentView.frame) - CGRectGetMaxX(self.temperatureLabel.frame) - 4 * DTMElementsOffset - DTMDetailButtonSize.width;
    
    CGSize cityLabelSize = [self.cityLabel sizeThatFits:CGSizeMake(cityLabelWidth, CGFLOAT_MAX)];
    
    self.cityLabel.frame = CGRectMake(CGRectGetMaxX(self.temperatureLabel.frame) +  DTMElementsOffset, DTMElementsOffset, cityLabelWidth, cityLabelSize.height);
    
    self.dateLabel.frame = CGRectMake(CGRectGetMaxX(self.temperatureLabel.frame) + DTMElementsOffset, CGRectGetMaxY(self.cityLabel.frame) + DTMElementsOffset, cityLabelWidth, DTMWeatherImageViewSize.width/2);
    
    self.detailButton.frame = CGRectMake(CGRectGetMaxX(self.cityLabel.frame) + DTMElementsOffset, DTMElementsOffset, DTMDetailButtonSize.width, DTMDetailButtonSize.height);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForCellForCityName: (NSString *_Nonnull)cityName
{
    DTMMainTableViewCell *testCell = [[DTMMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IDENTIFY"];
    
    testCell.cityLabel.text = cityName;
    testCell.dateLabel.text = DTMTestDate;
    
    [testCell layoutSubviews];
    
    CGFloat height = testCell.cityLabel.frame.size.height + testCell.dateLabel.frame.size.height + 3 * DTMElementsOffset;
    
    if (CGRectGetMaxY(testCell.imageView.frame) > height) return CGRectGetMaxY(testCell.imageView.frame);
    
    return height;
}

@end
