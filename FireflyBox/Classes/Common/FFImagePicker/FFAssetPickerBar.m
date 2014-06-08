//
//  FFAssetPickerBar.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAssetPickerBar.h"
#import "FFAssetPickerItem.h"

@implementation FFAssetPickerBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selectedAssets = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
    }
    return self;
}

- (void)addAsset:(FFAsset *)ffAsset
{
    [self.selectedAssets addObject:ffAsset];
    [self reloadData];
}

- (void)removeAsset:(FFAsset *)ffAsset
{
    [self.selectedAssets removeObject:ffAsset];
    [self reloadData];
}

- (void)reloadData
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[FFAssetPickerItem class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGRect rect = (CGRect){10, 25, 65, 65};
    
    for (FFAsset *ffAsset in self.selectedAssets) {
        FFAssetPickerItem *assetItem = [[FFAssetPickerItem alloc] initWithFFAsset:ffAsset frame:rect];
        assetItem.delegate = self;
        [self addSubview:assetItem];
        
        rect.origin.x = rect.origin.x + rect.size.width + 7;
    }
    
    [self setContentSize:(CGSize){rect.origin.x, 96}];
    if (rect.origin.x > GLOBAL_SCREEN_WIDTH) {
        [self setContentOffset:(CGPoint){rect.origin.x-GLOBAL_SCREEN_WIDTH, 0} animated:YES];
    }
}

#pragma mark FFAssetDelegate method

- (void)assetSelected:(FFAsset *)ffAsset
{
    if ([self.ffAssetDelegate respondsToSelector:@selector(assetSelected:)]) {
        [self.ffAssetDelegate assetSelected:ffAsset];
    }
}

- (void)assetCanceled:(FFAsset *)ffAsset
{
    if ([self.ffAssetDelegate respondsToSelector:@selector(assetCanceled:)]) {
        [self.ffAssetDelegate assetCanceled:ffAsset];
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
