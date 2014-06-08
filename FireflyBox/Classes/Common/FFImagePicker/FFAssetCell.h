//
//  FFAssetCell.h
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFAssetCell : UITableViewCell

/**
 *  设置当前cell显示的FFAsset
 *
 *  @param assets 包含FFAsset的数组NSArray
 */
- (void)setAssets:(NSArray *)assets;

@end
