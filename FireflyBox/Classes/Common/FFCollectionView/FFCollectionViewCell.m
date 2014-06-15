//
//  FFCollectionViewCell.m
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCollectionViewCell.h"

@implementation FFCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath
{
    //todo
}

- (void)configureCellWithItem:(id)item
{
    //todo
    [self configureCellWithItem:item indexPath:nil];
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
