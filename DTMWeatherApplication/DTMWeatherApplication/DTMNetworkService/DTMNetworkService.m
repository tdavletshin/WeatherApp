//
//  DTMNetworkService.m
//  DTMWeatherApplication
//
//  Created by user on 14.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import "DTMNetworkService.h"

static NSString *const APIKey = @"9174e54fa42ba3f00260dfec4cc770cf";

@interface DTMNetworkService ()

@property NSURLSession *urlSession;
@property NSURLSessionDataTask *dataTask;

@end

@implementation DTMNetworkService

- (void)GetDataWithCityId:(int64_t)cityId completionHandler:(CompletionBlock)completionBlock;
{
    NSString *urlSring = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?id=%lld&units=metric&APPID=%@", cityId, APIKey];
    NSURL *url = [NSURL URLWithString:urlSring];
    
    self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    self.dataTask = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        completionBlock(error, data);
    }];
    [self.dataTask resume];
}

@end
