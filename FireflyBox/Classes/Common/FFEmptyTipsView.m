//
//  FFEmptyTipsView.m
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFEmptyTipsView.h"

@implementation FFEmptyTipsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame emptyTips:(NSString *)tEmptyTips
{
    return [self initWithFrame:frame emptyTips:tEmptyTips rangeColor:nil range:NSMakeRange(NSNotFound, 0)];
}

- (id)initWithFrame:(CGRect)frame emptyTips:(NSString *)tEmptyTips rangeColor:(UIColor *)tRangeColor range:(NSRange)tRange
{
    self = [super initWithFrame:frame];
    if (self) {
        _emptyTipsLabel = [[TTTAttributedLabel alloc] init];
        _emptyTipsLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _emptyTipsLabel.backgroundColor = [UIColor clearColor];
        _emptyTipsLabel.textAlignment = NSTextAlignmentCenter;
        _emptyTipsLabel.textColor = [UIColor grayColor];
        _emptyTipsLabel.font = [UIFont fontOfApp:14.0f];
        _emptyTipsLabel.text = tEmptyTips;
        if (tRangeColor && tRange.location != NSNotFound) {
            [_emptyTipsLabel setText:tEmptyTips afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(__bridge id)[tRangeColor CGColor] range:tRange];
                return mutableAttributedString;
            }];
        }
        [self addSubview:_emptyTipsLabel];
        
        _emptyTipsActionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emptyTipsActionButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_emptyTipsActionButton];
    }
    return self;
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
