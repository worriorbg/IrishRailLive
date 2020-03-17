//
//  Train.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/13/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "Train.h"

@implementation Train

- (instancetype)initWithCode:(NSString*)code
                        date:(NSString*)date
                   direction:(NSString*)direction
                      status:(TrainStatus)status
                    latitude:(double)latitude
                   longitude:(double)longitude
              publicMessages:(NSArray<NSString*>*)publicMessages
{
    self = [super init];
    if (self) {
        _code = code;
        _date = date;
        _direction = direction;
        _status = status;
        _latitude = latitude;
        _longitude = longitude;
        _publicMessages = publicMessages;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@> code: %@, date: %@, direction: %@, status: %tu, lat: %f, long: %f, publicMessages: %@", self.className, _code, _date, _direction, _status, _latitude, _longitude, _publicMessages];
}

@end
