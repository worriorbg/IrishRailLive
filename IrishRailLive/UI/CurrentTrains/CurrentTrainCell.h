//
//  CurrentTrainCell.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/15/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentTrainCell : UITableViewCell

- (void)configureWithTrain:(Train *)train;

@end

NS_ASSUME_NONNULL_END
