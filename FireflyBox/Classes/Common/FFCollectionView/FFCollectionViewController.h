//
//  FFCollectionViewController.h
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFCollectionViewDataSource.h"

@interface FFCollectionViewController : FFBaseViewController<UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *dataCollectionView;
@property (nonatomic, strong) FFCollectionViewDataSource *itemDataSource;

@end
