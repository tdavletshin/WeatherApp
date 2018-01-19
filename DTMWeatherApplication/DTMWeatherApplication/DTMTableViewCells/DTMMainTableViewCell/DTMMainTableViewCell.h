//
//  DTMMainTableViewCell.h
//  DTMWeatherApplication
//
//  Created by user on 07.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef void (^ButtonBlock)(NSUInteger indexInDataModel);


@interface DTMMainTableViewCell : UITableViewCell


@property (nonatomic, strong, nonnull) UILabel *temperatureLabel;
@property (nonatomic, strong, nonnull) UILabel *cityLabel;
@property (nonatomic, strong, nonnull) UILabel *dateLabel;
@property (nonatomic, strong, nonnull) UIImageView *weatherImageView;
@property (nonatomic, strong, nonnull) UIButton *detailButton;
@property (nonatomic, assign) NSUInteger indexInDataModel;
@property (nonatomic, copy, nullable) ButtonBlock buttonBlock;

- (CGFloat)heightForCellWithCityName: (NSString *_Nonnull)cityName withDate: (NSString *_Nonnull)Date;


@end
