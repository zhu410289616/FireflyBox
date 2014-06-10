//
//  FFPhotoThumbnailBar.m
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPhotoThumbnailBar.h"

@implementation FFPhotoThumbnailBar

- (id)init
{
    if (self = [super init]) {
        self.ffAssetList = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addFFAsset:(FFAsset *)ffAsset
{
    [self.ffAssetList addObject:ffAsset];
    [self reloadData];
}

- (void)removeFFAsset:(FFAsset *)ffAsset
{
    [self.ffAssetList removeObject:ffAsset];
    [self reloadData];
}

- (void)reloadData
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[FFPhotoThumbnailView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGRect rect = (CGRect){10, 25, 65, 65};
    
    for (FFAsset *ffAsset in self.ffAssetList) {
        FFPhotoThumbnailView *photoThumbnailView = [[FFPhotoThumbnailView alloc] initWithFFAsset:ffAsset frame:rect];
        photoThumbnailView.delegate = self;
        [self addSubview:photoThumbnailView];
        
        rect.origin.x = rect.origin.x + rect.size.width + 7;
    }
    
    [self setContentSize:(CGSize){rect.origin.x, 96}];
    if (rect.origin.x > GLOBAL_SCREEN_WIDTH) {
        [self setContentOffset:(CGPoint){rect.origin.x-GLOBAL_SCREEN_WIDTH, 0} animated:YES];
    }
}

#pragma mark FFPhotoViewDelegate method

- (void)photoThumbnailViewDidSelect:(FFPhotoThumbnailView *)photoThumbnailView
{
    if ([self.photoThumbnailDelegate respondsToSelector:@selector(photoThumbnailViewDidSelect:)]) {
        [self.photoThumbnailDelegate photoThumbnailViewDidSelect:photoThumbnailView];
    }
}

- (void)photoThumbnailViewDidDelete:(FFPhotoThumbnailView *)photoThumbnailView
{
    if ([self.photoThumbnailDelegate respondsToSelector:@selector(photoThumbnailViewDidDelete:)]) {
        [self.photoThumbnailDelegate photoThumbnailViewDidDelete:photoThumbnailView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
