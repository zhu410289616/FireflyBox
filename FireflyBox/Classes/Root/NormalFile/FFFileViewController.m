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
#import "NSObject+FireFly.h"
#import "FFFileInfoCell.h"
#import "FFFileReaderViewController.h"

@interface FFFileViewController ()

@end

@implementation FFFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
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

#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
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
    
    FFDataInfo *dataInfo = [self.dataList objectAtIndex:indexPath.row];
    [cell updateViewWithContent:dataInfo];
    
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
    if (tempDataInfo.dataType == FFDataTypeDirectory) {
        FFFileViewController *fileController = [[FFFileViewController alloc] init];
        fileController.title = tempDataInfo.dataName;
        fileController.fileDir = tempDataInfo.dataPath;
        [self.navigationController pushViewController:fileController animated:YES];
    } else {
        FFFileReaderViewController *fileReaderController = [[FFFileReaderViewController alloc] init];
        fileReaderController.title = tempDataInfo.dataName;
        fileReaderController.filePath = tempDataInfo.dataPath;
        [self.navigationController pushViewController:fileReaderController animated:YES];
    }
}

@end
