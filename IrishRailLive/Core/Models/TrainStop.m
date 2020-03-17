//
//  TrainMovement.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/15/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "TrainStop.h"

@implementation TrainStop

- (instancetype)initWithTrainCode:(NSString*)trainCode
                        trainDate:(NSString*)trainDate
                     locationCode:(NSString*)locationCode
                 locationFullName:(NSString*)locationFullName
                    locationOrder:(NSInteger)locationOrder
                     locationType:(LocationType)locationType
                      trainOrigin:(NSString*)trainOrigin
                 trainDestination:(NSString*)trainDestination
                 scheduledArrival:(NSString*)scheduledArrival
               scheduledDeparture:(NSString*)scheduledDeparture
                          arrival:(NSString*)arrival
                        departure:(NSString*)departure
                  expectedArrival:(NSString*)expectedArrival
                expectedDeparture:(NSString*)expectedDeparture
                      autoArrival:(BOOL)autoArrival
                       autoDepart:(BOOL)autoDepart
                         stopType:(StopType)stopType
{
    self = [super init];
    if (self) {
        _trainCode = trainCode;
        _trainDate = trainDate;
        _locationCode = locationCode;
        _locationFullName = locationFullName;
        _locationOrder = locationOrder;
        _locationType = locationType;
        _trainOrigin = trainOrigin;
        _trainDestination = trainDestination;
        _scheduledArrival = scheduledArrival;
        _scheduledDeparture = scheduledDeparture;
        _arrival = arrival;
        _departure = departure;
        _expectedArrival = expectedArrival;
        _expectedDeparture = expectedDeparture;
        _autoArrival = autoArrival;
        _autoDepart = autoDepart;
        _stopType = stopType;
    }
    return self;
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"<%@> trainCode: %@, trainDate: %@, locationCode: %@, locationFullName: %@, locationOrder: %tu, locationType: %tu, trainOrigin: %@, trainDestination: %@, scheduledArrival: %@, scheduledDeparture: %@, arrival: %@, departure: %@, autoArrival: %d, autoDepart: %d, stopType: %tu", self.className, _trainCode, _trainDate, _locationCode, _locationFullName, _locationOrder, _locationType, _trainOrigin, _trainDestination, _scheduledArrival, _scheduledDeparture, _arrival, _departure, _autoArrival, _autoDepart, _stopType];
}

@end
