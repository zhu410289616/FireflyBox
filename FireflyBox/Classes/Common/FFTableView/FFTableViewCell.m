//
//  FFTableViewCell.m
//  FireflyBox
//
//  Created by pig on 14-6-14.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTableViewCell.h"

@implementation FFTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _lineHeight = IS_RETINA_SCREEN ? 0.5f : 1.0f;
        
        _headerLineView = [[UIView alloc] init];
        _headerLineView.backgroundColor = [UIColor colorWithHex:0xc8c8c8];
        _headerLineView.hidden = YES;
        [self addSubview:_headerLineView];
        
        _footerLineView = [[UIView alloc] init];
        _footerLineView.backgroundColor = [UIColor colorWithHex:0xc8c8c8];
        _footerLineView.hidden = YES;
        [self addSubview:_footerLineView];
        
    }
    return self;
}

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath
{
    //todo
}

- (void)configureCellWithItem:(id)item
{
    //todo
    [self configureCellWithItem:item indexPath:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _headerLineView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, _lineHeight);
    _footerLineView.frame = CGRectMake(0, self.frame.size.height - _lineHeight, GLOBAL_SCREEN_WIDTH, _lineHeight);
}

@end
