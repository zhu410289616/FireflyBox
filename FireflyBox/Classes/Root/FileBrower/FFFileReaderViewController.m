//
//  FFFileReaderViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileReaderViewController.h"

@interface FFFileReaderViewController ()

@end

@implementation FFFileReaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _fileWebView = [[UIWebView alloc] init];
    _fileWebView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT - 64);
    _fileWebView.backgroundColor = [UIColor whiteColor];
    _fileWebView.delegate = self;
    _fileWebView.multipleTouchEnabled = YES;
    _fileWebView.scalesPageToFit = YES;
    [self.view addSubview:_fileWebView];
    
    //
    if (![self openFile]) {
        [self openFileWithDefault];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openFileWithDefault
{
    NSURL *url = [NSURL fileURLWithPath:_filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_fileWebView loadRequest:request];
}

/*
 * override in subclass
 * if override function then return yes, else return no
 */
- (BOOL)openFile
{
    return NO;
}

#pragma mark UIWebViewDelegate method

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    PLog(@"webViewDidStartLoad...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    PLog(@"webViewDidFinishLoad...");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    PLog(@"didFailLoadWithError: %@", error);
}

@end
