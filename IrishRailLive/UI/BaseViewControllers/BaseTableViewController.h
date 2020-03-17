//
//  BaseTableViewController.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

- (void)loadData;
- (void)refreshTableData:(id)sender;
- (void)beginRefreshingManually;

@end

NS_ASSUME_NONNULL_END
