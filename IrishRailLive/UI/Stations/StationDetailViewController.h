//
//  StationDetailViewController.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"
#import "BaseChildTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StationDetailViewController : BaseChildTableViewController

@property (nonatomic, strong) StationFilter* station;

@end

NS_ASSUME_NONNULL_END
