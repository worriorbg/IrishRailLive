
//
//  StationTrainCell.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StationTrainCell.h"

@interface StationTrainCell ()

@property (weak, nonatomic) IBOutlet UIView *trainStatusView;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *originTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainCodeAndDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dueInLabel;
@property (weak, nonatomic) IBOutlet UIView *originPointView;
@property (weak, nonatomic) IBOutlet UIView *destinationPointView;

@end

@implementation StationTrainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _originPointView.layer.cornerRadius = CGRectGetMidX(_originPointView.bounds);
    _destinationPointView.layer.cornerRadius = CGRectGetMidX(_destinationPointView.bounds);
}

- (void)configureWithStationData:(StationData*)stationData {
    self.originLabel.text = stationData.origin;
    self.originTimeLabel.text = stationData.originTime;
    self.destinationLabel.text = stationData.destination;
    self.destinationTimeLabel.text = stationData.destinationTime;
    self.trainCodeAndDirectionLabel.text = stationData.trainCode;
//    self.lastLocationLabel.text = [NSString stringWithFormat:@"%@\n%@", stationData.status, stationData.lastLocation];
    self.lastLocationLabel.text = stationData.lastLocation;

    self.dueInLabel.text = [NSString stringWithFormat:@"in %@ min", stationData.dueIn];
}

@end
