//
//  FFCollectionViewDataSource.h
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FFCollectionViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface FFCollectionViewDataSource : NSObject<UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *items;

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(FFCollectionViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
