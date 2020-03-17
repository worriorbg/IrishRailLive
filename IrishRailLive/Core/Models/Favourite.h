//
//  Favourite.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StationData.h"

NS_ASSUME_NONNULL_BEGIN

@interface Favourite : NSObject

@property (nonatomic, readonly) NSString* origin;
@property (nonatomic, readonly) NSString* originCode;
@property (nonatomic, readonly) NSString* destination;
@property (nonatomic, readonly) NSString* destinationCode;

@property (nullable, nonatomic, readonly) StationData* stationData;

- (instancetype)initWithOrigin:(NSString*)origin
                    originCode:(NSString*)originCode
                   destination:(NSString*)destination
            andDestinationCode:(NSString*)destinationCode;

- (void)setStationData:(StationData*)stationData;

@end

NS_ASSUME_NONNULL_END
