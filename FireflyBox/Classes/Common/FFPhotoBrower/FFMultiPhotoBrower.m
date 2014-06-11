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
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doAddButtonAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doSingleRecognizerAction:)];
    [self.view addGestureRecognizer:panRecognizer];
    
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
    [self.view addSubview:self.thumbnailBar];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(doLongPressAction:)];
    [self.thumbnailBar addGestureRecognizer:longPressRecognizer];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doAddButtonAction:(id)sender
{
    FFAlbumTablePicker *albumPicker = [[FFAlbumTablePicker alloc] init];
    albumPicker.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:albumPicker];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)doSingleRecognizerAction:(UIPanGestureRecognizer *)sender
{
    if (!self.thumbnailBar.isShake) {
        return;
    }
    
    CGPoint point = [sender locationInView:self.thumbnailBar];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (UIView *subview in self.thumbnailBar.subviews) {
                if ([subview isKindOfClass:[FFPhotoThumbnailView class]]) {
                    FFPhotoThumbnailView *photoThumbnailView = (FFPhotoThumbnailView *)subview;
                    if (self.thumbnailBar.isShake) {
                        [photoThumbnailView stopShake];
                    }
                }
            }
            self.thumbnailBar.isShake = !self.thumbnailBar.isShake;
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

- (IBAction)doLongPressAction:(UILongPressGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (UIView *subview in self.thumbnailBar.subviews) {
                if ([subview isKindOfClass:[FFPhotoThumbnailView class]]) {
                    FFPhotoThumbnailView *photoThumbnailView = (FFPhotoThumbnailView *)subview;
                    if (self.thumbnailBar.isShake) {
                        [photoThumbnailView stopShake];
                    } else {
                        [photoThumbnailView startShake];
                    }
                }
            }
            self.thumbnailBar.isShake = !self.thumbnailBar.isShake;
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
    
    [self.thumbnailBar.ffAssetList removeAllObjects];
    [self.thumbnailBar.ffAssetList addObjectsFromArray:ffAssets];
    [self.thumbnailBar reloadData];
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
                FFLog(@"Error: %@", error);
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
    FFLog(@"%@: %f, %f / %f, %f", name, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

- (void)logLayout
{
    FFLog(@"### FFMultiPhotoBrower ###");
    [self logRect:self.view.window.bounds withName:@"self.view.window.bounds"];
    [self logRect:self.view.window.frame withName:@"self.view.window.frame"];
    
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    [self logRect:applicationFrame withName:@"application frame"];
}

@end
