//
//  NSObject+Utils.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

- (NSString *)className {
    return [[self class] className];
}

@end
