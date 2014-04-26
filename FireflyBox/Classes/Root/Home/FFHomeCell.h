//
//  FFHomeCell.h
//  FireflyBox
//
//  Created by pig on 14-4-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTableCell.h"
#import "FFDataInfo.h"

@interface FFHomeCell : FFBaseTableCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo;

@end
