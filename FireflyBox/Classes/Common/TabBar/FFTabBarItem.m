//
//  FFTabBarItem.m
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTabBarItem.h"

@implementation FFTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    _itemImageView = [[UIImageView alloc] init];
    _itemImageView.frame = CGRectMake(_itemImageEdge.left, _itemImageEdge.top, self.frame.size.width - _itemImageEdge.left - _itemImageEdge.right, self.frame.size.height - _itemImageEdge.top - _itemImageEdge.bottom);
    _itemImageView.backgroundColor = [UIColor clearColor];
    _itemImageView.image = _norItemImage;
    [self addSubview:_itemImageView];
    
    _itemTitleLabel = [[UILabel alloc] init];
    _itemTitleLabel.frame = CGRectMake(_itemTitleEdge.left, _itemTitleEdge.top, self.frame.size.width - _itemTitleEdge.left - _itemTitleEdge.right, self.frame.size.height - _itemTitleEdge.top - _itemTitleEdge.bottom);
    _itemTitleLabel.backgroundColor = [UIColor clearColor];
    _itemTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_itemTitleLabel];
}

- (void)updateViewWithIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        _itemImageView.image = _selItemImage;
        _itemTitleLabel.textColor = [UIColor colorWithHex:0x454545];
    } else {
        _itemImageView.image = _norItemImage;
        _itemTitleLabel.textColor = [UIColor colorWithHex:0x808080];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
