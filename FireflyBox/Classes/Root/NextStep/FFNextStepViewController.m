//
//  FFNextStepViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-4.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFNextStepViewController.h"

@interface FFNextStepViewController ()

@end

@implementation FFNextStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"下一步";
    self.view.backgroundColor = [UIColor whiteColor];
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    _nextStepWebView = [[UIWebView alloc] init];
    _nextStepWebView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT - 64);
    _nextStepWebView.backgroundColor = [UIColor whiteColor];
    _nextStepWebView.multipleTouchEnabled = YES;
    _nextStepWebView.scalesPageToFit = YES;
    [self.view addSubview:_nextStepWebView];
    
    //
    [self loadNextStepOne];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark public function

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark function

- (void)loadNextStepOne
{
    NSString *nextStepPath = [[NSBundle mainBundle] pathForResource:@"NextStepOne" ofType:@"html" inDirectory:@"NextStep.bundle"];
    NSURL *url = [NSURL fileURLWithPath:nextStepPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_nextStepWebView loadRequest:request];
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
