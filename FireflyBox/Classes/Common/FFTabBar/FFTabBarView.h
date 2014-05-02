//
//  FFTabBarView.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFTabBarItem.h"

@protocol FFTabBarViewDelegate <NSObject>

- (BOOL)tabBarItem:(FFTabBarItem *)tTabBarItem willSelected:(NSInteger)tIndex;
- (void)tabBarItem:(FFTabBarItem *)tTabBarItem didSelected:(NSInteger)tIndex;

@end

@interface FFTabBarView : UIView

@property (nonatomic, assign) id<FFTabBarViewDelegate> delegate;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)tTitleList;
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)tTitleList norIconList:(NSArray *)tNorIconList selIconList:(NSArray *)tSelIconList;

- (void)selectedTabBarItem:(NSInteger)tIndex;

@end
