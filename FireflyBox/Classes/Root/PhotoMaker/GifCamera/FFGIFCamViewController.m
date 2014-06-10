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
    
    self.title = @"Photo";
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
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

- (IBAction)doShowPhotoAction:(id)sender
{
    FFGifMakerViewController *gifMakerController = [[FFGifMakerViewController alloc] init];
    [self.navigationController pushViewController:gifMakerController animated:YES];
}

- (IBAction)doShowFFAssetAction:(id)sender
{
    FFMultiPhotoBrower *multiPhotoBrower = [[FFMultiPhotoBrower alloc] init];
    [self.navigationController pushViewController:multiPhotoBrower animated:YES];
}

@end
