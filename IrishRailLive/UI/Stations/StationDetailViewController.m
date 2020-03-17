//
//  StationDetailViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StationDetailViewController.h"
#import "IRLRequestManager.h"
#import "CacheManager.h"
#import "StationTrainCell.h"
#import "TrainInfoViewController.h"

@interface StationDetailViewController ()

@property (nonnull, nonatomic, strong) NSArray<StationData*>* trains;

@end

@implementation StationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ (%@)", self.station.name, self.station.code];
    
    _trains = [[NSArray alloc] init];
    
    [self beginRefreshingManually];
}

- (void)loadData {
    __weak StationDetailViewController* weakSelf = self;
    Station* station = [CacheManager.sharedInstance stationForCode:self.station.code];
    if (station != nil) {
    }
    [IRLRequestManager.sharedInstance getStationDataByCode:self.station.code completion:^(NSArray<StationData *> * _Nullable stations, NSError * _Nullable error) {
        if (stations == nil) {
            NSLog(@"Error: %@", error);
            return;
        }

        __strong StationDetailViewController* strongSelf = weakSelf;
        strongSelf.trains = stations;
        [strongSelf.tableView reloadData];
        [strongSelf.refreshControl endRefreshing];
    }];
}

#pragma - TableView DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trains.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.trains.count) return [[UITableViewCell alloc] init];
    
    StationTrainCell* cell = [tableView dequeueReusableCellWithIdentifier:StationTrainCell.className forIndexPath:indexPath];
    
    StationData* train = [self.trains objectAtIndex:indexPath.row];
    
    [cell configureWithStationData:train];
    
    return cell;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _trains.count) return;
    
    StationData* train = [self.trains objectAtIndex:indexPath.row];
    NSLog(@"Did Select: %@", train);
    
    TrainInfoViewController* trainInfoVC = [UIStoryboard.mainStoryboard instantiateViewControllerWithIdentifier:TrainInfoViewController.className];
    trainInfoVC.trainCode = train.trainCode;
    trainInfoVC.trainDate = train.trainDate;
    trainInfoVC.trainLatitude = 0;
    trainInfoVC.trainLongitude = 0;
    
    [self.navigationController pushViewController:trainInfoVC animated:YES];
}

@end
