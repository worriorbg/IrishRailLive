//
//  XMLParser.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser ()

@property (nonatomic, strong) NSDictionary<NSString*, NSNumber*> * trainStatusToString;
@property (nonatomic, strong) NSDictionary<NSString*, NSNumber*> * locationTypeToString;
@property (nonatomic, strong) NSDictionary<NSString*, NSNumber*> * stopTypeToString;

@end

@implementation XMLParser

- (instancetype)init {
    self = [super init];

    if (self) {
        _trainStatusToString = @{
            @"N": @(TrainStatusNotRunning),
            @"R": @(TrainStatusRunning),
            @"T": @(TrainStatusTerminated),
        };
        _locationTypeToString = @{
            @"O": @(LocationTypeOrigin),
            @"D": @(LocationTypeDestination),
            @"T": @(LocationTypeTimingPoint),
            @"S": @(LocationTypeStop),
        };
        _stopTypeToString = @{
            @"C": @(StopTypeCurrent),
            @"N": @(StopTypeNext),
        };
    }
    
    return self;
}

#pragma mark -

- (LocationType)locationTypeFromString:(NSString*)typeString {
    LocationType result = LocationTypeUnknown;
    
    NSNumber* locationTypeNumber = [_locationTypeToString objectForKey:typeString];
    if (locationTypeNumber == nil) return result;
    
    return (LocationType)locationTypeNumber.unsignedIntegerValue;
}

- (TrainStatus)trainStatusFromString:(NSString*)statusString {
    TrainStatus result = TrainStatusUnknown;
    
    NSNumber* trainStatusNumber = [_trainStatusToString objectForKey:statusString];
    if (trainStatusNumber == nil) return result;
    
    return (TrainStatus)trainStatusNumber.unsignedIntegerValue;
}

- (StopType)stopTypeFromString:(NSString*)typeString {
    StopType result = StopTypeUnknown;
    
    NSNumber* stopTypeNumber = [_stopTypeToString objectForKey:typeString];
    if (stopTypeNumber == nil) return result;
    
    return (StopType)stopTypeNumber.unsignedIntegerValue;
}

#pragma mark - Indidual parsing functionality

- (Station *)parseStation:(XMLElement *)element {
    NSInteger stationId     = [self firstIntegerValueForKey:@"StationId"        forElement:element withDefaultValue:0];
    NSString* stationCode   = [self firstStringValueForKey:@"StationCode"       forElement:element withDefaultValue:@""];
    NSString* stationDesc   = [self firstStringValueForKey:@"StationDesc"       forElement:element withDefaultValue:@""];
    NSString* stationAlias  = [self firstStringValueForKey:@"StationAlias"      forElement:element withDefaultValue:nil];
    double stationLatitude  = [self firstDoubleValueForKey:@"StationLatitude"   forElement:element withDefaultValue:0];
    double stationLongitude = [self firstDoubleValueForKey:@"StationLongitude"  forElement:element withDefaultValue:0];
    
    stationAlias = [stationAlias stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    stationAlias = [stationAlias stringByReplacingOccurrencesOfString:@"( " withString:@"("];
    stationAlias = [stationAlias stringByReplacingOccurrencesOfString:@" )" withString:@")"];
    
    stationCode = [stationCode stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];

    return [[Station alloc] initWithId:stationId
                                  code:stationCode
                                  name:stationDesc
                                 alias:stationAlias
                              latitude:stationLatitude
                             longitude:stationLongitude];
}

- (NSArray<Station *> *)parseStations:(XMLElement *)element {
    NSMutableArray<Station*>* result = [[NSMutableArray alloc] init];
    
    NSArray* elements = [element elementsForName:@"objStation"];
    for (XMLElement* station in elements) {
        [result addObject:[self parseStation:station]];
    }
    
    return result;
}

#pragma mark - Train

- (Train *)parseTrain:(XMLElement *)element {
    NSString* trainStatusString = [self firstStringValueForKey:@"TrainStatus"       forElement:element withDefaultValue:@""];
    NSString* trainCode         = [self firstStringValueForKey:@"TrainCode"         forElement:element withDefaultValue:@""];
    NSString* trainDate         = [self firstStringValueForKey:@"TrainDate"         forElement:element withDefaultValue:@""];
    NSString* direction         = [self firstStringValueForKey:@"Direction"         forElement:element withDefaultValue:@""];
    double trainLatitude        = [self firstDoubleValueForKey:@"TrainLatitude"     forElement:element withDefaultValue:0];
    double trainLongitude       = [self firstDoubleValueForKey:@"TrainLongitude"    forElement:element withDefaultValue:0];
    NSString* publicMessage     = [self firstStringValueForKey:@"PublicMessage"     forElement:element withDefaultValue:@""];
    
    TrainStatus trainStatus     = [self trainStatusFromString:trainStatusString];
    NSMutableArray* splitMessages = [NSMutableArray arrayWithArray:[publicMessage componentsSeparatedByString:@"\\n"]];
    if (splitMessages.count > 1) [splitMessages removeObjectAtIndex:0];

    return [[Train alloc] initWithCode:trainCode
                                  date:trainDate
                             direction:direction
                                status:trainStatus
                              latitude:trainLatitude
                             longitude:trainLongitude
                        publicMessages:splitMessages];
}

-(NSArray<Train *> *)parseTrains:(XMLElement *)element {
    NSMutableArray<Train*>* result = [[NSMutableArray alloc] init];
    
    NSArray* elements = [element elementsForName:@"objTrainPositions"];
    for (XMLElement* train in elements) {
        [result addObject:[self parseTrain:train]];
    }
    
    return result;
}

#pragma mark - Station Data

- (NSArray<StationData *> *)parseStationDatas:(XMLElement *)element {
    NSMutableArray<StationData*>* result = [[NSMutableArray alloc] init];
    
    NSArray* elements = [element elementsForName:@"objStationData"];
    for (XMLElement* stationData in elements) {
        [result addObject:[self parseStationData:stationData]];
    }
    
    return result;
}

- (StationData *)parseStationData:(XMLElement *)element {
    NSString* serverTime        = [self firstStringValueForKey:@"Servertime"        forElement:element withDefaultValue:@""];
    NSString* trainCode         = [self firstStringValueForKey:@"Traincode"         forElement:element withDefaultValue:@""];
    NSString* stationFullname   = [self firstStringValueForKey:@"Stationfullname"   forElement:element withDefaultValue:@""];
    NSString* stationCode       = [self firstStringValueForKey:@"Stationcode"       forElement:element withDefaultValue:@""];
    NSString* queryTime         = [self firstStringValueForKey:@"Querytime"         forElement:element withDefaultValue:@""];
    NSString* trainDate         = [self firstStringValueForKey:@"Traindate"         forElement:element withDefaultValue:@""];
    NSString* origin            = [self firstStringValueForKey:@"Origin"            forElement:element withDefaultValue:@""];
    NSString* destination       = [self firstStringValueForKey:@"Destination"       forElement:element withDefaultValue:@""];
    NSString* originTime        = [self firstStringValueForKey:@"Origintime"        forElement:element withDefaultValue:@""];
    NSString* destinationTime   = [self firstStringValueForKey:@"Destinationtime"   forElement:element withDefaultValue:@""];
    NSString* status            = [self firstStringValueForKey:@"Status"            forElement:element withDefaultValue:@""];
    NSString* lastLocation      = [self firstStringValueForKey:@"Lastlocation"      forElement:element withDefaultValue:@""];
    NSString* dueIn             = [self firstStringValueForKey:@"Duein"             forElement:element withDefaultValue:@""];
    NSString* late              = [self firstStringValueForKey:@"Late"              forElement:element withDefaultValue:@""];
    NSString* expArrival        = [self firstStringValueForKey:@"Exparrival"        forElement:element withDefaultValue:@""];
    NSString* expDepart         = [self firstStringValueForKey:@"Expdepart"         forElement:element withDefaultValue:@""];
    NSString* schArrival        = [self firstStringValueForKey:@"Scharrival"        forElement:element withDefaultValue:@""];
    NSString* schDepart         = [self firstStringValueForKey:@"Schdepart"         forElement:element withDefaultValue:@""];
    NSString* direction         = [self firstStringValueForKey:@"Direction"         forElement:element withDefaultValue:@""];
    NSString* trainType         = [self firstStringValueForKey:@"Traintype"         forElement:element withDefaultValue:@""];
    NSString* locationTypeString= [self firstStringValueForKey:@"Locationtype"      forElement:element withDefaultValue:@""];
    LocationType locationType   = [self locationTypeFromString:locationTypeString];

    return [[StationData alloc] initWithServerTime:serverTime
                                         trainCode:trainCode
                                   stationFullName:stationFullname
                                       stationCode:stationCode
                                         queryTime:queryTime
                                         trainDate:trainDate
                                            origin:origin
                                       destination:destination
                                        originTime:originTime
                                   destinationTime:destinationTime
                                            status:status
                                      lastLocation:lastLocation
                                             dueIn:dueIn
                                              late:late
                                   expectedArrival:expArrival
                                 expectedDeparture:expDepart
                                  scheduledArrival:schArrival
                                scheduledDeparture:schDepart
                                         direction:direction
                                         trainType:trainType
                                      locationType:locationType];
}

#pragma mark - Station Filters
- (NSArray<StationFilter *> *)parseStationFilters:(XMLElement *)element {
    NSMutableArray<StationFilter*>* result = [[NSMutableArray alloc] init];
    
    NSArray* elements = [element elementsForName:@"objStationFilter"];
    for (XMLElement* stationFilter in elements) {
        [result addObject:[self parseStationFilter:stationFilter]];
    }
    
    return result;
}

- (StationFilter *)parseStationFilter:(XMLElement *)element {
    NSString* stationCode   = [self firstStringValueForKey:@"StationCode"    forElement:element withDefaultValue:@""];
    NSString* stationName   = [self firstStringValueForKey:@"StationDesc"    forElement:element withDefaultValue:@""];
    NSString* stationNameSp = [self firstStringValueForKey:@"StationDesc_sp" forElement:element withDefaultValue:@""];
    
    return [[StationFilter alloc] initWithCode:stationCode name:stationName nameSp:stationNameSp];
}

#pragma mark - Train Movements

- (NSArray<TrainStop *> *)parseTrainMovements:(XMLElement *)element {
    NSMutableArray<TrainStop*>* result = [[NSMutableArray alloc] init];
    
    NSArray* elements = [element elementsForName:@"objTrainMovements"];
    for (XMLElement* trainMovement in elements) {
        [result addObject:[self parseTrainStops:trainMovement]];
    }
    
    return result;
}

- (TrainStop *)parseTrainStops:(XMLElement *)element {
    NSString* trainCode          = [self firstStringValueForKey:@"TrainCode"          forElement:element withDefaultValue:@""];
    NSString* trainDate          = [self firstStringValueForKey:@"TrainDate"          forElement:element withDefaultValue:@""];
    NSString* locationCode       = [self firstStringValueForKey:@"LocationCode"       forElement:element withDefaultValue:@""];
    NSString* locationFullName   = [self firstStringValueForKey:@"LocationFullName"   forElement:element withDefaultValue:@""];
    NSInteger locationOrder      = [self firstIntegerValueForKey:@"LocationOrder"     forElement:element withDefaultValue:0];
    NSString* locationTypeString = [self firstStringValueForKey:@"LocationType"       forElement:element withDefaultValue:@""];
    NSString* trainOrigin        = [self firstStringValueForKey:@"TrainOrigin"        forElement:element withDefaultValue:@""];
    NSString* trainDestination   = [self firstStringValueForKey:@"TrainDestination"   forElement:element withDefaultValue:@""];
    NSString* scheduledArrival   = [self firstStringValueForKey:@"ScheduledArrival"   forElement:element withDefaultValue:@""];
    NSString* scheduledDeparture = [self firstStringValueForKey:@"ScheduledDeparture" forElement:element withDefaultValue:@""];
    NSString* expectedArrival    = [self firstStringValueForKey:@"ExpectedArrival"    forElement:element withDefaultValue:@""];
    NSString* expectedDeparture  = [self firstStringValueForKey:@"ExpectedDeparture"  forElement:element withDefaultValue:@""];
    NSString* arrival            = [self firstStringValueForKey:@"Arrival"            forElement:element withDefaultValue:@""];
    NSString* departure          = [self firstStringValueForKey:@"Departure"          forElement:element withDefaultValue:@""];
    BOOL autoArrival             = [self firstBoolValueForKey:@"AutoArrival"          forElement:element withDefaultValue:NO];
    BOOL autoDepart              = [self firstBoolValueForKey:@"AutoDepart"           forElement:element withDefaultValue:NO];
    NSString* stopTypeString     = [self firstStringValueForKey:@"StopType"           forElement:element withDefaultValue:@""];
    
    LocationType locationType = [self locationTypeFromString:locationTypeString];
    StopType stopType = [self stopTypeFromString:stopTypeString];

    return [[TrainStop alloc] initWithTrainCode:trainCode
                                          trainDate:trainDate
                                       locationCode:locationCode
                                   locationFullName:locationFullName
                                      locationOrder:locationOrder
                                       locationType:locationType
                                        trainOrigin:trainOrigin
                                   trainDestination:trainDestination
                                   scheduledArrival:scheduledArrival
                                 scheduledDeparture:scheduledDeparture
                                            arrival:arrival
                                          departure:departure
                                    expectedArrival:expectedArrival
                                  expectedDeparture:expectedDeparture
                                        autoArrival:autoArrival
                                         autoDepart:autoDepart
                                           stopType:stopType];
}

#pragma mark - Utils

- (NSString *)firstStringValueForKey:(NSString*)key forElement:(XMLElement*)element withDefaultValue:(nullable NSString*)defaultValue {
    NSArray<XMLElement*>* arrayOfValues = [element elementsForName:key];
    if (arrayOfValues.count == 0) return defaultValue;
    
    return [arrayOfValues.firstObject stringValue];
}

- (double)firstDoubleValueForKey:(NSString*)key forElement:(XMLElement*)element withDefaultValue:(double)defaultValue {
    NSArray<XMLElement*>* arrayOfValues = [element elementsForName:key];
    if (arrayOfValues.count == 0) return defaultValue;
    
    return [arrayOfValues.firstObject stringValue].doubleValue;
}

- (NSInteger)firstIntegerValueForKey:(NSString*)key forElement:(XMLElement*)element withDefaultValue:(NSInteger)defaultValue {
    NSArray<XMLElement*>* arrayOfValues = [element elementsForName:key];
    if (arrayOfValues.count == 0) return defaultValue;
    
    return [arrayOfValues.firstObject stringValue].integerValue;
}

- (BOOL)firstBoolValueForKey:(NSString*)key forElement:(XMLElement*)element withDefaultValue:(BOOL)defaultValue {
    NSArray<XMLElement*>* arrayOfValues = [element elementsForName:key];
    if (arrayOfValues.count == 0) return defaultValue;
    
    return [arrayOfValues.firstObject stringValue].boolValue;
}

@end
