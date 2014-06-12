//
//  FFMultiPhotoEditView.m
//  FireflyBox
//
//  Created by pig on 14-6-12.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFMultiPhotoEditView.h"
#import "FFPhotoThumbnailView.h"

@interface FFMultiPhotoEditView ()

@property (nonatomic, strong) NSMutableArray *ffAssetList;
@property (nonatomic, assign) int columns;

@end

@implementation FFMultiPhotoEditView

- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
        self.ffAssetList = [[NSMutableArray alloc] init];
        self.columns = 5;
        self.visibleThumbnailViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addFFAssetList:(NSArray *)ffAssetList
{
    [self.ffAssetList addObjectsFromArray:ffAssetList];
    [self reloadData];
}

- (void)addFFAsset:(FFAsset *)ffAsset
{
    [self.ffAssetList addObject:ffAsset];
    [self reloadData];
}

- (void)removeAllFFAsset
{
    [self.ffAssetList removeAllObjects];
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
    
    CGRect rect = (CGRect){10, 10, 52, 52};
    
    int i = 0;
    for (FFAsset *ffAsset in self.ffAssetList) {
        FFPhotoThumbnailView *photoThumbnailView = [[FFPhotoThumbnailView alloc] initWithFFAsset:ffAsset frame:rect];
        photoThumbnailView.delegate = self;
        photoThumbnailView.tag = 100 + i;
        [self addSubview:photoThumbnailView];
        
        [self.visibleThumbnailViews addObject:photoThumbnailView];
        
        rect.origin.x = rect.origin.x + rect.size.width + 10;
        i++;
    }
}

- (void)doDrag:(CGPoint)currentPoint
{
    CGRect dragRect = self.dragThumbnailView.frame;
    dragRect.origin.x += currentPoint.x - self.previousPoint.x;
    dragRect.origin.y += currentPoint.y - self.previousPoint.y;
    self.dragThumbnailView.frame = dragRect;
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
