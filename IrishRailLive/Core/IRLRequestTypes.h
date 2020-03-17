//
//  IRLRequestTypes.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#ifndef IRLRequestTypes_h
#define IRLRequestTypes_h

typedef void (^CompletionBlock)(id xmlObject, NSError* error);

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGetAllStations,
    RequestTypeGetAllStationsWithType,
    RequestTypeGetCurrentTrains,
    RequestTypeGetCurrentTrainsWithType,
    RequestTypeGetStationDataByName,
    RequestTypeGetStationDataByNameWithNumberOfMinutes,
    RequestTypeGetStationDataWithStationCode,
    RequestTypeGetStationDataWithStationCodeWithNumberOfMinutes,
    RequestTypeGetStationFilter,
    RequestTypeGetTrainMovements,
};

typedef NS_ENUM(NSUInteger, StationType) {
    StationTypeAll, // A
    StationTypeMainline, // M
    StationTypeSuburban, // S
    StationTypeDART // D
};

static NSString* const kStationTypeUrlParam = @"StationType";
static NSString* const kStationDescriptionUrlParam = @"StationDesc";
static NSString* const kStationCodeUrlParam = @"StationCode";
static NSString* const kStationTextUrlParam = @"StationText";
static NSString* const kNumberOfMinutesUrlParam = @"NumMins";

static NSString* const kTrainTypeUrlParam = @"TrainType";
static NSString* const kTrainIdUrlParam = @"TrainId";
static NSString* const kTrainDateUrlParam = @"TrainDate";

NSString* StationTypeToString(StationType value);

#endif /* IRLRequestTypes_h */
