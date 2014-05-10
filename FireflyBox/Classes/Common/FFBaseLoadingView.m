//
//  FFBaseLoadingView.m
//  FireflyBox
//
//  Created by pig on 14-5-11.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseLoadingView.h"

@implementation FFBaseLoadingView

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame tip:@"Loading..."];
}

- (id)initWithFrame:(CGRect)frame tip:(NSString *)tTip
{
    if (self = [super initWithFrame:frame]) {
        
        NSString *tip = (tTip == nil) ? @"Loading" : tTip;
        
        UIFont *tipfont = [UIFont boldSystemFontOfSize:14.0f];
        CGSize tipsize = [tip sizeWithFont:tipfont constrainedToSize:CGSizeMake(GLOBAL_SCREEN_WIDTH - 30 - 20 - 10, CGRectGetHeight(frame))];
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake((GLOBAL_SCREEN_WIDTH - 30 - 20 - 10 - tipsize.width) / 2 - 20, (CGRectGetHeight(frame) - 20) / 2, 20, 20);
        [self addSubview:_indicatorView];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.frame = CGRectMake((GLOBAL_SCREEN_WIDTH - 30 - 20 - 10 - tipsize.width) / 2, (CGRectGetHeight(frame) - tipsize.height) / 2, tipsize.width, tipsize.height);
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.textColor = [UIColor colorWithHex:0x808080];
        _tipLabel.font = tipfont;
        _tipLabel.text = tip;
        [self addSubview:_tipLabel];
    }
    return self;
}

- (void)updateView
{}

@end
