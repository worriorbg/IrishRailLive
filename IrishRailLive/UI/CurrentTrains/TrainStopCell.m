//
//  TrainStopCell.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "TrainStopCell.h"

@interface TrainStopCell ()

@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrivalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *stopTypeView;
@property (weak, nonatomic) IBOutlet UIView *stopTypeTrackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stopTypeTrackTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stopTypeTrackBottomConstraint;

@end

@implementation TrainStopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.stopTypeView.layer.borderWidth = 2.0;
    self.stopTypeView.layer.borderColor = UIColor.systemBlueColor.CGColor;
    self.stopTypeView.layer.cornerRadius = self.stopTypeView.bounds.size.width / 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithTrainStop:(TrainStop*)trainStop {
    self.locationNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", trainStop.locationFullName, trainStop.locationCode];
    BOOL isStopCurrent = trainStop.stopType == StopTypeCurrent;
    
    if (isStopCurrent) {
        self.arrivalTimeLabel.text = [NSString stringWithFormat:@"Arrival: %@", trainStop.scheduledArrival];
        self.departureTimeLabel.text = [NSString stringWithFormat:@"Depart: %@", trainStop.scheduledDeparture];
        self.stopTypeView.backgroundColor = UIColor.systemBlueColor;
        self.locationNameLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    } else {
        self.locationNameLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
        self.arrivalTimeLabel.text = nil;
        self.departureTimeLabel.text = nil;
        self.stopTypeView.backgroundColor = UIColor.whiteColor;
    }
    
    if (self.isFirstStop) {
        self.stopTypeTrackTopConstraint.constant = _stopTypeView.center.y;
        self.stopTypeTrackBottomConstraint.constant = 0;
    } else if (self.isLastStop) {
        self.stopTypeTrackTopConstraint.constant = 0;
        self.stopTypeTrackBottomConstraint.constant = _stopTypeView.center.y;
    } else {
        self.stopTypeTrackTopConstraint.constant = 0;
        self.stopTypeTrackBottomConstraint.constant = 0;
    }
}

@end
