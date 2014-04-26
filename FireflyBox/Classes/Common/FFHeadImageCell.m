//
//  FFHeadImageCell.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHeadImageCell.h"

@implementation FFHeadImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontOfApp:16.0f];
        [self addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont fontOfApp:12.0f];
        [self addSubview:_timeLabel];
        
    }
    return self;
}

@end
