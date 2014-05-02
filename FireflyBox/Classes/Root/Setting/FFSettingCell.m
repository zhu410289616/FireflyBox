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
        
        self.titleLabel.frame = CGRectMake(15, 0, GLOBAL_SCREEN_WIDTH - 30, 44);
    }
    return self;
}

- (void)updateViewWithContent:(NSString *)menuName
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", menuName];
}

@end
