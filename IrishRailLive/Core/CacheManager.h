//
//  CacheManager.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models.h"

NS_ASSUME_NONNULL_BEGIN

@interface CacheManager : NSObject

+ (CacheManager *)sharedInstance;

- (void)cacheNeededData:(void (^)(NSError* _Nullable error))completionHandler;
- (nullable Station*)stationForCode:(NSString*)stationCode;

@end

NS_ASSUME_NONNULL_END
