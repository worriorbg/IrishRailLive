//
//  IRLRequestTypes.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//
#import "IRLRequestTypes.h"


// initialize arrays with explicit indices to make sure
// the string match the enums properly
static NSString * const StationType_toString[] = {
    [StationTypeAll]      = @"A",
    [StationTypeMainline] = @"M",
    [StationTypeSuburban] = @"S",
    [StationTypeDART]     = @"D"
};

NSString* StationTypeToString(StationType value) {
    return StationType_toString[value];
}
