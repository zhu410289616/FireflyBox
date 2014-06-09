//
//  FFPhotoBrower.m
//  FireflyBox
//
//  Created by pig on 14-6-9.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPhotoBrower.h"

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
    PLog(@"toggling full screen");
    
    self.isFullScreen = !self.isFullScreen;
    
    if (!self.isFullScreen) {
        // fade in navigation
        
        PLog(@"fading in");
        
        [UIView animateWithDuration:0.4 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
            self.navigationController.navigationBar.alpha = 1.0;
            self.navigationController.toolbar.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    } else {
        // fade out navigation
        
        PLog(@"fading out");
        
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
    PLog(@"%@: %f, %f / %f, %f", name, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

- (void)logLayout
{
    PLog(@"### PZViewController ###");
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoView" forIndexPath:indexPath];
    
    UIView *view = [cell viewWithTag:1];
    if ([view isKindOfClass:[FFPhotoView class]]) {
        FFPhotoView *photoView = (FFPhotoView *)view;
        
        [photoView prepareForReuse];
        
        [photoView startWaiting];
        [self.photosDataSource photoForIndex:indexPath.item withCompletionBlock:^(UIImage *photo, NSError *error) {
            [photoView stopWaiting];
            if (error != nil) {
                PLog(@"Error: %@", error);
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

- (UIImage *)screenshotOfCurrentItem {
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
