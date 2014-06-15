//
//  FFCollectionViewDataSource.m
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCollectionViewDataSource.h"

@interface FFCollectionViewDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) FFCollectionViewCellConfigureBlock configureCellBlock;

@end

@implementation FFCollectionViewDataSource

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(FFCollectionViewCellConfigureBlock)aConfigureCellBlock
{
    if (self = [super init]) {
        self.items = [NSMutableArray arrayWithArray:anItems];
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    
    return cell;
}

@end
