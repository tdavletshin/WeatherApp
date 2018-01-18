//
//  DTMAddingTableViewCell.h
//  DTMWeatherApplication
//
//  Created by user on 11.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface DTMAddingTableViewCell : UITableViewCell


@property (nonatomic, strong, nonnull) UILabel *cityLabel;
@property (nonatomic, strong, nonnull) UILabel *countryLabel;

- (CGFloat)heightForCellWithCityName: (NSString *_Nonnull)cityName withCountryName: (NSString *_Nonnull)countryName;


@end
