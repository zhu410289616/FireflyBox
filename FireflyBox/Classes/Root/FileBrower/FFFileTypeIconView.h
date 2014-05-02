//
//  FFFileTypeIconView.h
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFFileTypeHelper.h"

@interface FFFileTypeIconView : UIView

@property (nonatomic, strong) UILabel *fileTypeLabel;

- (void)updateViewWithTitle:(NSString *)title showColor:(UIColor *)showColor;

@end
