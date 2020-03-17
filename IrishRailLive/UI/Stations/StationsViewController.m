//
//  SecondViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StationsViewController.h"
#import "IRLRequestManager.h"
#import "StationCell.h"
#import "StationDetailViewController.h"

@interface StationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray<StationFilter*>* stations;

@end

@implementation StationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    _stations = [[NSArray alloc] init];
    
    self.navigationItem.title = @"All Stations";
    
    [self beginRefreshingManually];
}

- (void)loadData {
    __weak StationsViewController* weakSelf = self;
    [IRLRequestManager.sharedInstance getAllStationNamesWithCompletion:^(NSArray<StationFilter *> * _Nullable stationNames, NSError * _Nullable error) {
        __strong StationsViewController* strongSelf = weakSelf;
        
        if (stationNames == nil) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        strongSelf.stations = stationNames;
        [strongSelf.tableView reloadData];
        [strongSelf.refreshControl endRefreshing];
    }];
}

#pragma mark - TableView DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _stations.count) return [[UITableViewCell alloc] init];
    
    StationCell* cell = [tableView dequeueReusableCellWithIdentifier:StationCell.className forIndexPath:indexPath];
    
    StationFilter* station = [self.stations objectAtIndex:indexPath.row];
    
    [cell configureWithStation:station];
    
    return cell;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _stations.count) return;
    
    StationFilter* station = [self.stations objectAtIndex:indexPath.row];
    NSLog(@"Did Select: %@", station);
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    StationDetailViewController* stationDetailsVC = [storyboard instantiateViewControllerWithIdentifier:StationDetailViewController.className];
    stationDetailsVC.station = station;
    
    [self.navigationController pushViewController:stationDetailsVC animated:YES];
}

@end
