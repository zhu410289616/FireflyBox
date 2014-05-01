//
//  FFFileReaderViewController.h
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"

@interface FFFileReaderViewController : FFBaseViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *fileWebView;

@property (nonatomic, strong) NSString *filePath;

- (BOOL)openFile;

@end
