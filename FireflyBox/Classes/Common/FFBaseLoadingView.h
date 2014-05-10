//
//  FFBaseLoadingView.h
//  FireflyBox
//
//  Created by pig on 14-5-11.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFBaseLoadingView : UIView

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *tipLabel;

- (id)initWithFrame:(CGRect)frame tip:(NSString *)tTip;
- (void)updateView;

@end
