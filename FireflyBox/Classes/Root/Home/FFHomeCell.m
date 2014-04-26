//
//  FFHomeCell.m
//  FireflyBox
//
//  Created by pig on 14-4-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHomeCell.h"

@implementation FFHomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        
    }
    return self;
}

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo
{
    _titleLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.dataName];
    _timeLabel.text = [NSString stringWithFormat:@"%ld", tDataInfo.dataId];
}

#pragma mark overried

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _iconImageView.frame = CGRectMake(15, 10, 50, 50);
    _titleLabel.frame = CGRectMake(80, 15, GLOBAL_SCREEN_WIDTH - 80 - 30, 25);
    _timeLabel.frame = CGRectMake(80, 40, GLOBAL_SCREEN_WIDTH - 80 - 30, 25);
    
}

@end
