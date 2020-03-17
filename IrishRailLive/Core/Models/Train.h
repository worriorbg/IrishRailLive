//
//  Train.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Train : NSObject

@property (nonatomic, readonly) NSString* code;
@property (nonatomic, readonly) NSString* date;
@property (nonatomic, readonly) NSString* direction;
@property (nonatomic, readonly) TrainStatus status;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) NSArray<NSString*>* publicMessages;

- (instancetype)initWithCode:(NSString*)code
                        date:(NSString*)date
                   direction:(NSString*)direction
                      status:(TrainStatus)status
                    latitude:(double)latitude
                   longitude:(double)longitude
               publicMessages:(NSArray<NSString*>*)publicMessages;

@end

NS_ASSUME_NONNULL_END
