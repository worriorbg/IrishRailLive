//
//  Station.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "Station.h"

@implementation Station

- (instancetype)initWithId:(NSInteger)stationId
                      code:(NSString*)code
                      name:(NSString*)name
                     alias:(nullable NSString*)alias
                  latitude:(double)latitude
                 longitude:(double)longitude
{
    self = [super init];
    if (self) {
        _stationId = stationId;
        _code = code;
        _name = name;
        _alias = alias;
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@> id: %4tu, code: %@, name: %@, alias: %@, lat: %f, long: %f", self.className, _stationId, _code, _name, _alias, _latitude, _longitude];
}

@end
