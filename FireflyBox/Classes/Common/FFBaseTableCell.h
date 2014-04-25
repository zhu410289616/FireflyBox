//
//  FFBaseTableCell.h
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFBaseTableCell : UITableViewCell

@property (nonatomic, assign) float lineHeight;
@property (nonatomic, strong) UIView *headerLineView;
@property (nonatomic, strong) UIView *footerLineView;

@end
