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
        
        self.iconImageView.hidden = YES;
        self.titleLabel.frame = CGRectMake(70, 15, GLOBAL_SCREEN_WIDTH - 70 - 30, 25);
        self.timeLabel.frame = CGRectMake(70, 40, GLOBAL_SCREEN_WIDTH - 70 - 30, 20);
        
        _typeIconView = [[FFFileTypeIconView alloc] init];
        _typeIconView.frame = CGRectMake(15, 15, 40, 40);
        [self addSubview:_typeIconView];
        
    }
    return self;
}

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo
{
    NSString *title = [tDataInfo.dataName pathExtension];
    if (tDataInfo.fileType == FFFileTypeDirectory) {
        title = @"Dir";
    } else if (title.length < 1) {
        title = @"?";
    }
    
    [_typeIconView updateViewWithTitle:title showColor:tDataInfo.showColor];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.dataName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.creationDate];
}

@end
