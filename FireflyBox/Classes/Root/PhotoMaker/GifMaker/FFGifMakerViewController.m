//
//  FFGifMakerViewController.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGifMakerViewController.h"
#import "FFAlbumTablePicker.h"

#import "FFAssetPickerBar.h"

@interface FFGifMakerViewController ()

@end

@implementation FFGifMakerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    float addButtonWidth = 80.0f;
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake((GLOBAL_SCREEN_WIDTH - addButtonWidth)/2, GLOBAL_SCREEN_HEIGHT - 64 - 30 - addButtonWidth, addButtonWidth, addButtonWidth);
    addButton.tag = 100;
    [addButton styleWithCornerRadius:addButtonWidth/2];
    [addButton styleWithTitle:@"搜索" titleColor:[UIColor whiteColor]];
    [addButton styleWithBackgroundColor:[UIColor orangeColor]];
    [addButton addTarget:self action:@selector(doAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    self.assetPickerBar = [[FFAssetPickerBar alloc] initWithFrame:CGRectMake(0, 100, GLOBAL_SCREEN_WIDTH, 96)];
    self.assetPickerBar.ffAssetDelegate = self;
    [self.view addSubview:self.assetPickerBar];
    
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

- (IBAction)doAddButtonAction:(id)sender
{
    FFAlbumTablePicker *albumPicker = [[FFAlbumTablePicker alloc] init];
    albumPicker.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:albumPicker];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark FFAssetSelectionDelegate method

- (void)selectedAssets:(NSArray *)ffAssets isUpdated:(BOOL)isUpdated
{
    [ffAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FFLog(@"obj: %@", obj);
    }];
    
    [self.assetPickerBar.selectedAssets removeAllObjects];
    [self.assetPickerBar.selectedAssets addObjectsFromArray:ffAssets];
    [self.assetPickerBar reloadData];
}

#pragma mark FFAssetDelegate method

- (void)assetSelected:(FFAsset *)ffAsset
{
    FFLog(@"ffAsset: %@", ffAsset);
}

- (void)assetCanceled:(FFAsset *)ffAsset
{
    [self.assetPickerBar removeAsset:ffAsset];
}

@end
