//
//  FFTextReaderViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-1.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFTextReaderViewController.h"

@interface FFTextReaderViewController ()

@end

@implementation FFTextReaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark override function

- (BOOL)openFile
{
    [self openFileWithTxt:self.filePath];
    return YES;
}

#pragma mark function

- (void)openFileWithTxt:(NSString *)tFilePath
{
    NSString *body = [NSString stringWithContentsOfFile:tFilePath encoding:NSUTF8StringEncoding error:nil];
    if (!body) {
        body = [NSString stringWithContentsOfFile:tFilePath encoding:0x80000632 error:nil];
    }
    if (!body) {
        body = [NSString stringWithContentsOfFile:tFilePath encoding:0x80000631 error:nil];
    }
    [self.fileWebView loadHTMLString:body baseURL:nil];
}

@end
