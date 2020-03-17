//
//  AppDelegate.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "AppDelegate.h"
#import "CacheManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    return YES;
}

- (void)replaceRootViewController:(UIViewController*)currentVC {
    UITabBarController* tabVC = [UIStoryboard.mainStoryboard instantiateViewControllerWithIdentifier:UITabBarController.className];
    if (tabVC == nil) return;
    
    //TODO: Animate the transition (https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions)
    self.window.rootViewController = tabVC;
}

@end
