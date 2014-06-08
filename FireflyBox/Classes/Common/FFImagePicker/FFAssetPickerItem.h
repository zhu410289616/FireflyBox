//
//  FFAssetPickerItem.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFAsset.h"

@interface FFAssetPickerItem : UIView

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) FFAsset *ffAsset;
@property (nonatomic, weak) id<FFAssetDelegate> delegate;

- (id)initWithFFAsset:(FFAsset *)ffAsset frame:(CGRect)frame;

@end
