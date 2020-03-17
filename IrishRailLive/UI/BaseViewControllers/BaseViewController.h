//
//  BaseViewController.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated completion:(nullable void (^)(BOOL))completion;
- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated animations:(nullable void (^)(CGFloat))animations completion:(nullable void (^)(BOOL))completion;
- (BOOL)tabBarIsVisible;

@end

NS_ASSUME_NONNULL_END
