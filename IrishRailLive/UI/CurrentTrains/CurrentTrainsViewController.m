//
//  CurrentTrainsViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/12/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "CurrentTrainsViewController.h"
#import "IRLRequestManager.h"
#import "CurrentTrainCell.h"
#import "TrainInfoViewController.h"

@interface CurrentTrainsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonnull, nonatomic, strong) NSArray<Train*>* trains;

@end

@implementation CurrentTrainsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _trains = [[NSArray alloc] init];
    
    self.navigationItem.title = @"Current Trains";
    
    [self beginRefreshingManually];
}

- (void)loadData {
    __weak CurrentTrainsViewController* weakSelf = self;
    [IRLRequestManager.sharedInstance getCurrentTrainsWithCompletion:^(NSArray<Train *> * _Nullable trains, NSError * _Nullable error) {
        __strong CurrentTrainsViewController* strongSelf = weakSelf;
        
        if (trains == nil) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        strongSelf.trains = trains;
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
    
    CurrentTrainCell* cell = [tableView dequeueReusableCellWithIdentifier:CurrentTrainCell.className forIndexPath:indexPath];
    
    Train* train = [self.trains objectAtIndex:indexPath.row];
    
    [cell configureWithTrain:train];
    
    return cell;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _trains.count) return;
    
    Train* train = [self.trains objectAtIndex:indexPath.row];
    NSLog(@"Did Select: %@", train);
    
    TrainInfoViewController* trainInfoVC = [UIStoryboard.mainStoryboard instantiateViewControllerWithIdentifier:TrainInfoViewController.className];
    trainInfoVC.trainCode = train.code;
    trainInfoVC.trainDate = train.date;
    trainInfoVC.trainLatitude = train.latitude;
    trainInfoVC.trainLongitude = train.longitude;

    [self.navigationController pushViewController:trainInfoVC animated:YES];
}

@end
