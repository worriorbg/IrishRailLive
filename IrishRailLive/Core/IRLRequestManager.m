//
//  RequestManager.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "IRLRequestManager.h"
#import "IRLXMLResponseSerializer.h"
#import <AFNetworking/AFNetworking.h>
#import "XMLParser.h"

@interface IRLRequestManager()

@property (nonatomic, strong) AFURLSessionManager* sessionManager;
@property (nonatomic, strong) NSDictionary* config;
@property (nonatomic, strong) XMLParser* modelParser;

@end

@implementation IRLRequestManager

#pragma mark - Constants
static NSString* const kApiBasePath = @"http://api.irishrail.ie/"; // NOTE: try with SSL
static NSString* const kApiRealTimeComponent = @"realtime/realtime.asmx/";

static NSString* const kServiceNameKey = @"ServiceName";

#pragma mark - Public Method

+ (IRLRequestManager *)sharedInstance
{
    static IRLRequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [IRLRequestManager alloc];
        sharedInstance = [sharedInstance init];
        [sharedInstance configure];
    });
    return sharedInstance;
}

- (NSURL *)apiURL {
    if (!_apiURL) {
        _apiURL = [[NSURL URLWithString: kApiBasePath] URLByAppendingPathComponent:kApiRealTimeComponent];
    }
    
    return _apiURL;
}

- (void)configure {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    _sessionManager.securityPolicy.allowInvalidCertificates = YES;
    _sessionManager.responseSerializer = [IRLXMLResponseSerializer serializer];
    _modelParser = [[XMLParser alloc] init];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    NSDictionary* config = @{
         @(RequestTypeGetAllStations)                                   : @{kServiceNameKey: @"getAllStationsXML"},
         @(RequestTypeGetAllStationsWithType)                           : @{kServiceNameKey: @"getAllStationsXML_WithStationType"},
         @(RequestTypeGetCurrentTrains)                                 : @{kServiceNameKey: @"getCurrentTrainsXML"},
         @(RequestTypeGetCurrentTrainsWithType)                         : @{kServiceNameKey: @"getCurrentTrainsXML_WithTrainType"},
         @(RequestTypeGetStationDataByName)                             : @{kServiceNameKey: @"getStationDataByNameXML"},
         @(RequestTypeGetStationDataByNameWithNumberOfMinutes)          : @{kServiceNameKey: @"getStationDataByNameXML"},
         @(RequestTypeGetStationDataWithStationCode)                    : @{kServiceNameKey: @"getStationDataByCodeXML"},
         @(RequestTypeGetStationDataWithStationCodeWithNumberOfMinutes) : @{kServiceNameKey: @"getStationDataByCodeXML_WithNumMins"},
         @(RequestTypeGetStationFilter)                                 : @{kServiceNameKey: @"getStationsFilterXML"},
         @(RequestTypeGetTrainMovements)                                : @{kServiceNameKey: @"getTrainMovementsXML"},
    };

    _config = config;
}

- (NSURL*)urlForRequestType:(RequestType)requestType {
    NSDictionary* requestInfo = [self.config objectForKey:@(requestType)];
    NSAssert(requestInfo != nil, @"Request type (%d) does not exist!", (int)requestType);

    NSString* serviceName = [requestInfo objectForKey:kServiceNameKey];
    NSAssert(serviceName != nil, @"There is no service name for type %d", (int)requestType);

    // base service url
    NSURL* requestURL = [self.apiURL URLByAppendingPathComponent:serviceName];
    
    return requestURL;
}

#pragma mark -
#pragma mark Requests
#pragma mark -

#pragma mark Stations

- (NSURLSessionDataTask *)getAllStationsWithCompletion:(nullable void (^)(NSArray<Station*>* _Nullable stations,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    return [self requestOfType:RequestTypeGetAllStations withParams:nil completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<Station*>* result = [strongSelf->_modelParser parseStations:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

- (NSURLSessionDataTask *)getAllStationsWithType:(StationType)stationType completion:(nullable void (^)(NSArray<Station*>* _Nullable stations,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{ kStationTypeUrlParam : StationTypeToString(stationType) };
    return [self requestOfType:RequestTypeGetAllStationsWithType withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<Station*>* result = [strongSelf->_modelParser parseStations:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

#pragma mark Trains

- (NSURLSessionDataTask *)getCurrentTrainsWithCompletion:(nullable void (^)(NSArray<Train*>* _Nullable trains,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    return [self requestOfType:RequestTypeGetCurrentTrains withParams:nil completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<Train*>* result = [strongSelf->_modelParser parseTrains:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

- (NSURLSessionDataTask *)getCurrentTrainsWithType:(StationType)trainType completion:(nullable void (^)(NSArray<Train*>* _Nullable trains,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{ kTrainTypeUrlParam : StationTypeToString(trainType) };
    return [self requestOfType:RequestTypeGetCurrentTrainsWithType withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<Train*>* result = [strongSelf->_modelParser parseTrains:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

#pragma mark Station Data

- (NSURLSessionDataTask *)getStationDataByName:(NSString*)stationName completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{ kStationDescriptionUrlParam : stationName };
    return [self requestOfType:RequestTypeGetStationDataByName withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<StationData*>* result = [strongSelf->_modelParser parseStationDatas:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

- (NSURLSessionDataTask *)getStationDataByName:(NSString*)stationName andNumberOfMinutes:(NSUInteger)numberOfMinutes completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{
        kStationDescriptionUrlParam : stationName,
        kNumberOfMinutesUrlParam : @(numberOfMinutes)
    };
    return [self requestOfType:RequestTypeGetStationDataByNameWithNumberOfMinutes withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<StationData*>* result = [strongSelf->_modelParser parseStationDatas:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

- (NSURLSessionDataTask *)getStationDataByCode:(NSString*)stationCode completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{ kStationCodeUrlParam : stationCode };
    return [self requestOfType:RequestTypeGetStationDataWithStationCode withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<StationData*>* result = [strongSelf->_modelParser parseStationDatas:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

- (NSURLSessionDataTask *)getStationDataByCode:(NSString*)stationCode andNumberOfMinutes:(NSUInteger)numberOfMinutes completion:(nullable void (^)(NSArray<StationData*>* _Nullable stations,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{
        kStationCodeUrlParam : stationCode,
        kNumberOfMinutesUrlParam : @(numberOfMinutes)
    };
    return [self requestOfType:RequestTypeGetStationDataWithStationCodeWithNumberOfMinutes withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<StationData*>* result = [strongSelf->_modelParser parseStationDatas:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

#pragma mark Station Names

- (NSURLSessionDataTask *)getAllStationNamesWithCompletion:(nullable void (^)(NSArray<StationFilter*>* _Nullable stationNames,  NSError* _Nullable error))completionHandler {
    return [self getStationsFilter:@"" completion:completionHandler];
}

#pragma mark Station Filter

- (NSURLSessionDataTask *)getStationsFilter:(NSString*)stationText completion:(nullable void (^)(NSArray<StationFilter*>* _Nullable stationNames,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{ kStationTextUrlParam : stationText };
    return [self requestOfType:RequestTypeGetStationFilter withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<StationFilter*>* result = [strongSelf->_modelParser parseStationFilters:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

#pragma mark Train Movements

- (NSURLSessionDataTask *)getTrainStopsForTrainId:(NSString*)trainId andTrainDate:(NSString*)trainDate completion:(nullable void (^)(NSArray<TrainStop*>* _Nullable trainMovements,  NSError* _Nullable error))completionHandler {
    __weak __typeof(self) weakSelf = self;
    
    NSDictionary* params = @{
        kTrainIdUrlParam : trainId,
        kTrainDateUrlParam : trainDate
    };
    return [self requestOfType:RequestTypeGetTrainMovements withParams:params completionHandler:^(GDataXMLDocument* xmlDoc, NSError *error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (xmlDoc == nil) return completionHandler(nil, error);
        
        NSArray<TrainStop*>* result = [strongSelf->_modelParser parseTrainMovements:xmlDoc.rootElement];
        
        completionHandler(result, nil);
    }];
}

#pragma mark - Helpers

- (NSURLSessionDataTask *)requestOfType:(RequestType)requestType withParams:(NSDictionary*)params completionHandler:(nullable void (^)(GDataXMLDocument* _Nullable xmlDoc,  NSError* _Nullable error))completion {
    NSURL* requestURL = [self urlForRequestType:requestType];
    NSURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:requestURL.absoluteString parameters:params error:nil];
    
    NSURLSessionDataTask* dataTask = [_sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil
                              completionHandler:^(NSURLResponse* response, id responseObject, NSError* error) {
        completion(responseObject, error);
    }];
    
    [dataTask resume];
    return dataTask;
}

@end
