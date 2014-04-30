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
    
    _fileWebView = [[UIWebView alloc] init];
    _fileWebView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT - 44);
    _fileWebView.delegate = self;
    _fileWebView.multipleTouchEnabled = YES;
    _fileWebView.scalesPageToFit = YES;
    [self.view addSubview:_fileWebView];
    
    [self openFile];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openFile
{
    NSRange extRange = [[_filePath lowercaseString] rangeOfString:@".txt"];
    if (extRange.location != NSNotFound && extRange.length > 0) {
        [self openFileWithTxt:_filePath];
    } else {
        NSURL *url = [NSURL fileURLWithPath:_filePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_fileWebView loadRequest:request];
    }
}

- (void)openFileWithTxt:(NSString *)tFilePath
{
    NSString *body = [NSString stringWithContentsOfFile:tFilePath encoding:NSUTF8StringEncoding error:nil];
    if (!body) {
        body = [NSString stringWithContentsOfFile:tFilePath encoding:0x80000632 error:nil];
    }
    if (!body) {
        body = [NSString stringWithContentsOfFile:tFilePath encoding:0x80000631 error:nil];
    }
    [_fileWebView loadHTMLString:body baseURL:nil];
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
