//
//  FFBaseActionView.m
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseActionView.h"

@implementation FFBaseActionView

- (id)initWidth80WithTitle:(NSString *)title
{
    //10 + 60 + 10, 10 + 60 + 10
    self = [super initWithFrame:CGRectMake(0, 0, 80, 80)];
    if (self) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.frame = CGRectMake(10, 0, 60, 60);
        [self addSubview:_actionButton];
    }
    return self;
}

@end
