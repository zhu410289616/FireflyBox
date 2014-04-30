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
#import "FFUpdateFileInfoTask.h"
#import "FFConcurrentQueue.h"
#import "FFDB+All.h"

#import "PlayerViewController.h"
#import "Track+Provider.h"

@interface FFHomeViewController ()

@end

@implementation FFHomeViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"Home";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    //
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.view addSubview:self.dataTableView];
    
    //
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    @synchronized(self)
    {
        if ([self shouldUpdateFileInfo]) {
            [[NSUserDefaults standardUserDefaults] setValue:@NO forKey:SHOULD_UPDATE_FILE_INFO];
            [self updateFileInfoBySearchDir];
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [GLOBAL_APP_DELEGATE.tabBarController showFFTabBarView];
    
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

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    [self doEmptyTipsAction:sender];
}

- (void)loadData
{
    for (int i=0; i<20; i++) {
        FFDataInfo *dataInfo = [[FFDataInfo alloc] init];
        dataInfo.dataId = i;
        dataInfo.dataName = [NSString stringWithFormat:@"FFDataInfo: %d", i];
        [self.dataList addObject:dataInfo];
    }
    
    NSMutableArray *tempDataInfoList = [[FFDB sharedInstance] selectDataInfo];
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:tempDataInfoList];
    
    [self.dataTableView reloadData];
    [self showOrHideEmptyTips];
}

- (BOOL)shouldUpdateFileInfo
{
    BOOL shouldUpdate = [[[NSUserDefaults standardUserDefaults] objectForKey:SHOULD_UPDATE_FILE_INFO] boolValue];
    return shouldUpdate;
}

- (void)updateFileInfoBySearchDir
{
    FFUpdateFileInfoTask *updateFileInfoTask = [[FFUpdateFileInfoTask alloc] init];
    updateFileInfoTask.finishBlock = ^(id task){
        FFUpdateFileInfoTask *updateTask = task;
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:updateTask.dataInfoList];
        [self.dataTableView reloadData];
    };
    [[FFConcurrentQueue sharedConcurrentQueue] addTask:updateFileInfoTask];
}

- (void)showOrHideEmptyTips
{
    if ([self.dataList count] == 0) {
        if (self.emptyTipsView == nil) {
            self.emptyTipsView = [[FFEmptyTipsView alloc] initWithFrame:CGRectMake(0, 180, GLOBAL_SCREEN_WIDTH, 100) emptyTips:@"您还没有导入文件，快点击我吧"];
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
    FFTransferViewController *transferController = [[FFTransferViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:transferController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identifier = @"TableViewCell";
    FFHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FFHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.headerLineView.hidden = YES;
    cell.footerLineView.hidden = NO;
    if (indexPath.row == 0) {
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
        FFHomeViewController *homeController = [[FFHomeViewController alloc] init];
        homeController.title = tempDataInfo.dataName;
        [self.navigationController pushViewController:homeController animated:YES];
    } else {
        PlayerViewController *playerController = [[PlayerViewController alloc] init];
        if ((tempNum++) % 2) {
            [playerController setTitle:@"Remote Music ♫"];
            [playerController setTracks:[Track remoteTracks]];
        } else {
            [playerController setTitle:@"Local Music Library ♫"];
            [playerController setTracks:[Track musicLibraryTracks]];
        }
        [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
        [self.navigationController pushViewController:playerController animated:YES];
    }
}

static int tempNum = 1;

@end
