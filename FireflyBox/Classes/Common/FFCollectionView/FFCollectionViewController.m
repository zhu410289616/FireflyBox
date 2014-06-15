//
//  FFCollectionViewController.m
//  FireflyBox
//
//  Created by pig on 14-6-15.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFCollectionViewController.h"
#import "FFCollectionViewCell.h"

@interface FFCollectionViewController ()

@end

@implementation FFCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  代码初始化
     *  需要用以下的方式处理，否则init会崩溃
     */
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0f;//cell间的间隔
    //1. 设置collectionViewLayout
    self.dataCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.dataCollectionView.delegate = self;
    self.dataCollectionView.pagingEnabled = YES;
    [self.view addSubview:self.dataCollectionView];
    
    FFCollectionViewCellConfigureBlock configureCell = ^(FFCollectionViewCell *cell, id item, NSIndexPath *indexPath) {
        [cell configureCellWithItem:item indexPath:indexPath];
    };
    
    static NSString *CellIdentifier = @"FFCollectionViewCell";
    self.itemDataSource = [[FFCollectionViewDataSource alloc] initWithItems:nil cellIdentifier:CellIdentifier configureCellBlock:configureCell];
    self.dataCollectionView.dataSource = self.itemDataSource;
    //2. 注册cell类型
    [self.dataCollectionView registerClass:[FFCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation
#pragma mark -

// changes in this method will be included with view controller's animation block
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.dataCollectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - UICollectionViewDelegate
#pragma mark -

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.dataCollectionView.frame), CGRectGetHeight(self.dataCollectionView.frame));
}

@end
