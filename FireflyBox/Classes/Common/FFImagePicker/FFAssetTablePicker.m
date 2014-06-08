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
    self.bottomTipView = [[UIView alloc] init];
    self.bottomTipView.frame = CGRectMake(0, GLOBAL_SCREEN_HEIGHT - 64 - 44, GLOBAL_SCREEN_WIDTH, 44);
    self.bottomTipView.backgroundColor = [UIColor colorWithHex:0xffffff alpha:0.9];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, 0.5f);
    lineView.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
    [self.bottomTipView addSubview:lineView];
    
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, 44);
    self.tipLabel.textColor = [UIColor colorWithHex:0x157dfb];
    self.tipLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomTipView addSubview:self.tipLabel];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(GLOBAL_SCREEN_WIDTH/2-10, 12, 20, 20);
    self.indicatorView.hidesWhenStopped = YES;
    [self.bottomTipView addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    [self.view addSubview:self.bottomTipView];
    
    UIView *tableFooterView = [[UIView alloc] init];
    tableFooterView.frame = self.bottomTipView.bounds;
    tableFooterView.backgroundColor = [UIColor clearColor];
    self.dataTableView.tableFooterView = tableFooterView;
    
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
                    [self.dataTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    
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
    [self.indicatorView stopAnimating];
    if ([self.delegate respondsToSelector:@selector(shouldSelectAssetCount)]) {
        int shouldSelectAssetCount = [self.delegate shouldSelectAssetCount];
        self.tipLabel.text = [NSString stringWithFormat:@"%d / %d", [self totalSelectedAssets], shouldSelectAssetCount];
    } else {
        self.tipLabel.text = [NSString stringWithFormat:@"已选择 %d 张", [self totalSelectedAssets]];
    }
}

- (int)totalSelectedAssets
{
    return [[[FFAssetPickerManager sharedInstance] getAssets] count];
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
    [self updateSelectedAssetsLabel];
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
    [self updateSelectedAssetsLabel];
}

@end
