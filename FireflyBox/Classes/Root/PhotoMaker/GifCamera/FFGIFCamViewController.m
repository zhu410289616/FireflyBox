//
//  FFGIFCamViewController.m
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGIFCamViewController.h"
#import "FFGifMakerViewController.h"

#import "FFMultiPhotoBrower.h"

@interface FFGIFCamViewController ()

@end

@implementation FFGIFCamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLoadAction
{
    [super viewDidLoadAction];
    
    self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.exitButton.frame = CGRectMake(15, GLOBAL_SCREEN_HEIGHT - 60 - 15, 60, 60);
    self.exitButton.backgroundColor = [UIColor orangeColor];
    self.exitButton.alpha = 0.7f;
    self.exitButton.layer.cornerRadius = 30.0f;
    self.exitButton.layer.masksToBounds = YES;
    [self.exitButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.exitButton addTarget:self action:@selector(doExitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.exitButton];
    
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoButton.frame = CGRectMake(100, 80, 60, 60);
    [self.photoButton setTitle:@"Photo" forState:UIControlStateNormal];
    [self.photoButton addTarget:self action:@selector(doShowPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.photoButton];
    
    self.ffAssetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ffAssetButton.frame = CGRectMake(100, 180, 60, 60);
    [self.ffAssetButton setTitle:@"FFAsset" forState:UIControlStateNormal];
    [self.ffAssetButton addTarget:self action:@selector(doShowFFAssetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ffAssetButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doExitAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doShowPhotoAction:(id)sender
{
    FFGifMakerViewController *gifMakerController = [[FFGifMakerViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:gifMakerController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)doShowFFAssetAction:(id)sender
{
    FFMultiPhotoBrower *multiPhotoBrower = [[FFMultiPhotoBrower alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:multiPhotoBrower];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
