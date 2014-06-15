//
//  FFPhotoCollectionCell.m
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFPhotoCollectionCell.h"

@implementation FFPhotoCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.photoView = [[FFPhotoView alloc] init];
        self.photoView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.photoView.tag = 1;
        [self addSubview:self.photoView];
        
    }
    return self;
}

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath delegate:(id)delegate
{
    [self.photoView prepareForReuse];
    
    self.photoView.photoViewDelegate = delegate;
    [self.photoView startWaiting];
    
    self.photoView.alpha = 0.0f;
    [self.photoView displayImage:item];
    [UIView animateWithDuration:0.35f animations:^{
        self.photoView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.photoView stopWaiting];
    }];
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
