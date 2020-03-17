//
//  StationFilter.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StationFilter.h"

@implementation StationFilter

- (instancetype)initWithCode:(NSString*)code
                        name:(NSString*)name
                      nameSp:(NSString*)nameSp
{
    self = [super init];
    if (self) {
        _code = code;
        _name = name;
        _nameSp = nameSp;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@> code: %@, name: %@, name_sp: %@", self.className, _code, _name, _nameSp];
}

@end
