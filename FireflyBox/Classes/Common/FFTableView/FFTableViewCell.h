//
//  FFTableViewCell.h
//  FireflyBox
//
//  Created by pig on 14-6-14.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTableViewCell : UITableViewCell

@property (nonatomic, assign) float lineHeight;
@property (nonatomic, strong) UIView *headerLineView;
@property (nonatomic, strong) UIView *footerLineView;

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath;
- (void)configureCellWithItem:(id)item;

@end
