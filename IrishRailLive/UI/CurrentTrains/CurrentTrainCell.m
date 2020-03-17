//
//  CurrentTrainCell.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/15/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "CurrentTrainCell.h"

@interface CurrentTrainCell ()

@property (weak, nonatomic) IBOutlet UIView *trainStatus;

@property (weak, nonatomic) IBOutlet UILabel *trainCode;
@property (weak, nonatomic) IBOutlet UILabel *trainDirection;
@property (weak, nonatomic) IBOutlet UILabel *publicMessages;

@end

@implementation CurrentTrainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithTrain:(Train *)train {
    _trainCode.text = train.code;
    _trainStatus.backgroundColor = [self colorForTrainStatus:train.status];
    _trainDirection.text = train.direction;
    _publicMessages.text = [train.publicMessages componentsJoinedByString:@"\n"];
}

- (UIColor*)colorForTrainStatus:(TrainStatus)trainStatus {
    if (trainStatus == TrainStatusRunning) return GetTrainStatusRunningColor();
    if (trainStatus == TrainStatusNotRunning) return GetTrainStatusNotRunningColor();
    if (trainStatus == TrainStatusTerminated) return GetTrainStatusTerminatedColor();

    return [UIColor clearColor];
}

@end
