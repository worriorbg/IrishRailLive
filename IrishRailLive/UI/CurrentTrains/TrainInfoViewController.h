//
//  TrainInfoViewController.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseChildTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainInfoViewController : BaseChildTableViewController

@property (nonatomic, strong) NSString* trainCode;
@property (nonatomic, strong) NSString* trainDate;
@property (nonatomic, assign) double trainLatitude;
@property (nonatomic, assign) double trainLongitude;

@end

NS_ASSUME_NONNULL_END
