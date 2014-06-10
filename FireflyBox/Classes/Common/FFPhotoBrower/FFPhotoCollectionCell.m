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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
