//
//  FavouriteCell.m
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import "FavouriteCell.h"

@interface FavouriteCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *trainDestination;
@property (weak, nonatomic) IBOutlet UILabel *trainCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation FavouriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithFavourite:(Favourite*)favourite {
    self.trainDestination.text = [NSString stringWithFormat:@"%@ → %@", favourite.origin, favourite.destination];
    if (favourite.stationData != nil) {
        self.stackView.spacing = 16;
        self.trainCodeLabel.text = favourite.stationData.trainCode;
        self.scheduleLabel.text = [NSString stringWithFormat:@"Leaves in %@ min", favourite.stationData.dueIn];
    } else {
        self.stackView.spacing = 0;
        self.trainCodeLabel.text = nil;
        self.scheduleLabel.text = @"No trains in the next 90 min";
    }
}

@end
