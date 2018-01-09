//
//  DTMPushViewControllerAnimation.m
//  DTMWeatherApplication
//
//  Created by user on 30.12.2017.
//  Copyright © 2017 Davletshin Timur. All rights reserved.
//

#import "DTMPushViewControllerAnimation.h"

static const NSInteger DTMAnimationShift = -2;

@implementation DTMPushViewControllerAnimation

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationViewController =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview:destinationViewController.view];
    
    destinationViewController.view.center = CGPointMake(sourceViewController.view.center.x * DTMAnimationShift, sourceViewController.view.center.y);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:
     ^{
         destinationViewController.view.center = sourceViewController.view.center;
     }
     
                     completion:^(BOOL finished)
     {
         [transitionContext completeTransition:YES];
     }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{ 
    return 2.0;
}

@end
