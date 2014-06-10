//
//  FFPhotoBrower.m
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPhotoBrower.h"
#import "FFPhotoCollectionCell.h"

@interface FFPhotoBrower ()

@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) CGFloat currentZoomScale;

@end

@implementation FFPhotoBrower

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  代码初始化
     *  需要用以下的方式处理，否则init会崩溃
     */
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0f;//cell间的间隔
    //1. 设置collectionViewLayout
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    //2. 注册cell类型
    [self.collectionView registerClass:[FFPhotoCollectionCell class] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    
    self.photosDataSource = [[FFPhotosDataSource alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.translucent = YES;
    self.navigationController.toolbar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
//    [self setToolbarItems:self.customToolbarItems animated:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.toolbar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
}

- (BOOL)prefersStatusBarHidden
{
    return self.isFullScreen;
}

#pragma mark - Orientation
#pragma mark -

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    FFLog(@"%@", NSStringFromSelector(_cmd));
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    // ensure the item is dislayed after rotation
    _currentIndexPath = [self indexPathForCurrentItem];
    
}

// changes in this method will be included with view controller's animation block
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    FFLog(@"%@", NSStringFromSelector(_cmd));
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    FFLog(@"%@", NSStringFromSelector(_cmd));
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (_currentIndexPath) {
            FFLog(@"item: %li", (long)_currentIndexPath.item);
            
            [self.collectionView.collectionViewLayout invalidateLayout];
            [self.collectionView scrollToItemAtIndexPath:_currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:FALSE];
            
        }
    });
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark function

#pragma mark - User Actions
#pragma mark -

- (NSArray *)customToolbarItems
{
    UIBarButtonItem *flexItem1 = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                  target:self
                                  action:nil];
    UIBarButtonItem *flexItem2 = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                  target:self
                                  action:nil];
    UIBarButtonItem *flexItem3 = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                  target:self
                                  action:nil];
    UIBarButtonItem *flexItem4 = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                  target:self
                                  action:nil];
    
    UIBarButtonItem *maximumButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Maximum"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(showMaximumSize:)];
    
    UIBarButtonItem *mediumButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Medium"
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(showMediumSize:)];
    
    UIBarButtonItem *minimumButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Minimum"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(showMinimumSize:)];
    
    return @[flexItem1, maximumButton, flexItem2, mediumButton, flexItem3, minimumButton, flexItem4];
}

- (FFPhotoView *)visiblePhotoView
{
    NSArray *visibleCells = [self.collectionView visibleCells];
    
    if (visibleCells.count) {
        UIView *cell = visibleCells[0];
        UIView *view = [cell viewWithTag:1];
        if ([view isKindOfClass:[FFPhotoView class]]) {
            return (FFPhotoView *)view;
        }
    }
    
    return nil;
}

- (void)showMaximumSize:(id)sender
{
    FFPhotoView *photoView = [self visiblePhotoView];
    [photoView updateZoomScale:photoView.maximumZoomScale];
}

- (void)showMediumSize:(id)sender
{
    FFPhotoView *photoView = [self visiblePhotoView];
    CGFloat newScale = (photoView.minimumZoomScale + photoView.maximumZoomScale) / 2.0;
    [photoView updateZoomScale:newScale];
}

- (void)showMinimumSize:(id)sender
{
    FFPhotoView *photoView = [self visiblePhotoView];
    [photoView updateZoomScale:photoView.minimumZoomScale];
}

#pragma mark FFPhotoViewDelegate method

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
    [self logLayout];
}

- (void)toggleFullScreen
{
    FFLog(@"toggling full screen");
    
    self.isFullScreen = !self.isFullScreen;
    
    if (!self.isFullScreen) {
        // fade in navigation
        
        FFLog(@"fading in");
        
        [UIView animateWithDuration:0.4 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.alpha = 1.0;
            self.navigationController.toolbar.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    } else {
        // fade out navigation
        
        FFLog(@"fading out");
        
        [UIView animateWithDuration:0.4 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.alpha = 0.0;
            self.navigationController.toolbar.alpha = 0.0;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - Layout Debugging Support
#pragma mark -

- (void)logRect:(CGRect)rect withName:(NSString *)name
{
    LOG_FRAME(name, rect);
}

- (void)logLayout
{
    FFLog(@"### FFPhotoBrower ###");
    [self logRect:self.view.window.bounds withName:@"self.view.window.bounds"];
    [self logRect:self.view.window.frame withName:@"self.view.window.frame"];
    
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    [self logRect:applicationFrame withName:@"application frame"];
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
    
    [self logRect:cell.frame withName:[NSString stringWithFormat:@"FFPhotoCollectionCell: %ld", (long)indexPath.row]];
    
    UIView *view = [cell viewWithTag:1];
    if ([view isKindOfClass:[FFPhotoView class]]) {
        FFPhotoView *photoView = (FFPhotoView *)view;
        
        [photoView prepareForReuse];
        
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

#pragma mark - Private
#pragma mark -

- (UIImage *)screenshotOfCurrentItem
{
    if (!floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        NSCAssert(FALSE, @"iOS 7 or later is required.");
    }
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[self indexPathForCurrentItem]];
    
    LOG_FRAME(@"collectionView", self.collectionView.frame);
    LOG_FRAME(@"cell", cell.frame);
    
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, 0.0);
    [cell drawViewHierarchyInRect:cell.bounds afterScreenUpdates:NO];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (NSIndexPath *)indexPathForCurrentItem
{
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    if (indexPaths.count) {
        return indexPaths[0];
    }
    
    return nil;
}

@end
