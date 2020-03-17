//
//  TrainStop.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/15/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainStop : NSObject

@property (nonatomic, readonly) NSString* trainCode;
@property (nonatomic, readonly) NSString* trainDate;
@property (nonatomic, readonly) NSString* locationCode;
@property (nonatomic, readonly) NSString* locationFullName;
@property (nonatomic, readonly) NSInteger locationOrder;
@property (nonatomic, readonly) LocationType locationType;
@property (nonatomic, readonly) NSString* trainOrigin;
@property (nonatomic, readonly) NSString* trainDestination;
@property (nonatomic, readonly) NSString* scheduledArrival;
@property (nonatomic, readonly) NSString* scheduledDeparture;
/// Actual Arrival
@property (nonatomic, readonly) NSString* arrival;
@property (nonatomic, readonly) NSString* expectedArrival;
/// Actual Departure
@property (nonatomic, readonly) NSString* departure;
@property (nonatomic, readonly) NSString* expectedDeparture;
/// was information automatically generated
@property (nonatomic, readonly) BOOL autoArrival;
@property (nonatomic, readonly) BOOL autoDepart;
@property (nonatomic, readonly) StopType stopType;

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
                         stopType:(StopType)stopType;

@end

NS_ASSUME_NONNULL_END
