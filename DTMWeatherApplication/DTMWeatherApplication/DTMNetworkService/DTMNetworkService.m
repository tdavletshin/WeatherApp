//
//  DTMNetworkService.m
//  DTMWeatherApplication
//
//  Created by user on 14.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//


#import "DTMNetworkService.h"


static NSString *const APIKey = @"9174e54fa42ba3f00260dfec4cc770cf";
static NSString *const WEBServiceAddress = @"https://api.openweathermap.org";


@implementation DTMNetworkService


+ (void)getDataWithCityId:(int64_t)cityId completionHandler:(CompletionBlock)completionBlock;
{
    NSString *urlSring = [NSString stringWithFormat:@"%@/data/2.5/weather?id=%lld&units=metric&APPID=%@", WEBServiceAddress, cityId, APIKey];
    NSURL *url = [NSURL URLWithString:urlSring];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        completionBlock(error, data);
    }];
    [dataTask resume];
}


@end
