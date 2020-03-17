//
//  RequestManager.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRLRequestTypes.h"
#import "Models/Models.h"

// API Reference: https://api.irishrail.ie/realtime/

NS_ASSUME_NONNULL_BEGIN

@interface IRLRequestManager: NSObject

@property (nonatomic, strong) NSURL* apiURL;

+ (IRLRequestManager *)sharedInstance;

// Requests

// Stations
- (NSURLSessionDataTask *)getAllStationsWithCompletion:(nullable void (^)(NSArray<Station*>* _Nullable stations,  NSError* _Nullable error))completionHandler;
- (NSURLSessionDataTask *)getAllStationsWithType:(StationType)stationType completion:(nullable void (^)(NSArray<Station*>* _Nullable stations,  NSError* _Nullable error))completionHandler;

// Trains
- (NSURLSessionDataTask *)getCurrentTrainsWithCompletion:(nullable void (^)(NSArray<Train*>* _Nullable trains,  NSError* _Nullable error))completionHandler;
- (NSURLSessionDataTask *)getCurrentTrainsWithType:(StationType)trainType completion:(nullable void (^)(NSArray<Train*>* _Nullable trains,  NSError* _Nullable error))completionHandler;

// Stations Data
- (NSURLSessionDataTask *)getStationDataByName:(NSString*)stationName completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler;
- (NSURLSessionDataTask *)getStationDataByName:(NSString*)stationName andNumberOfMinutes:(NSUInteger)numberOfMinutes completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler;

- (NSURLSessionDataTask *)getStationDataByCode:(NSString*)stationCode completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler;
- (NSURLSessionDataTask *)getStationDataByCode:(NSString*)stationCode andNumberOfMinutes:(NSUInteger)numberOfMinutes completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler;

// Stations Filter
- (NSURLSessionDataTask *)getAllStationNamesWithCompletion:(nullable void (^)(NSArray<StationFilter*>* _Nullable stationNames,  NSError* _Nullable error))completionHandler;
- (NSURLSessionDataTask *)getStationsFilter:(NSString*)stationText completion:(nullable void (^)(NSArray<StationFilter*>* _Nullable stationNames,  NSError* _Nullable error))completionHandler;

// Train Movements
- (NSURLSessionDataTask *)getTrainStopsForTrainId:(NSString*)trainId andTrainDate:(NSString*)trainDate completion:(nullable void (^)(NSArray<TrainStop*>* _Nullable trainStops,  NSError* _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
