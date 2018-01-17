//
//  DTMNetworkService.h
//  DTMWeatherApplication
//
//  Created by user on 14.01.2018.
//  Copyright © 2018 Davletshin Timur. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(NSError * _Nullable error, NSData * _Nullable data);

@interface DTMNetworkService : NSObject

+ (void)getDataWithCityId: (int64_t)cityId completionHandler:(CompletionBlock _Nonnull )completionBlock;

@end
