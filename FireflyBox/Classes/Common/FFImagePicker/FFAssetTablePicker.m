//
//  FFAssetTablePicker.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAssetTablePicker.h"
#import "FFAsset.h"
#import "FFAssetCell.h"
#import "FFAssetPickerManager.h"

@interface FFAssetTablePicker ()

@property (nonatomic, assign) int columns;

@end

@implementation FFAssetTablePicker

- (id)init
{
    if (self = [super init]) {
        self.columns = 4;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FFBarButtonItem *leftBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(doLeftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    FFBarButtonItem *rightBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    NSString *groupPropertyName = (NSString *)[self.assetGroup valueForProperty:ALAssetsGroupPropertyName];
    self.navigationItem.title = [NSString stringWithFormat:@"%@", groupPropertyName];
    
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.allowsSelection = NO;
    self.dataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //
    [self loadPhotosByALAssetsGroup];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.preparePhotosThread && [self.preparePhotosThread isExecuting]) {
        [self.preparePhotosThread cancel];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark function

#pragma mark public function

- (IBAction)doLeftBarButtonItemAction:(id)sender
{
    self.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    NSArray *assets = [[FFAssetPickerManager sharedInstance] getAssets];
    [self.delegate selectedAssets:assets isUpdated:self.isUpdated];
}

#pragma mark private function

- (void)loadPhotosByALAssetsGroup
{
    self.preparePhotosThread = [[NSThread alloc] initWithTarget:self selector:@selector(preparePhotos) object:nil];
    [self.preparePhotosThread start];
}

- (void)preparePhotos
{
    @autoreleasepool {
        @try {
            __block NSUInteger lastAssetIndex = 0;
            __block NSUInteger filterIndex = 0;
            [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result) {
                    FFAsset *ffAsset = [[FFAsset alloc] initWithAsset:result];
                    ffAsset.delegate = self;
                    
                    [self.dataList addObject:ffAsset];
                    
                    if ([self.delegate respondsToSelector:@selector(isLastestSelectedAsset:)]) {
                        BOOL isLastestAsset = [self.delegate isLastestSelectedAsset:ffAsset];
                        if (isLastestAsset) {
                            lastAssetIndex = filterIndex;
                        }
                    }
                    
                    filterIndex++;
                    
                }//if
            }];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.dataTableView reloadData];
                
                // scroll to row [middle]
                long lastAssetInRow = lastAssetIndex / self.columns;
                long section = [self numberOfSectionsInTableView:self.dataTableView] - 1;
                long row = [self tableView:self.dataTableView numberOfRowsInSection:section] - 1;
                row = (lastAssetInRow < row) ? lastAssetInRow : row;
                if (section >= 0 && row >= 0) {
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:row
                                                         inSection:section];
                    [self.dataTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                    
                }
                
                [self updateSelectedAssetsLabel];
            });
        }
        @catch (NSException *exception) {
            PLog(@"preparePhotos failed...exception: %@", exception);
        }
    }
}

- (void)updateSelectedAssetsLabel
{
    if ([self.delegate respondsToSelector:@selector(shouldSelectAssetCount)]) {
        int shouldSelectAssetCount = [self.delegate shouldSelectAssetCount];
        PLog(@"shouldSelectAssetCount: %d", shouldSelectAssetCount);
    }
}

#pragma mark UITableViewDataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.columns <= 0) {
        self.columns = 4;
    }
    NSInteger numRows = ceil([self.dataList count] / (float)self.columns);
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    FFAssetCell *cell = (FFAssetCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[FFAssetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *currentCellAssets = [self assetsForIndexPath:indexPath];
    [currentCellAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FFAsset *ffAsset = obj;
        if (self.delegate && [self.delegate respondsToSelector:@selector(hadSelectedAsset:)]) {
            if ([self.delegate hadSelectedAsset:ffAsset]) {
                ffAsset.selected = YES;
            }
        }
    }];
    
    [cell setAssets:[self assetsForIndexPath:indexPath]];
    
    return cell;
}

- (NSArray *)assetsForIndexPath:(NSIndexPath *)path
{
    long index = path.row * self.columns;
    long length = MIN(self.columns, [self.dataList count] - index);
    return [self.dataList subarrayWithRange:NSMakeRange(index, length)];
}

#pragma mark UITableViewDelegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 79;
}

#pragma mark FFAssetDelegate method

- (void)assetSelected:(FFAsset *)ffAsset
{
    self.isUpdated = YES;
    if ([self.delegate respondsToSelector:@selector(updateAssetStatus:isSelected:)]) {
        [self.delegate updateAssetStatus:ffAsset isSelected:YES];
    }
}

- (BOOL)shouldSelectAsset:(FFAsset *)ffAsset
{
    NSUInteger selectedCount = [[[FFAssetPickerManager sharedInstance] getAssets] count];
    BOOL shouldSelect = YES;
    if ([self.delegate respondsToSelector:@selector(shouldSelectAsset:previousCount:)]) {
        shouldSelect = [self.delegate shouldSelectAsset:ffAsset previousCount:selectedCount];
    }
    return shouldSelect;
}

- (void)assetCanceled:(FFAsset *)ffAsset
{
    self.isUpdated = YES;
    if ([self.delegate respondsToSelector:@selector(updateAssetStatus:isSelected:)]) {
        [self.delegate updateAssetStatus:ffAsset isSelected:NO];
    }
}

@end
