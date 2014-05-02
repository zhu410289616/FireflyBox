//
//  FFActionSheetView.h
//  FireflyBox
//
//  Created by pig on 14-5-2.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemActionBlock)(int actionIndex);

@interface FFActionSheetView : UIView
{
    UIView *_rootView;
    UIButton *_cancelButton;
}

@property (nonatomic, copy) ItemActionBlock actionBlock;

- (id)initWithView:(UIView *)actionView;
- (id)initWithTitles:(NSArray *)titles;
- (void)showInView:(UIView *)parentView;


@end
