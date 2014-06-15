//
//  FFCollectionViewCell.h
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFCollectionViewCell : UICollectionViewCell

- (void)configureCellWithItem:(id)item indexPath:(NSIndexPath *)indexPath;
- (void)configureCellWithItem:(id)item;

@end
