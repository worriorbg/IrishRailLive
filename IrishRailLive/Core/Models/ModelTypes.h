//
//  ModelTypes.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/15/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#ifndef ModelTypes_h
#define ModelTypes_h

typedef NS_ENUM(NSUInteger, LocationType) {
    LocationTypeOrigin,
    LocationTypeStop,
    LocationTypeTimingPoint, // non stopping location
    LocationTypeDestination,
    
    LocationTypeUnknown = NSUIntegerMax
};

typedef NS_ENUM(NSUInteger, TrainStatus) {
    TrainStatusNotRunning,
    TrainStatusRunning,
    TrainStatusTerminated,
    
    TrainStatusUnknown = NSUIntegerMax,
};

typedef NS_ENUM(NSUInteger, StopType) {
    StopTypeCurrent,
    StopTypeNext,
    
    StopTypeUnknown
};

#endif /* ModelTypes_h */
