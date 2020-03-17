//
//  Consts.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/15/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "Consts.h"

UIColor* GetTrainStatusNotRunningColor() {
    static UIColor* __trainStatusNotRunningColor = nil;
    if (!__trainStatusNotRunningColor) __trainStatusNotRunningColor = [UIColor systemYellowColor];
    
    return __trainStatusNotRunningColor;
}

UIColor* GetTrainStatusRunningColor() {
    static UIColor* __trainStatusRunningColor = nil;
    if (!__trainStatusRunningColor) __trainStatusRunningColor = [UIColor systemGreenColor];
    
    return __trainStatusRunningColor;
}

UIColor* GetTrainStatusTerminatedColor() {
    static UIColor* __trainStatusTerminatedColor = nil;
    if (!__trainStatusTerminatedColor) __trainStatusTerminatedColor = [UIColor systemRedColor];
    
    return __trainStatusTerminatedColor;
}
