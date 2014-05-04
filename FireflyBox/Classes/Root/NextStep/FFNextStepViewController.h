//
//  FFNextStepViewController.h
//  FireflyBox
//
//  Created by pig on 14-5-4.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFNextStepViewController : FFBaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *nextStepWebView;

- (void)loadNextStepOne;

@end
