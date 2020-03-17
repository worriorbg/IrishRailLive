//
//  UIStoryboard+Utils.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "UIStoryboard+Utils.h"

@implementation UIStoryboard (Utils)

+ (UIStoryboard*)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
}

@end
