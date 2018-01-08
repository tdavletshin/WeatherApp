//
//  DTMMainTableViewCell.h
//  DTMWeatherApplication
//
//  Created by user on 07.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTMMainTableViewCell : UITableViewCell

@property (nonatomic, strong, nonnull) UILabel *temperatureLabel;
@property (nonatomic, strong, nonnull) UILabel *cityLabel;
@property (nonatomic, strong, nonnull) UILabel *dateLabel;
@property (nonatomic, strong, nonnull) UIImageView *weatherImageView;

+ (CGFloat)heightForCellForCityName: (NSString *_Nonnull)cityName;

@end
