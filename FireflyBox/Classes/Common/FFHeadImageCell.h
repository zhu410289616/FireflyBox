//
//  FFHeadImageCell.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseTableCell.h"
#import "TTTAttributedLabel.h"

@interface FFHeadImageCell : FFBaseTableCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end
