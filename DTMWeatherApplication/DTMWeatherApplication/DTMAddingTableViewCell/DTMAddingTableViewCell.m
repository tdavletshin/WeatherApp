//
//  DTMAddingTableViewCell.m
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMAddingTableViewCell.h"
#import <Masonry/Masonry.h>

static NSString *const DTMCityLabelFontName = @"Courier-Bold";
static const CGFloat DTMElementsOffset = 10.0;
static CGFloat DTMAddingCellAlphaValue = 0.5;

@implementation DTMAddingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    _countryLabel = [[UILabel alloc] init];
    _countryLabel.numberOfLines = 0;
    _countryLabel.font = [UIFont fontWithName: DTMCityLabelFontName size:20.0];
    _cityLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:_countryLabel];
    
    _cityLabel = [[UILabel alloc] init];
    _cityLabel.numberOfLines = 0;
    _cityLabel.font = [UIFont fontWithName: DTMCityLabelFontName size:32.0];
    _cityLabel.textColor = UIColor.blackColor;
    [self.contentView addSubview:_cityLabel];
    
    self.contentView.backgroundColor = UIColor.clearColor;
    self.backgroundColor = UIColor.clearColor;
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradient.png"]];
    self.backgroundView.contentMode = UIViewContentModeScaleToFill;
    self.backgroundView.alpha = DTMAddingCellAlphaValue;
    
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradient.png"]];
    self.selectedBackgroundView.contentMode = UIViewContentModeScaleToFill;

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize cityLabelSize = [self.cityLabel sizeThatFits:CGSizeMake(CGRectGetMaxX(self.contentView.frame) - 2*DTMElementsOffset, CGFLOAT_MAX)];
    
    self.cityLabel.frame = CGRectMake(DTMElementsOffset, DTMElementsOffset, cityLabelSize.width, cityLabelSize.height);
    
    CGSize countryLabelSize = [self.countryLabel sizeThatFits:CGSizeMake(CGRectGetMaxX(self.contentView.frame) - 2*DTMElementsOffset, CGFLOAT_MAX)];
    
    self.countryLabel.frame = CGRectMake(DTMElementsOffset, 2 * DTMElementsOffset + cityLabelSize.height, countryLabelSize.width, countryLabelSize.height);
    
    self.backgroundView.frame = CGRectMake(0, 0, CGRectGetMaxX(self.contentView.frame), CGRectGetMaxY(self.countryLabel.frame) + DTMElementsOffset);
    
    self.selectedBackgroundView.frame = CGRectMake(0, 0, CGRectGetMaxX(self.contentView.frame), CGRectGetMaxY(self.countryLabel.frame) + DTMElementsOffset);
}

+ (CGFloat)heightForCellForCityName: (NSString *_Nonnull)cityName andCountryName: (NSString *_Nonnull)countryName
{
    DTMAddingTableViewCell *testCell = [[DTMAddingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TEST.ID"];
    
    testCell.cityLabel.text = cityName;
    testCell.countryLabel.text = countryName;
    
    [testCell layoutSubviews];
    
    return DTMElementsOffset * 4 + CGRectGetMaxY(testCell.countryLabel.frame);
}


@end
