//
//  StationData.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StationData.h"

@implementation StationData

- (instancetype)initWithServerTime:(NSString*)serverTime
                         trainCode:(NSString*)trainCode
                   stationFullName:(NSString*)stationFullName
                       stationCode:(NSString*)stationCode
                         queryTime:(NSString*)queryTime
                         trainDate:(NSString*)trainDate
                            origin:(NSString*)origin
                       destination:(NSString*)destination
                        originTime:(NSString*)originTime
                   destinationTime:(NSString*)destinationTime
                            status:(NSString*)status
                      lastLocation:(NSString*)lastLocation
                             dueIn:(NSString*)dueIn
                              late:(NSString*)late
                   expectedArrival:(NSString*)expectedArrival
                 expectedDeparture:(NSString*)expectedDeparture
                  scheduledArrival:(NSString*)scheduledArrival
                scheduledDeparture:(NSString*)scheduledDeparture
                         direction:(NSString*)direction
                         trainType:(NSString*)trainType
                      locationType:(LocationType)locationType
{
    self = [super init];
    if (self) {
        _serverTime = serverTime;
        _trainCode = trainCode;
        _stationFullName = stationFullName;
        _stationCode = stationCode;
        _queryTime = queryTime;
        _trainDate = trainDate;
        _origin = origin;
        _destination = destination;
        _originTime = originTime;
        _destinationTime = destinationTime;
        _status = status;
        _lastLocation = lastLocation;
        _dueIn = dueIn;
        _late = late;
        _expectedArrival = expectedArrival;
        _expectedDeparture = expectedDeparture;
        _scheduledArrival = scheduledArrival;
        _scheduledDeparture = scheduledDeparture;
        _direction = direction;
        _trainType = trainType;
        _locationType = locationType;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@> serverTime: %@, trainCode: %@, stationFullName: %@, stationCode: %@, queryTime: %@, trainDate: %@, origin: %@, destination: %@, originTime: %@, destinationTime: %@, status: %@, lastLocation: %@, dueIn: %@, late: %@, expectedArrival: %@, expectedDeparture: %@, scheduledArrival: %@, scheduledDeparture: %@, direction: %@, trainType: %@, locationType: %tu", self.className, _serverTime, _trainCode, _stationFullName, _stationCode, _queryTime, _trainDate, _origin, _destination, _originTime, _destinationTime, _status, _lastLocation, _dueIn, _late, _expectedArrival, _expectedDeparture, _scheduledArrival, _scheduledDeparture, _direction, _trainType, _locationType];
}

@end
