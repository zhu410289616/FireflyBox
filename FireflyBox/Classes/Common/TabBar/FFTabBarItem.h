//
//  FFTabBarItem.h
//  FireflyBox
//
//  Created by pig on 14-4-23.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTabBarItem : UIButton

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, assign) UIEdgeInsets itemImageEdge;
@property (nonatomic, strong) UILabel *itemTitleLabel;
@property (nonatomic, assign) UIEdgeInsets itemTitleEdge;
@property (nonatomic, strong) UIImage *norItemImage;
@property (nonatomic, strong) UIImage *selItemImage;

- (void)updateViewWithIsSelected:(BOOL)isSelected;

@end
