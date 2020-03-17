//
//  XMLParser.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models/Models.h"
#import <GDataXML_HTML/GDataXMLNode.h>

NS_ASSUME_NONNULL_BEGIN

typedef GDataXMLElement XMLElement;

@interface XMLParser: NSObject

- (NSArray<Station *> *)parseStations:(XMLElement *)element;
- (Station *)parseStation:(XMLElement *)element;

- (NSArray<Train *> *)parseTrains:(XMLElement *)element;
- (Train *)parseTrain:(XMLElement *)element;

- (NSArray<StationData *> *)parseStationDatas:(XMLElement *)element;

- (NSArray<StationFilter *> *)parseStationFilters:(XMLElement *)element;
- (StationFilter *)parseStationFilter:(XMLElement *)element;

- (NSArray<TrainStop *> *)parseTrainMovements:(XMLElement *)element;

@end

NS_ASSUME_NONNULL_END
