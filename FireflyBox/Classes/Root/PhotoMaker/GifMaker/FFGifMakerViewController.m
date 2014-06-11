//
//  FFGifMakerViewController.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFGifMakerViewController.h"
#import "FFAlbumTablePicker.h"

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
    
    self.assetPickerBar = [[FFPhotoThumbnailBar alloc] initWithFrame:CGRectMake(0, 100, GLOBAL_SCREEN_WIDTH, 96)];
    self.assetPickerBar.photoThumbnailDelegate = self;
    [self.view addSubview:self.assetPickerBar];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doLongPressAction:)];
    [self.assetPickerBar addGestureRecognizer:longPressRecognizer];
    
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

- (IBAction)doLongPressAction:(UILongPressGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.assetPickerBar];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (UIView *subview in self.assetPickerBar.subviews) {
                if ([subview isKindOfClass:[FFPhotoThumbnailView class]]) {
                    FFPhotoThumbnailView *photoThumbnailView = (FFPhotoThumbnailView *)subview;
                    if (self.assetPickerBar.isShake) {
                        [photoThumbnailView stopShake];
                    } else {
                        [photoThumbnailView startShake];
                    }
                }
            }
            self.assetPickerBar.isShake = !self.assetPickerBar.isShake;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark FFAssetSelectionDelegate method

- (void)selectedAssets:(NSArray *)ffAssets isUpdated:(BOOL)isUpdated
{
    [ffAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FFLog(@"obj: %@", obj);
    }];
    
    [self.assetPickerBar.ffAssetList removeAllObjects];
    [self.assetPickerBar.ffAssetList addObjectsFromArray:ffAssets];
    [self.assetPickerBar reloadData];
}

#pragma mark FFPhotoViewDelegate method

- (void)photoThumbnailViewDidSelect:(FFPhotoThumbnailView *)photoThumbnailView
{
    FFLog(@"ffAsset: %@", photoThumbnailView.ffAsset);
}

- (void)photoThumbnailViewDidDelete:(FFPhotoThumbnailView *)photoThumbnailView
{
    [self.assetPickerBar removeFFAsset:photoThumbnailView.ffAsset];
    [self.assetPickerBar reloadData];
}

@end
