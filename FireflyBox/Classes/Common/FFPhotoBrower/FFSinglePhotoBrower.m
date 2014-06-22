//
//  FFSinglePhotoBrower.m
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSinglePhotoBrower.h"
#import "FFPhotoCollectionCell.h"
#import "FFAlbumTablePicker.h"
#import "FFAsset.h"

@interface FFSinglePhotoBrower ()

@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation FFSinglePhotoBrower

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SinglePhotoBrower";
    
    FFBarButtonItem *leftBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doLeftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    FFBarButtonItem *rightBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //data collection view
    FFCollectionViewCellConfigureBlock configureCell = ^(FFPhotoCollectionCell *cell, id item, NSIndexPath *indexPath) {
        LOG_FRAME(@"cell.frame", cell.frame);
        [cell configureCellWithItem:item indexPath:indexPath delegate:self];
    };
    
    static NSString *CellIdentifier = @"FFPhotoCollectionCell";
    self.itemDataSource = [[FFCollectionViewDataSource alloc] initWithItems:nil cellIdentifier:CellIdentifier configureCellBlock:configureCell];
    self.dataCollectionView.dataSource = self.itemDataSource;
    //2. 注册cell类型
    [self.dataCollectionView registerClass:[FFPhotoCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    LOG_FRAME(@"self.view.frame", self.view.frame);
    self.view.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    LOG_FRAME(@"self.dataCollectionView.frame", self.dataCollectionView.frame);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLeftBarButtonItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    [self doGotoAlbumTablePicker:YES];
}

- (void)doGotoAlbumTablePicker:(BOOL)isAnimated
{
    FFAlbumTablePicker *albumPicker = [[FFAlbumTablePicker alloc] init];
    albumPicker.delegate = self;
//    [self navigationWithCustomStyle:NavigationStylePopPush toController:albumPicker animated:YES];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:albumPicker];
    [self presentViewController:nav animated:isAnimated completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.dataCollectionView.frame), CGRectGetHeight(self.dataCollectionView.frame));
}

#pragma mark FFPhotoViewDelegate

- (void)photoViewDidSingleTap:(FFPhotoView *)photoView
{
    [self toggleFullScreen];
}

- (void)photoViewDidDoubleTap:(FFPhotoView *)photoView
{
    // do nothing
}

- (void)photoViewDidTwoFingerTap:(FFPhotoView *)photoView
{
    // do nothing
}

- (void)photoViewDidDoubleTwoFingerTap:(FFPhotoView *)photoView
{
    LOG_FRAME(@"self.view.window.bounds", self.view.window.bounds);
    LOG_FRAME(@"self.view.window.frame", self.view.window.frame);
}

- (void)toggleFullScreen
{
    self.isFullScreen = !self.isFullScreen;
    
    if (!self.isFullScreen) {
        // fade in navigation
        
        [UIView animateWithDuration:0.4 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.alpha = 1.0;
            self.navigationController.toolbar.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    } else {
        // fade out navigation
        
        [UIView animateWithDuration:0.4 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.alpha = 0.0;
            self.navigationController.toolbar.alpha = 0.0;
        } completion:^(BOOL finished) {
        }];
    }
    
}

#pragma mark FFAssetSelectionDelegate method

- (void)selectedAssets:(NSArray *)ffAssets isUpdated:(BOOL)isUpdated
{
    NSMutableArray *imageList = [[NSMutableArray alloc] init];
    
    [ffAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FFAsset *ffAsset = (FFAsset *)obj;
        UIImage *assetFullImage = [UIImage imageWithCGImage:[[ffAsset.asset defaultRepresentation] fullScreenImage]];
        [imageList addObject:assetFullImage];
    }];
    
    [self.itemDataSource.items removeAllObjects];
    [self.itemDataSource.items addObjectsFromArray:imageList];
    [self.dataCollectionView reloadData];
}

@end
