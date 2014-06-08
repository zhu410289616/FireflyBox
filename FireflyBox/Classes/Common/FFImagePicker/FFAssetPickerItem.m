//
//  FFAssetPickerItem.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAssetPickerItem.h"

@implementation FFAssetPickerItem

- (id)initWithFFAsset:(FFAsset *)ffAsset frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ffAsset = ffAsset;
        
        self.thumbnailImageView = [[UIImageView alloc] init];
        self.thumbnailImageView.frame = CGRectMake(0, 0, 65.0f, 65.0f);
        self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
        self.thumbnailImageView.image = [UIImage imageWithCGImage:ffAsset.asset.thumbnail];
        [self addSubview:self.thumbnailImageView];
        
        UIImage *deleteBtnBgImage = [UIImage imageNamed:@"FFImagePicker.bundle/delete.png"];
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = (CGRect){-5, -5, deleteBtnBgImage.size};
        [self.deleteButton setImage:deleteBtnBgImage forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(doDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteButton];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSelectedAction:)];
        [self addGestureRecognizer:tapRecognizer];
        
    }
    return self;
}

- (IBAction)doDeleteAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(assetCanceled:)]) {
        [self.delegate assetCanceled:self.ffAsset];
    }
}

- (IBAction)doSelectedAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(assetSelected:)]) {
        [self.delegate assetSelected:self.ffAsset];
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
