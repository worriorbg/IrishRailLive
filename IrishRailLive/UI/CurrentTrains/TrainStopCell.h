//
//  TrainStopCell.h
//  IrishRailLive
//
//  Created by Borislav Georgiev on 3/16/2020.
//  Copyright © 2020 BGeorgiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainStopCell : UITableViewCell

@property (nonatomic, assign) BOOL isFirstStop;
@property (nonatomic, assign) BOOL isLastStop;

- (void)configureWithTrainStop:(TrainStop*)trainStop;

@end

NS_ASSUME_NONNULL_END
