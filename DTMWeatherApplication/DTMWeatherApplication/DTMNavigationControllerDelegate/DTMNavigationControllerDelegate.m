//
//  DTMNavigationControllerDelegate.m
//  DTMWeatherApplication
//
//  Created by user on 30.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import "DTMNavigationControllerDelegate.h"
#import "DTMPopViewControllerAnimation.h"
#import "DTMPushViewControllerAnimation.h"

@implementation DTMNavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    return operation == UINavigationControllerOperationPush ? [DTMPushViewControllerAnimation new] : [DTMPopViewControllerAnimation new];
}


@end
