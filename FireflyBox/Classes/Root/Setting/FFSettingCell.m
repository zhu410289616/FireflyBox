//
//  FFSettingCell.m
//  FireflyBox
//
//  Created by pig on 14-4-27.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSettingCell.h"

@implementation FFSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.footerLineView.hidden = NO;
        self.titleLabel.frame = CGRectMake(15, 0, GLOBAL_SCREEN_WIDTH - 30, 44);
    }
    return self;
}

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath
{
    self.headerLineView.hidden = YES;
    if (indexPath.row == 0 && self.headerLineView.hidden) {
        self.headerLineView.hidden = NO;
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", item];
}

@end
