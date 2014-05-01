//
//  FFFileInfoCell.m
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileInfoCell.h"

@implementation FFFileInfoCell

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
    self.iconImageView.image = [UIImage imageNamed:@"file_icon_normal.png"];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.dataName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.creationDate];
}

#pragma mark overried

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(15, 15, 40, 40);
    self.titleLabel.frame = CGRectMake(70, 15, GLOBAL_SCREEN_WIDTH - 70 - 30, 25);
    self.timeLabel.frame = CGRectMake(70, 40, GLOBAL_SCREEN_WIDTH - 70 - 30, 20);
    
}

@end
