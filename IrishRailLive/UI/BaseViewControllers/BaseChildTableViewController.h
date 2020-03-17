//
//  BaseChildTableViewController.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseChildTableViewController : BaseTableViewController

@property (nonatomic, weak) IBOutlet NSLayoutConstraint* tableViewBottomConstraint;

@end

NS_ASSUME_NONNULL_END
