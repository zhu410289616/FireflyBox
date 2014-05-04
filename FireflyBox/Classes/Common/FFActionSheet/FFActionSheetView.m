//
//  FFActionSheetView.m
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFActionSheetView.h"
#import "FFBaseActionView.h"

#define CANCEL_BUTTON_HEIGHT 57

@implementation FFActionSheetView

- (id)init
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithHex:0xffffff alpha:0.9f];
        
        _rootView = [[UIView alloc] init];
        _rootView.frame = [UIScreen mainScreen].bounds;
        
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
        [_rootView addGestureRecognizer:singleRecognizer];
        
    }
    return self;
}

- (id)initWithView:(UIView *)actionView
{
    if (self = [self init]) {
        self.frame = CGRectMake(0, 0, actionView.bounds.size.width, actionView.bounds.size.height + CANCEL_BUTTON_HEIGHT);
        [self addSubview:actionView];
        [self addCancelButton:actionView.bounds.size.height];
    }
    return self;
}

- (id)initWithTitles:(NSArray *)titles
{
    if (self = [self init]) {
        
        self.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, 0);
        [self addCancelButton:0];
        
        if (titles && [titles count] > 0) {
            float marginLeft = 0.0f;
            float marginTop = 18.0f;
            
            //10 + 60 + 10, 10 + 60 + 10
            float itemWidth = 80.0f;
            float itemHeight = 80.0f;
            int numInRow = GLOBAL_SCREEN_WIDTH / itemWidth;
            
            CGRect frame = CGRectMake(marginLeft, marginTop, itemWidth, itemHeight);
            for (int i = 0; i < [titles count]; i++) {
                
                if ((i % numInRow) == 0) {
                    frame.origin.x = marginLeft;
                    if (i > 0) {
                        frame.origin.y = frame.origin.y + frame.size.height;
                    }
                } else {
                    frame.origin.x = frame.origin.x + frame.size.width;
                }
                NSString *title = [titles objectAtIndex:i];
                
                FFBaseActionView *itemView = [[FFBaseActionView alloc] initWidth80WithTitle:title];
                itemView.frame = frame;
                itemView.actionButton.tag = i;
                [itemView.actionButton styleWithCornerRadius:itemWidth / 2];
                [itemView.actionButton styleWithTitle:title titleColor:[UIColor whiteColor]];
                [itemView.actionButton styleWithBackgroundColor:[UIColor orangeColor]];
                [itemView.actionButton addTarget:self action:@selector(doItemAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:itemView];
                
//                NSLog(@"itemView.frame.origin.x: %f, itemView.frame.origin.y: %f", itemView.frame.origin.x, itemView.frame.origin.y);
            }
            CGRect cancelButtonFrame = _cancelButton.frame;
            cancelButtonFrame.origin.y = frame.origin.y + frame.size.height;
            _cancelButton.frame = cancelButtonFrame;
        } else {
            _cancelButton.frame = CGRectMake(0.0f, 0.0f, GLOBAL_SCREEN_WIDTH, CANCEL_BUTTON_HEIGHT);
        }
        
        self.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, _cancelButton.frame.origin.y + _cancelButton.frame.size.height);
        
    }
    return self;
}

- (void)showInView:(UIView *)parentView
{
    [parentView.window addSubview:_rootView];
    [parentView.window addSubview:self];
    
    _rootView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.0f];
    self.frame = CGRectMake(0, parentView.window.bounds.size.height, parentView.bounds.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0.0f, self.frame.origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        _rootView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.4f];
    }];
}

#pragma mark priate function

- (void)addCancelButton:(float)posy
{
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, posy, GLOBAL_SCREEN_WIDTH, CANCEL_BUTTON_HEIGHT);
    _cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _cancelButton.titleLabel.font = [UIFont fontWithBoldOfApp:19.0f];
    [_cancelButton styleWithTitle:@"Cancel" titleColor:[UIColor colorWithHex:0x157dfb]];
    [_cancelButton styleWithBackgroundColor:[UIColor colorWithHex:0xf8f8f8]];
    [_cancelButton highlightedStyleWithBackgroundColor:[UIColor colorWithHex:0xd9d9d9]];
    [_cancelButton addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
}

- (void)dissmiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0.0f, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
        _rootView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0];
    } completion:^(BOOL finished) {
        [self sheetDidDismissed];
    }];
}

- (void)sheetDidDismissed
{
    [_rootView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)doItemAction:(id)sender
{
    UIButton *clickedButton = sender;
    int actionIndex = clickedButton.tag;
    
    if (_actionBlock) {
        _actionBlock(actionIndex);
    }
    
    [self dissmiss];
}

@end
