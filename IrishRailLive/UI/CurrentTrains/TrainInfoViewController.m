//
//  TrainInfoViewController.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "TrainInfoViewController.h"
#import "IRLRequestManager.h"
#import <MapKit/MapKit.h>
#import "TrainStopCell.h"
#import "CacheManager.h"

@interface TrainInfoViewController () <MKMapViewDelegate>

@property (nonatomic, strong) NSArray<TrainStop*>* trainStops;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, assign) NSInteger firstStopOrder;
@property (nonatomic, assign) NSInteger lastStopOrder;
@property (nonatomic, assign) NSInteger currentStopIndex;

@end

@implementation TrainInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _trainCode;
    
    _trainStops = [NSArray array];
    _currentStopIndex = 0;
    
    [self beginRefreshingManually];
    
    // add train current position
    if (_trainLatitude != 0 && _trainLongitude != 0) {
        CLLocationCoordinate2D trainPosition = CLLocationCoordinate2DMake(_trainLatitude, _trainLongitude);
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:trainPosition];
        [annotation setTitle:@"Current Position"]; //You can set the subtitle too
        
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        MKCoordinateRegion region = {trainPosition, span};

        [self.mapView setRegion:region];
        [self.mapView addAnnotation:annotation];
        [self.mapView setCenterCoordinate:trainPosition];
    }
}

- (void)loadData {
    __weak TrainInfoViewController* weakSelf = self;
    [IRLRequestManager.sharedInstance getTrainStopsForTrainId:_trainCode andTrainDate:_trainDate completion:^(NSArray<TrainStop *> * _Nullable trainStops, NSError * _Nullable error) {
        __strong TrainInfoViewController* strongSelf = weakSelf;
        
        if (trainStops == nil) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        strongSelf.trainStops = trainStops;
        [strongSelf configureMap];
    }];
}

- (void)configureMap {
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
    if (_trainStops.count == 0) return;
    
    self.firstStopOrder = _trainStops.count;
    self.lastStopOrder = 1;
    self.currentStopIndex = 0;
    
    TrainStop* firstStop = _trainStops.firstObject;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ → %@", firstStop.trainOrigin, firstStop.trainDestination];
    
    NSInteger idx = 0;
    for (TrainStop* stop in _trainStops) {
        if (stop.locationOrder < self.firstStopOrder) self.firstStopOrder = stop.locationOrder;
        if (stop.locationOrder > self.lastStopOrder) self.lastStopOrder = stop.locationOrder;
        if (stop.stopType == StopTypeCurrent) {
            self.currentStopIndex = idx;
        }
            
        idx++;
    }
    
    NSIndexPath* currentStopIdx = [NSIndexPath indexPathForRow:self.currentStopIndex inSection:0];
    [self.tableView scrollToRowAtIndexPath:currentStopIdx atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
    // add stops path on the map
    idx = 0;
    CLLocationCoordinate2D currentStopPosition = CLLocationCoordinate2DMake(_trainLatitude, _trainLongitude);
    CLLocationCoordinate2D sourceCoord = currentStopPosition;
    CLLocationCoordinate2D destinationCoord = currentStopPosition;
    NSMutableArray<MKPointAnnotation*>* stopPoints = [NSMutableArray array];
    CLLocationCoordinate2D coordinates[_trainStops.count];
    for (TrainStop* trainStop in _trainStops) {
        Station* station = [CacheManager.sharedInstance stationForCode:trainStop.locationCode];
        if (station == nil) continue;
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(station.latitude, station.longitude);
        coordinates[idx] = coordinate;
        
        if (trainStop.stopType == StopTypeCurrent) {
            currentStopPosition = coordinate;
        }
        
        if (trainStop.locationOrder == self.firstStopOrder) {
            sourceCoord = coordinate;
        } else if (trainStop.locationOrder == self.lastStopOrder) {
            destinationCoord = coordinate;
        }
        
        MKPointAnnotation* stopPoint = [[MKPointAnnotation alloc] init];
        stopPoint.coordinate = coordinate;
        stopPoint.title = trainStop.locationFullName;
        [stopPoints addObject:stopPoint];
        
        idx++;
    }
    
    NSUInteger coordsCount = idx;
    [self.mapView addAnnotations:stopPoints];
    
    // calculate directions
    [self calculateDirectionsBetweenCoordinates:coordinates count:coordsCount completion:^(NSArray<MKPolyline *> * _Nullable response, NSError * _Nullable error) {
        if (response == nil) {
            NSLog(@"Error getting directions: %@", error);
            return;
        }
        
        MKMapRect rect = MKMapRectNull;
        for (MKPolyline* polyline in response) {
            [self.mapView addOverlay:polyline level:MKOverlayLevelAboveRoads];
            rect = MKMapRectUnion(rect, polyline.boundingMapRect);
        }
        
        if (!MKMapRectEqualToRect(rect, MKMapRectNull)) {
            [self.mapView setRegion:MKCoordinateRegionForMapRect(rect)];
        }
    }];
}

- (void)calculateDirectionsBetweenCoordinates:(const CLLocationCoordinate2D *)coords count:(NSUInteger)count completion:(nullable void (^)(NSArray<MKPolyline*> * __nullable response, NSError * __nullable error))completionHandler {
    if (count < 2) {
        // not enough points
        // TODO: Add a helpful error here
        completionHandler(nil, [[NSError alloc] init]);
        return;
    }
    
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray<MKPolyline*>* routes = [NSMutableArray array];
    __block NSError* lastError = nil;
    
    for (NSUInteger idx = 0; idx<count-1; idx++) {
    
        CLLocationCoordinate2D sourceCoord = coords[idx];
        CLLocationCoordinate2D destinationCoord = coords[idx+1];
        MKPlacemark* sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceCoord];
        MKPlacemark* destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoord];
        
        MKMapItem* sourceMapItem = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
        MKMapItem* destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
        
        MKDirectionsRequest* directionReq = [[MKDirectionsRequest alloc] init];
        directionReq.source = sourceMapItem;
        directionReq.destination = destinationMapItem;
        directionReq.transportType = MKDirectionsTransportTypeAny;
        
        // Calculate the direction
        MKDirections* directions = [[MKDirections alloc] initWithRequest:directionReq];
        
        dispatch_group_enter(group);
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if (response != nil) {
                [routes addObject:response.routes.firstObject.polyline];
            } else {
                NSLog(@"Error getting directions: %@", error);
                lastError = error;
            }
            
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (routes.count == 0) {
            completionHandler(nil, lastError);
        } else {
            completionHandler(routes, lastError);
        }
    });
}

- (void)refreshTableData:(id)sender {
    [self loadData];
}

#pragma - TableView DataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trainStops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.trainStops.count) return [[UITableViewCell alloc] init];
    
    TrainStopCell* cell = [tableView dequeueReusableCellWithIdentifier:TrainStopCell.className forIndexPath:indexPath];
    
    TrainStop* trainStop = [self.trainStops objectAtIndex:indexPath.row];
    
    cell.isFirstStop = trainStop.locationOrder == self.firstStopOrder;
    cell.isLastStop = trainStop.locationOrder == self.lastStopOrder;
    [cell configureWithTrainStop:trainStop];
    
    return cell;
}

#pragma mark MKMapView Delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *polylineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline*)overlay];
        polylineRenderer.fillColor = [[UIColor systemRedColor] colorWithAlphaComponent:0.7];
        polylineRenderer.strokeColor = [[UIColor systemRedColor] colorWithAlphaComponent:0.7];
        polylineRenderer.lineWidth = 2.0;
        
        return polylineRenderer;
    }
    
    return  nil;
}

@end
