//
//  FFFileInfoCell.m
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileInfoCell.h"
#import "FFCommonUtil.h"

@implementation FFFileInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.iconImageView.hidden = YES;
        self.titleLabel.frame = CGRectMake(70, 15, GLOBAL_SCREEN_WIDTH - 70 - 30, 25);
        self.timeLabel.frame = CGRectMake(70, 40, 140, 20);
        
        _typeIconView = [[FFFileTypeIconView alloc] init];
        _typeIconView.frame = CGRectMake(15, 15, 40, 40);
        [self addSubview:_typeIconView];
        
        _fileSizeLabel = [[UILabel alloc] init];
        _fileSizeLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 15, 40, GLOBAL_SCREEN_WIDTH - CGRectGetMaxX(self.timeLabel.frame) - 15 - 15, 20);
        _fileSizeLabel.backgroundColor = [UIColor clearColor];
        _fileSizeLabel.textAlignment = NSTextAlignmentRight;
        _fileSizeLabel.textColor = [UIColor lightGrayColor];
        _fileSizeLabel.font = [UIFont fontOfApp:12.0f];
        [self addSubview:_fileSizeLabel];
    }
    return self;
}

- (void)updateViewWithContent:(FFDataInfo *)tDataInfo
{
    NSString *title = [tDataInfo.dataName pathExtension];
    if (tDataInfo.fileType == FFFileTypeDirectory) {
        title = @"Dir";
        self.fileSizeLabel.hidden = YES;
    } else {
        if (title.length < 1) {
            title = @"?";
        }
        self.fileSizeLabel.hidden = NO;
    }
    
    [_typeIconView updateViewWithTitle:title showColor:tDataInfo.showColor];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.dataName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", tDataInfo.creationDate];
    self.fileSizeLabel.text = [NSString stringWithFormat:@"%@", [FFCommonUtil formatSpace:tDataInfo.fileSize]];
}

@end
