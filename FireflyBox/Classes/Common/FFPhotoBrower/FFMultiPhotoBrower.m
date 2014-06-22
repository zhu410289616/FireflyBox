//
//  FFMultiPhotoBrower.m
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFMultiPhotoBrower.h"

#import "FFAlbumTablePicker.h"

#import "FFPhotoCollectionCell.h"

@interface FFMultiPhotoBrower ()

@end

@implementation FFMultiPhotoBrower

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FFBarButtonItem *leftBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doLeftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    FFBarButtonItem *rightBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapRecognizerAction:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPanRecognizerAction:)];
    [self.view addGestureRecognizer:panRecognizer];
    
    self.multiPhotoEditView = [[FFMultiPhotoEditView alloc] init];
    self.multiPhotoEditView.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT - 64 - 72, GLOBAL_SCREEN_WIDTH, 72);
    self.multiPhotoEditView.photoThumbnailDelegate = self;
    [self.view addSubview:self.multiPhotoEditView];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doLongPressAction:)];
    [self.multiPhotoEditView addGestureRecognizer:longPressRecognizer];
    
    float addButtonWidth = 80.0f;
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake((GLOBAL_SCREEN_WIDTH - addButtonWidth)/2, GLOBAL_SCREEN_HEIGHT - 64 - 30 - addButtonWidth, addButtonWidth, addButtonWidth);
    addButton.tag = 100;
    [addButton styleWithCornerRadius:addButtonWidth/2];
    [addButton styleWithTitle:@"搜索" titleColor:[UIColor whiteColor]];
    [addButton styleWithBackgroundColor:[UIColor orangeColor]];
    [addButton addTarget:self action:@selector(doAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    self.thumbnailBar = [[FFPhotoThumbnailBar alloc] init];
    self.thumbnailBar.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT - 64 - 96, GLOBAL_SCREEN_WIDTH, 96);
    self.thumbnailBar.photoThumbnailDelegate = self;
//    [self.view addSubview:self.thumbnailBar];
    
    /**
     *  代码初始化
     *  需要用以下的方式处理，否则init会崩溃
     */
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0f;//布局cell间的间隔
    //1. 设置collectionViewLayout
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT - 64 - 96) collectionViewLayout:flowLayout];
    //2. 注册cell类型
    [self.collectionView registerClass:[FFPhotoCollectionCell class] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
    [self.view addSubview:self.collectionView];
    
    self.photosDataSource = [[FFPhotosDataSource alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    [self doAddButtonAction:nil];
}

- (IBAction)doAddButtonAction:(id)sender
{
    [self doGotoAlbumTablePicker:YES];
}

- (void)doGotoAlbumTablePicker:(BOOL)isAnimated
{
    FFAlbumTablePicker *albumPicker = [[FFAlbumTablePicker alloc] init];
    albumPicker.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:albumPicker];
    [self presentViewController:nav animated:isAnimated completion:nil];
}

- (IBAction)doTapRecognizerAction:(UITapGestureRecognizer *)sender
{
    if (self.multiPhotoEditView.isShaking) {
        for (int i=0; i<[self.multiPhotoEditView.visibleThumbnailViews count]; i++) {
            FFPhotoThumbnailView *thumbnailView = self.multiPhotoEditView.visibleThumbnailViews[i];
            [thumbnailView stopShake];
        }
        self.multiPhotoEditView.isShaking = !self.multiPhotoEditView.isShaking;
    }
    
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {}
            break;
            
        default:
            break;
    }
}

- (IBAction)doPanRecognizerAction:(UIPanGestureRecognizer *)sender
{
    if (!self.multiPhotoEditView.isShaking) {
        return;
    }
    
    CGPoint currentPoint = [sender locationInView:self.thumbnailBar];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (FFPhotoThumbnailView *photoThumbnailView in self.multiPhotoEditView.visibleThumbnailViews) {
                if (CGRectContainsPoint(photoThumbnailView.frame, currentPoint)) {
                    self.multiPhotoEditView.dragThumbnailView = photoThumbnailView;
                    [self.multiPhotoEditView bringSubviewToFront:photoThumbnailView];
                    [photoThumbnailView stopShake];
                    break;
                }
            }
//            self.multiPhotoEditView.isShaking = !self.multiPhotoEditView.isShaking;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            int indexOfDrag = 0;
            for (int i=0; i<[self.multiPhotoEditView.visibleThumbnailViews count]; i++) {
                FFPhotoThumbnailView *thumbnailView = self.multiPhotoEditView.visibleThumbnailViews[i];
                if (thumbnailView.tag == self.multiPhotoEditView.dragThumbnailView.tag) {
                    indexOfDrag = i;
                }
            }
            
            for (int i=0; i<[self.multiPhotoEditView.visibleThumbnailViews count]; i++) {
                FFPhotoThumbnailView *photoThumbnailView = self.multiPhotoEditView.visibleThumbnailViews[i];
                if (photoThumbnailView.tag == self.multiPhotoEditView.dragThumbnailView.tag) {
                    continue;
                }
                if (CGRectIntersectsRect(self.multiPhotoEditView.dragThumbnailView.frame, photoThumbnailView.frame)) {
                    
                    [self.multiPhotoEditView.visibleThumbnailViews exchangeObjectAtIndex:i withObjectAtIndex:indexOfDrag];
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        CGRect rect = (CGRect){10, 10, 52, 52};
                        for (int i=0; i<[self.multiPhotoEditView.visibleThumbnailViews count]; i++) {
                            FFPhotoThumbnailView *thumbnailView = self.multiPhotoEditView.visibleThumbnailViews[i];
                            if (thumbnailView.tag != self.multiPhotoEditView.dragThumbnailView.tag) {
                                rect.origin.x = rect.origin.x + rect.size.width + 10;
                            }
                        }
                    }];
                }
            }
            
            [self.multiPhotoEditView doDrag:currentPoint];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
//            [self.multiPhotoEditView.dragThumbnailView startShake];
//            self.multiPhotoEditView.dragThumbnailView = nil;
        }
            break;
            
        default:
            break;
    }
    
    self.multiPhotoEditView.previousPoint = currentPoint;
}

- (IBAction)doLongPressAction:(UILongPressGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.multiPhotoEditView.isShaking) {
                for (FFPhotoThumbnailView *photoThumbnailView in self.multiPhotoEditView.visibleThumbnailViews) {
                    [photoThumbnailView stopShake];
                }
            } else {
                for (FFPhotoThumbnailView *photoThumbnailView in self.multiPhotoEditView.visibleThumbnailViews) {
                    [photoThumbnailView startShake];
                }
            }
            self.multiPhotoEditView.isShaking = !self.multiPhotoEditView.isShaking;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
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
        FFLOG_FORMAT(@"obj: %@", obj);
    }];
    
    [self.multiPhotoEditView removeAllFFAsset];
    [self.multiPhotoEditView addFFAssetList:ffAssets];
    [self.multiPhotoEditView reloadData];
}

#pragma mark - UICollectionViewDelegate
#pragma mark -

#pragma mark - UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PhotoCollectionCell = @"PhotoCollectionCell";
    FFPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    NSString *cellIndex = [NSString stringWithFormat:@"FFPhotoCollectionCell: %ld", (long)indexPath.row];
    LOG_FRAME(cellIndex, cell.frame);
    
    UIView *view = [cell viewWithTag:1];
    if ([view isKindOfClass:[FFPhotoView class]]) {
        FFPhotoView *photoView = (FFPhotoView *)view;
        
        [photoView prepareForReuse];
        photoView.photoViewDelegate = self;
        
        [photoView startWaiting];
        [self.photosDataSource photoForIndex:indexPath.item withCompletionBlock:^(UIImage *photo, NSError *error) {
            [photoView stopWaiting];
            if (error != nil) {
                FFLOG_FORMAT(@"Error: %@", error);
            }
            else {
                photoView.alpha = 0.0f;
                [photoView displayImage:photo];
                [UIView animateWithDuration:0.35f animations:^{
                    photoView.alpha = 1.0f;
                } completion:^(BOOL finished) {
                }];
            }
        }];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGRectGetHeight(self.collectionView.frame));
}

#pragma mark FFPhotoViewDelegate method

- (void)photoViewDidSingleTap:(FFPhotoView *)photoView
{
    //do nothing
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
    [self logLayout];
}

#pragma mark - Layout Debugging Support
#pragma mark -

- (void)logRect:(CGRect)rect withName:(NSString *)name
{
    FFLOG_FORMAT(@"%@: %f, %f / %f, %f", name, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

- (void)logLayout
{
    FFLOG_FORMAT(@"### FFMultiPhotoBrower ###");
    [self logRect:self.view.window.bounds withName:@"self.view.window.bounds"];
    [self logRect:self.view.window.frame withName:@"self.view.window.frame"];
    
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    [self logRect:applicationFrame withName:@"application frame"];
}

@end
