//
//  SplashScreenViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "CacheManager.h"
#import "AppDelegate.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[CacheManager sharedInstance] cacheNeededData:^(NSError * _Nullable error) {
        [self transitionToStartScreen];
    }];
}

- (void)transitionToStartScreen {
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication.sharedApplication delegate];
    [appDelegate replaceRootViewController:self];
}

@end
