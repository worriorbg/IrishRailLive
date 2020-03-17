//
//  CacheManager.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "CacheManager.h"
#import "IRLRequestManager.h"

@interface CacheManager ()

@property (nonatomic, strong) NSArray<Station*>* allStations;
@property (nonatomic, strong) NSDictionary<NSString*, Station*>* allStationsMap;
@property (nonatomic, assign) BOOL areStationsCached;

@end

@implementation CacheManager

+ (CacheManager *)sharedInstance
{
    static CacheManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [CacheManager alloc];
        sharedInstance = [sharedInstance init];
        [sharedInstance configure];
    });
    return sharedInstance;
}

- (void)configure {
    self.areStationsCached = NO;
    self.allStations = [NSArray array];
}

- (void)cacheNeededData:(void (^)(NSError* _Nullable error))completionHandler {
    [IRLRequestManager.sharedInstance getAllStationsWithCompletion:^(NSArray<Station *> * _Nullable stations, NSError * _Nullable error) {
        if (stations == nil) {
            NSLog(@"Error: %@", error);
            completionHandler(error);
            return;
        }
        
        self.allStations = stations;
        NSMutableArray* stationCodes = [NSMutableArray array];
        [stations enumerateObjectsUsingBlock:^(Station * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [stationCodes addObject:obj.code];
        }];
        self.allStationsMap = [[NSDictionary alloc] initWithObjects:stations forKeys:stationCodes];
        self.areStationsCached = YES;
        NSLog(@"All stations cached(%tu)", stations.count);
        
        completionHandler(error);
    }];
}

- (nullable Station*)stationForCode:(NSString*)stationCode {
    if (!self.areStationsCached) return nil;
    
    return _allStationsMap[stationCode];
}

@end
