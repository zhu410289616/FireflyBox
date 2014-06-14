//
//  FFAlbumTablePicker.m
//  FireflyBox
//
//  Created by pig on 14-6-8.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFAlbumTablePicker.h"
#import "FFAssetTablePicker.h"
#import "FFAssetPickerManager.h"

@interface FFAlbumTablePicker ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation FFAlbumTablePicker

- (id)init
{
    if (self = [super init]) {
        [[FFAssetPickerManager sharedInstance] removeAllAssets];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FFBarButtonItem *rightBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.navigationItem.title = @"Loading...";
    
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.dataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self loadAssetsLibrary];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark function

#pragma mark public function

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    NSArray *assets = [[FFAssetPickerManager sharedInstance] getAssets];
    if (self.isUpdated && [assets count] > 0) {
        [self doneImagePicker:assets];
    } else {
        [self cancelImagePicker];
    }
}

- (void)cancelImagePicker
{
    self.delegate = nil;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneImagePicker:(NSArray *)assets
{
    [self.delegate selectedAssets:assets isUpdated:self.isUpdated];
    self.delegate = nil;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark private function

- (void)loadAssetsLibrary
{
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            // Group enumerator Block
            void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
            {
                if (group) {
                    [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                    NSInteger gCount = [group numberOfAssets];
                    if (gCount > 0) {
                        [self.dataList addObject:group];
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self reloadTableView];
                    });
                }
                
            };
            
            // Group Enumerator Failure Block
            void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert_permission_photos_title", @"Unable To Access Photos") message:NSLocalizedString(@"alert_permission_photos", @"Please allow Coco to access your photos. To enable photos, go to: Settings > Privacy > Photos.") delegate:self cancelButtonTitle:NSLocalizedString(@"common.ok", @"OK") otherButtonTitles:nil];
                [alert show];
            };
            
            // Enumerate Albums
            [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos | ALAssetsGroupPhotoStream
                                        usingBlock:assetGroupEnumerator
                                      failureBlock:assetGroupEnumberatorFailure];
        }
    });
}

- (void)reloadTableView
{
	[self.dataTableView reloadData];
    self.title = @"Photos";
}

#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get count
    ALAssetsGroup *g = (ALAssetsGroup*)[self.dataList objectAtIndex:indexPath.row];
    [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [g numberOfAssets];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[self.dataList objectAtIndex:indexPath.row] posterImage]]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
    return cell;
}

#pragma mark UITableViewDelegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FFAssetTablePicker *assetPicker = [[FFAssetTablePicker alloc] init];
    assetPicker.delegate = self;
    assetPicker.assetGroup = [self.dataList objectAtIndex:indexPath.row];
    [assetPicker.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    [self.navigationController pushViewController:assetPicker animated:YES];
}

#pragma mark FFAssetSelectionDelegate method

- (void)selectedAssets:(NSArray *)ffAssets isUpdated:(BOOL)isUpdated
{
    self.isUpdated = self.isUpdated ? self.isUpdated : isUpdated;
    [self doRightBarButtonItemAction:nil];
}

- (BOOL)hadSelectedAsset:(FFAsset *)ffAsset
{
    FFAsset *tempFFAsset = [[FFAssetPickerManager sharedInstance] isExists:ffAsset];
    if (tempFFAsset) {
        return YES;
    }
    return NO;
}

- (void)updateAssetStatus:(FFAsset *)ffAsset isSelected:(BOOL)isSelected
{
    if (isSelected) {
        FFAssetPickerManager *assetPickerManager = [FFAssetPickerManager sharedInstance];
        [assetPickerManager addAsset:ffAsset];
    } else {
        [[FFAssetPickerManager sharedInstance] removeAsset:ffAsset];
    }
}

- (BOOL)shouldSelectAsset:(FFAsset *)ffAsset previousCount:(NSUInteger)previousCount
{
    return YES;
}

- (BOOL)isLastestSelectedAsset:(FFAsset *)ffAsset
{
    return [[FFAssetPickerManager sharedInstance] isLastAsset:ffAsset];
}

@end
