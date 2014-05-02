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
        
        self.iconImageView.hidden = YES;
        _typeIconView = [[FFFileTypeIconView alloc] init];
        [self addSubview:_typeIconView];
        
    }
    return self;
}

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo
{
    _typeIconView.frame = CGRectMake(15, 15, 40, 40);
    NSString *title = [tDataInfo.dataName pathExtension];
    [_typeIconView updateViewWithTitle:title showColor:tDataInfo.showColor];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.dataName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.creationDate];
}

#pragma mark overried

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(70, 15, GLOBAL_SCREEN_WIDTH - 70 - 30, 25);
    self.timeLabel.frame = CGRectMake(70, 40, GLOBAL_SCREEN_WIDTH - 70 - 30, 20);
    
}

@end
