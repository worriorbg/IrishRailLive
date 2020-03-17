//
//  Station.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Station : NSObject

@property (nonatomic, readonly) NSInteger stationId;
@property (nonatomic, readonly) NSString* code;
@property (nonatomic, readonly) NSString* name;
@property (nullable, nonatomic, readonly) NSString* alias;
@property (nonatomic, readonly, assign) double latitude;
@property (nonatomic, readonly, assign) double longitude;

- (instancetype)initWithId:(NSInteger)stationId
                      code:(NSString*)code
                      name:(NSString*)name
                     alias:(nullable NSString*)alias
                  latitude:(double)latitude
                 longitude:(double)longitude;

@end

NS_ASSUME_NONNULL_END
