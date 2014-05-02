//
//  FFFileViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-30.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFFileViewController.h"
#import "FFGetFileInfoTask.h"
#import "FFConcurrentQueue.h"
#import "FFFileInfoCell.h"
#import "FFFileTypeHelper.h"

@interface FFFileViewController ()

@end

@implementation FFFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0.0f, 0.0f, GLOBAL_SCREEN_WIDTH, 44.0f);
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDC.searchResultsDelegate = self;
    _searchDC.searchResultsDataSource = self;
    _searchDC.searchResultsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.dataTableView.frame = CGRectMake(0, 44, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT - 44);
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
    _filterDataList = [[NSMutableArray alloc] init];
    
    [self loadFileInfoWithDir:_fileDir];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark function

- (void)loadFileInfoWithDir:(NSString *)tDir
{
    FFGetFileInfoTask *getFileInfoTask = [[FFGetFileInfoTask alloc] init];
    getFileInfoTask.fileDir = tDir;
    getFileInfoTask.finishBlock = ^(id task){
        FFGetFileInfoTask *getTask = task;
        NSMutableArray *fileInfos = getTask.fileInfoList;
        for (id obj in fileInfos) {
            [obj log];
        }
        
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:getTask.fileInfoList];
        [self.dataTableView reloadData];
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
