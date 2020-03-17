//
//  BaseTableViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/17/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView reloadData];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshTableData:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = _refreshControl;
    
    [self beginRefreshingManually];
}

- (void)loadData {
    // Implement
}

- (void)refreshTableData:(id)sender {
    [self loadData];
}

- (void)beginRefreshingManually {
    [self.refreshControl beginRefreshing];
    // This line makes the spinner visible by pushing the table view/collection view down
    [self.tableView setContentOffset:CGPointMake(0, -1.0f * self.refreshControl.frame.size.height) animated:YES];
    // This line is what actually triggers the refresh action/selector
    [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
