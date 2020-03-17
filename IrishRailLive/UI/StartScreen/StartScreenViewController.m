//
//  StartScreenViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StartScreenViewController.h"
#import "IRLRequestManager.h"
#import "FavouriteCell.h"
#import "TrainInfoViewController.h"

static const NSTimeInterval kRefreshInterval = 10.0;

@interface StartScreenViewController ()

@property (weak, nonatomic) IBOutlet UITextField *originTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (nonatomic, weak) IBOutlet UIButton* goButton;

@property (nonnull, nonatomic, strong) NSArray<Favourite*>* favourites;
@property (nonnull, nonatomic, strong) NSTimer* refreshTimer;


@end

@implementation StartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _favourites = [NSArray arrayWithObject: [[Favourite alloc] initWithOrigin:@"Arklow" originCode:@"ARKLW" destination:@"Shankill" andDestinationCode:@"SKILL"]];
    [self.tableView reloadData];
    
    _goButton.layer.cornerRadius = 5.0;
    [self.navigationController setNavigationBarHidden:YES];
    
    __weak __typeof(self) weakSelf = self;
    self.refreshTimer = [[NSTimer alloc] initWithFireDate:[[NSDate alloc] init] interval:kRefreshInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf loadData];
    }];
    
    [NSRunLoop.currentRunLoop addTimer:_refreshTimer forMode:NSDefaultRunLoopMode];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)loadData {
    __weak StartScreenViewController* weakSelf = self;
    for (Favourite* fav in _favourites) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[_favourites indexOfObject:fav] inSection:0];
        [self getStationDataForOriginCode:fav.originCode andDestination:fav.destination completion:^(StationData * _Nullable station, NSError * _Nullable error) {
            __strong StartScreenViewController* strongSelf = weakSelf;
            
            if (station != nil) {
                [fav setStationData:station];
                [strongSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
            [strongSelf.refreshControl endRefreshing];
        }];
    }
}

- (void)getStationDataForOriginCode:(NSString*)originCode andDestination:(NSString*)destination completion:(nullable void (^)(StationData* _Nullable station,  NSError* _Nullable error))completionHandler {
    [IRLRequestManager.sharedInstance getStationDataByCode:originCode completion:^(NSArray<StationData *> * _Nullable stations, NSError * _Nullable error) {
        StationData* searchedStation = nil;
        for (StationData* stationData in stations) {
            if ([stationData.destination isEqualToString:destination]) {
                searchedStation = stationData;
                break;
            }
        }
        completionHandler(searchedStation, error);
    }];
}

#pragma - TableView DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favourites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.favourites.count) return [[UITableViewCell alloc] init];
    
    FavouriteCell* cell = [tableView dequeueReusableCellWithIdentifier:FavouriteCell.className forIndexPath:indexPath];
    
    Favourite* favourite = [self.favourites objectAtIndex:indexPath.row];
    
    [cell configureWithFavourite:favourite];
    
    return cell;
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _favourites.count) return;
    
    Favourite* favourite = [self.favourites objectAtIndex:indexPath.row];
    
    // Nothing to show if no data is loaded
    if (favourite.stationData == nil) return;
    
    TrainInfoViewController* trainInfoVC = [UIStoryboard.mainStoryboard instantiateViewControllerWithIdentifier:TrainInfoViewController.className];
    trainInfoVC.trainCode = favourite.stationData.trainCode;
    trainInfoVC.trainDate = favourite.stationData.trainDate;
    trainInfoVC.trainLatitude = 0;
    trainInfoVC.trainLongitude = 0;
    
    [self.navigationController pushViewController:trainInfoVC animated:YES];
}

@end
