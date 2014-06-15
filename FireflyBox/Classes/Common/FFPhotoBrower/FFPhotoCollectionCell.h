//
//  FFPhotoCollectionCell.h
//  FireflyBox
//
//  Created by pig on 14-6-10.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCollectionViewCell.h"
#import "FFPhotoView.h"

@interface FFPhotoCollectionCell : FFCollectionViewCell

@property (nonatomic, strong) FFPhotoView *photoView;

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath delegate:(id)delegate;

@end
