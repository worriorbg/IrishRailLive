//
//  StationData.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationData : NSObject

/// The time on the server
@property (nonatomic, readonly) NSString* serverTime;
/// Unique Id for the train
@property (nonatomic, readonly) NSString* trainCode;
/// Long version of Station Name (identical in every record)
@property (nonatomic, readonly) NSString* stationFullName;
/// 4 to 5 letter station abbreviation
@property (nonatomic, readonly) NSString* stationCode;
/// The time the query was made
@property (nonatomic, readonly) NSString* queryTime;
/// The date the service started its journey ( some trains run over midnight)
@property (nonatomic, readonly) NSString* trainDate;
@property (nonatomic, readonly) NSString* origin;
@property (nonatomic, readonly) NSString* destination;
/// The time the train left (or will leave) its origin
@property (nonatomic, readonly) NSString* originTime;
/// The scheduled time at its destination
@property (nonatomic, readonly) NSString* destinationTime;
/// Latest information on this service
@property (nonatomic, readonly) NSString* status;
/// (Arrived|Departed StationName)
@property (nonatomic, readonly) NSString* lastLocation;
/// Num of minutes till the train will arrive here
@property (nonatomic, readonly) NSString* dueIn;
/// Minutes late
@property (nonatomic, readonly) NSString* late;
/// the trains expected arrival time at the query station updated as the train progresses ( note will show 00:00 for trains starting from query station)
@property (nonatomic, readonly) NSString* expectedArrival;
/// the trains expected departure time at the query station updated as the train progresses ( note will show 00:00 for trains terminating at query station)
@property (nonatomic, readonly) NSString* expectedDeparture;
/// the scheduled arrival time ( note will show 00:00 for trains starting from query station)
@property (nonatomic, readonly) NSString* scheduledArrival;
/// the scheduled depart time ( note will show 00:00 for trains terminating at query station)
@property (nonatomic, readonly) NSString* scheduledDeparture;
/// Northbound, Southbound or To Destination
@property (nonatomic, readonly) NSString* direction;
// DART - Intercity etc
@property (nonatomic, readonly) NSString* trainType;
@property (nonatomic, readonly) LocationType locationType;

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
                      locationType:(LocationType)locationType;

@end

NS_ASSUME_NONNULL_END
