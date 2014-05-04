//
//  FFHomeViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHomeViewController.h"
#import "FFBarButtonItem.h"
#import "FFTransferViewController.h"
#import "FFHomeCell.h"
#import "FFDataInfo.h"
#import "FFGetFileInfoTask.h"
#import "FFConcurrentQueue.h"
#import "FFFileTypeHelper.h"
#import "FFDB+All.h"

@interface FFHomeViewController ()

@end

@implementation FFHomeViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //现在功能少，先放到[工具]里面
    /*
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    */
    
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
    
    //
    _filterDataList = [[NSMutableArray alloc] init];
    
    [self loadFileInfoInHome];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [GLOBAL_APP_DELEGATE.tabBarController showFFTabBarView];
    
    if ([self shouldUpdateFileInfo]) {
        [self loadFileInfoInHome];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark public function

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    [self doAddAction];
}

- (void)doAddAction
{
    FFTransferViewController *transferController = [[FFTransferViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:transferController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark private function

- (void)testData
{
    for (int i=0; i<20; i++) {
        FFDataInfo *dataInfo = [[FFDataInfo alloc] init];
        dataInfo.dataId = i;
        dataInfo.dataName = [NSString stringWithFormat:@"FFDataInfo: %d", i];
        [self.dataList addObject:dataInfo];
    }
    [self.dataTableView reloadData];
    [self showOrHideEmptyTips];
}

- (void)loadFileInfoInHome
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *webServerPath = [NSString stringWithFormat:@"%@%@", documentsPath, TRANSFER_WEB_SERVER_DIR];
    PLog(@"webServerPath: %@", webServerPath);
    
    [self loadFileInfoWithDir:webServerPath];
}

- (void)loadFileInfoWithDir:(NSString *)tDir
{
    FFGetFileInfoTask *getFileInfoTask = [[FFGetFileInfoTask alloc] init];
    getFileInfoTask.fileDir = tDir;
    getFileInfoTask.finishBlock = ^(id task){
        FFGetFileInfoTask *getTask = task;
        NSMutableArray *fileInfos = getTask.fileInfoList;
        for (id obj in fileInfos) {
            [obj log];
            [[FFDB sharedInstance] insertDataInfo:obj];
        }
        
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:getTask.fileInfoList];
        [self.dataTableView reloadData];
        [self doneLoadingTableViewData];
        [self showOrHideEmptyTips];
    };
    [[FFConcurrentQueue sharedConcurrentQueue] addTask:getFileInfoTask];
}

- (void)searchFilter:(NSString *)keyword
{
    [_filterDataList removeAllObjects];
    for (FFDataInfo *datainfo in self.dataList) {
        if ([self searchResult:datainfo.dataName searchKeyword:keyword]) {
            [_filterDataList addObject:datainfo];
        }
    }
}

- (BOOL)shouldUpdateFileInfo
{
    BOOL shouldUpdate = [[[NSUserDefaults standardUserDefaults] objectForKey:SHOULD_UPDATE_FILE_INFO] boolValue];
    return shouldUpdate;
}

- (void)showOrHideEmptyTips
{
    if ([self.dataList count] == 0) {
        if (self.emptyTipsView == nil) {
            self.emptyTipsView = [[FFEmptyTipsView alloc] initWithFrame:CGRectMake(0, 100, GLOBAL_SCREEN_WIDTH, 100) emptyTips:@"您还没有导入文件，快点击我吧"];
            [self.emptyTipsView.emptyTipsActionButton addTarget:self action:@selector(doEmptyTipsAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.emptyTipsView];
        }
        self.emptyTipsView.hidden = NO;
        [self.view bringSubviewToFront:self.emptyTipsView];
    } else {
        self.emptyTipsView.hidden = YES;
        [self.view sendSubviewToBack:self.emptyTipsView];
    }
}

- (IBAction)doEmptyTipsAction:(id)sender
{
    [self doAddAction];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_isReloading = YES;
	[self loadFileInfoInHome];
    
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
    FFHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FFHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.footerLineView.hidden = NO;
    }
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

#pragma mark UITableViewDelegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

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
