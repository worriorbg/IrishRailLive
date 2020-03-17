//
//  Favourite.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "Favourite.h"

@implementation Favourite

- (instancetype)initWithOrigin:(NSString*)origin
                    originCode:(NSString*)originCode
                   destination:(NSString*)destination
            andDestinationCode:(NSString*)destinationCode
{
    self = [super init];
    if (self) {
        _origin = origin;
        _originCode = originCode;
        _destination = destination;
        _destinationCode = destinationCode;
    }
    
    return self;
}

- (void)setStationData:(StationData*)stationData {
    _stationData = stationData;
}

@end
