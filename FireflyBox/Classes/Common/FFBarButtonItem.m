//
//  FFBarButtonItem.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBarButtonItem.h"

@implementation FFBarButtonItem

- (id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    self = [super initWithImage:image style:style target:target action:action];
    if (self) {
        if (IS_IOS7_OR_HIGHER) {
            [self setImageInsets:UIEdgeInsetsMake(0, -BAR_BUTTON_ITEM_OFFSET, 0, BAR_BUTTON_ITEM_OFFSET)];
        }
        else
        {
            [self setImageInsets:UIEdgeInsetsMake(0, BAR_BUTTON_ITEM_OFFSET, 0, -BAR_BUTTON_ITEM_OFFSET)];
        }
    }
    return self;
}

@end
