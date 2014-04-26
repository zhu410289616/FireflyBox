//
//  FFRecentCell.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFRecentCell.h"

@implementation FFRecentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.dataName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.creationDate];
}

#pragma mark overried

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(15, 10, 50, 50);
    self.titleLabel.frame = CGRectMake(80, 15, GLOBAL_SCREEN_WIDTH - 80 - 30, 25);
    self.timeLabel.frame = CGRectMake(80, 40, GLOBAL_SCREEN_WIDTH - 80 - 30, 25);
    
}

@end
