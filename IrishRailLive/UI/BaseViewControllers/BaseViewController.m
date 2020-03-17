//
//  BaseViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// pass a param to describe the state change, an animated flag and a completion block matching UIView animations completion
- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated completion:(nullable void (^)(BOOL))completion {
    [self setTabBarVisible:visible animated:animated animations:nil completion:completion];
}

- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated animations:(nullable void (^)(CGFloat))animations completion:(nullable void (^)(BOOL))completion {

    // bail if the current state matches the desired state
    if ([self tabBarIsVisible] == visible) return (completion)? completion(YES) : nil;

    // get a frame calculation ready
    CGRect frame = self.tabBarController.tabBar.frame;
    CGFloat height = frame.size.height;
    CGFloat offsetY = (visible)? -height : height;

    // zero duration means no animation
    CGFloat duration = (animated)? 0.3 : 0.0;

    [UIView animateWithDuration:duration animations:^{
        self.tabBarController.tabBar.frame = CGRectOffset(frame, 0, offsetY);
        animations(offsetY);
    } completion:completion];
}

// Getter to know the current state
- (BOOL)tabBarIsVisible {
    return self.tabBarController.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame);
}

@end
