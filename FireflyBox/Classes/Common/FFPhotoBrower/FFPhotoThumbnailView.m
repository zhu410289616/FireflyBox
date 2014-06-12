//
//  FFPhotoThumbnailView.m
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPhotoThumbnailView.h"

@implementation FFPhotoThumbnailView

- (id)initWithFFAsset:(FFAsset *)ffAsset frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ffAsset = ffAsset;
        
        self.thumbnailImageView = [[UIImageView alloc] init];
        self.thumbnailImageView.frame = CGRectMake(0, 0, 52, 52);
        self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
        self.thumbnailImageView.image = [UIImage imageWithCGImage:ffAsset.asset.thumbnail];
        [self addSubview:self.thumbnailImageView];
        
        UIImage *deleteBtnBgImage = [UIImage imageNamed:@"FFPhotoBrower.bundle/delete.png"];
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = (CGRect){-5, -5, deleteBtnBgImage.size};
        [self.deleteButton setImage:deleteBtnBgImage forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(doDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteButton];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSelectAction:)];
        [self addGestureRecognizer:tapRecognizer];
        
    }
    return self;
}

- (IBAction)doDeleteAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(photoThumbnailViewDidDelete:)]) {
        [self.delegate photoThumbnailViewDidDelete:self];
    }
}

- (IBAction)doSelectAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(photoThumbnailViewDidSelect:)]) {
        [self.delegate photoThumbnailViewDidSelect:self];
    }
}

- (void)startShake
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    shakeAnimation.duration = 0.08;
    shakeAnimation.autoreverses = YES;
    shakeAnimation.repeatCount = MAXFLOAT;
    shakeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -0.1, 0, 0, 1)];
    shakeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, 0.1, 0, 0, 1)];
    
    [self.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}

- (void)stopShake
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
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
