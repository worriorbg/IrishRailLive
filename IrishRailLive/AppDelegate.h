//
//  AppDelegate.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate: UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow* window;

- (void)replaceRootViewController:(UIViewController*)currentVC;

@end
