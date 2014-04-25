//
//  FFEmptyTipsView.h
//  FireflyBox
//
//  Created by pig on 14-4-26.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface FFEmptyTipsView : UIView

@property (nonatomic, strong) TTTAttributedLabel *emptyTipsLabel;
@property (nonatomic, strong) UIButton *emptyTipsActionButton;

- (id)initWithFrame:(CGRect)frame emptyTips:(NSString *)tEmptyTips;
- (id)initWithFrame:(CGRect)frame emptyTips:(NSString *)tEmptyTips rangeColor:(UIColor *)tRangeColor range:(NSRange)tRange;

@end
