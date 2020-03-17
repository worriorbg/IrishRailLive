//
//  StationCellTableViewCell.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "StationCell.h"

@interface StationCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationCodeLabel;

@end

@implementation StationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithStation:(StationFilter *)station {
    NSMutableString* title = [NSMutableString stringWithString:station.name];
    self.titleLabel.text = title;
    self.stationCodeLabel.text = station.code;
}

@end
