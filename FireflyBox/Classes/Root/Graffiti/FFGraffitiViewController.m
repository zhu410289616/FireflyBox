//
//  FFGraffitiViewController.m
//  FireflyBox
//
//  Created by pig on 14-6-3.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGraffitiViewController.h"

const static float ffGraffitiButtonWidth = 40.0f;

@interface FFGraffitiViewController ()

@end

@implementation FFGraffitiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"涂鸦";
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    self.graffitiView = [[FFGraffitiView alloc] init];
    self.graffitiView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    self.graffitiView.backgroundColor = [UIColor whiteColor];
    self.graffitiView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.graffitiView];
    
    self.eraseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.eraseButton.frame = CGRectMake(0, CGRectGetHeight(self.graffitiView.frame) - 100 - ffGraffitiButtonWidth, ffGraffitiButtonWidth, ffGraffitiButtonWidth);
    self.eraseButton.backgroundColor = [UIColor orangeColor];
    self.eraseButton.layer.cornerRadius = ffGraffitiButtonWidth / 2;
    [self.view addSubview:self.eraseButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doRightBarButtonItemAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
