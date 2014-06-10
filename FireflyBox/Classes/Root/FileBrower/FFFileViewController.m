//
//  FFFileViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileViewController.h"
#import "FFDB+All.h"
#import "FFBoxTask.h"

#import "FFGetFileInfoTask.h"
#import "FFConcurrentQueue.h"
#import "FFFileInfoCell.h"
#import "FFFileTypeHelper.h"
#import "FFDeleteFileTask.h"

@interface FFFileViewController ()

@end

@implementation FFFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dataTableView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.dataTableView.bounds.size.height, self.view.frame.size.width, self.dataTableView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [self.dataTableView addSubview:_refreshHeaderView];
    
    UIView *tableHeaderView = [[UIView alloc] init];
    tableHeaderView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, 44.0f);
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0.0f, 0.0f, GLOBAL_SCREEN_WIDTH, 44.0f);
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.delegate = self;
    [tableHeaderView addSubview:_searchBar];
    self.dataTableView.tableHeaderView = tableHeaderView;
    
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDC.searchResultsDelegate = self;
    _searchDC.searchResultsDataSource = self;
    _searchDC.searchResultsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _filterDataList = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [GLOBAL_APP_DELEGATE.tabBarController showFFTabBarView];
    
    //refrush
    if ([self shouldUpdateFileInfo]) {
        [self loadFileInfoWithDir:_fileDir parentDataId:_parentDataId];
    } else {
        [self loadFileInfo];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark function

- (void)loadFileInfo
{
    [self loadFileInfoWithParentDataId:_parentDataId];
    [self loadFileInfoWithDir:_fileDir parentDataId:_parentDataId];
}

- (void)loadFileInfoWithParentDataId:(long)tParentDataId
{
    NSMutableArray *dataInfoList = [[FFDB sharedInstance] selectDataInfoWithParentDataId:_parentDataId];
    [dataInfoList sortDataInfoList];
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:dataInfoList];
    [self loadFileInfoFinished:LoadFileInfoSourceDatabase];
}

- (void)loadFileInfoWithDir:(NSString *)tDir parentDataId:(long)tParentDataId
{
    FFGetFileInfoTask *getFileInfoTask = [[FFGetFileInfoTask alloc] init];
    getFileInfoTask.parentDataId = tParentDataId;
    getFileInfoTask.fileDir = tDir;
    getFileInfoTask.finishBlock = ^(id task){
        
        [[FFDB sharedInstance] deleteDataInfoWithParentDataId:tParentDataId];
        
        FFGetFileInfoTask *getTask = task;
        NSMutableArray *fileInfos = getTask.fileInfoList;
        for (id obj in fileInfos) {
            [obj log];
            [[FFDB sharedInstance] insertDataInfo:obj];
        }
        
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:getTask.fileInfoList];
        [self loadFileInfoFinished:LoadFileInfoSourceFileSystem];
    };
    [getFileInfoTask start];
}

/**
 * 刷新文件列表信息后的任务回调
 */
- (void)loadFileInfoFinished:(LoadFileInfoSource)tSource
{
    FFLog(@"loadFileInfoFinished...%d", tSource);
    [self.dataTableView reloadData];
    [self doneLoadingTableViewData];
    [self showOrHideEmptyTips];
}

/**
 * 读取是否需要刷新的标志
 */
- (BOOL)shouldUpdateFileInfo
{
    BOOL shouldUpdate = [[[NSUserDefaults standardUserDefaults] objectForKey:SHOULD_UPDATE_FILE_INFO] boolValue];
    //读取后重置为否
    [[NSUserDefaults standardUserDefaults] setValue:@NO forKey:SHOULD_UPDATE_FILE_INFO];
    return shouldUpdate;
}

/**
 * 关键字搜索
 */
- (void)searchFilter:(NSString *)keyword
{
    [_filterDataList removeAllObjects];
    for (FFDataInfo *datainfo in self.dataList) {
        if ([self searchResult:datainfo.dataName searchKeyword:keyword]) {
            [_filterDataList addObject:datainfo];
        }
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_isReloading = YES;
	[self loadFileInfoWithDir:_fileDir parentDataId:_parentDataId];
    
}

- (void)doneLoadingTableViewData
{
	//  model should call this when its done loading
	_isReloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.dataTableView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _isReloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark UISearchBarDelegate method

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchFilter:_searchBar.text];
}

#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.dataTableView) {
        return [self.dataList count];
    } else {
        return [_filterDataList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identifier = @"TableViewCell";
    FFFileInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FFFileInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.footerLineView.hidden = NO;
    }
    cell.headerLineView.hidden = YES;
    if (indexPath.row == 0 && cell.headerLineView.hidden) {
        cell.headerLineView.hidden = NO;
    }
    
    if (tableView == self.dataTableView) {
        FFDataInfo *dataInfo = [self.dataList objectAtIndex:indexPath.row];
        [cell updateViewWithContent:dataInfo];
    } else {
        FFDataInfo *dataInfo = [self.filterDataList objectAtIndex:indexPath.row];
        [cell updateViewWithContent:dataInfo];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFDataInfo *dataInfo = nil;
    if (tableView == self.dataTableView) {
        dataInfo = [self.dataList objectAtIndex:indexPath.row];
        [self.dataList removeObject:dataInfo];
    } else {
        dataInfo = [self.filterDataList objectAtIndex:indexPath.row];
        [self.filterDataList removeObject:dataInfo];
    }
    FFDeleteFileTask *deleteFileTask = [[FFDeleteFileTask alloc] init];
    deleteFileTask.filePath = dataInfo.dataPath;
    deleteFileTask.finishBlock = ^(id task) {
        [[FFDB sharedInstance] deleteDataInfoWithDataId:dataInfo.dataId];
        [[FFDB sharedInstance] deleteDataInfoWithParentDataId:dataInfo.dataId];
    };
    [deleteFileTask start];
    
    [tableView reloadData];
}

#pragma mark UITableViewDelegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

/**
 * 根据选择cell中的文件信息，做对应的跳转动作
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FFDataInfo *tempDataInfo = [self.dataList objectAtIndex:indexPath.row];
    
    FFFileTypeHelper *fileTypeHelper = [[FFFileTypeHelper alloc] init];
    fileTypeHelper.viewController = self;
    fileTypeHelper.dataInfoList = self.dataList;
    fileTypeHelper.dataInfo = tempDataInfo;
    [fileTypeHelper doActionWithFileType];
    
}

@end
