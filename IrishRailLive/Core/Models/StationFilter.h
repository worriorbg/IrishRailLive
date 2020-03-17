//
//  StationFilter.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationFilter : NSObject

@property (nonatomic, readonly) NSString* code;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* nameSp;

- (instancetype)initWithCode:(NSString*)code
                        name:(NSString*)name
                      nameSp:(NSString*)nameSp;

@end

NS_ASSUME_NONNULL_END
