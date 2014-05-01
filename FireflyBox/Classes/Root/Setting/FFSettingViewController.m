//
//  FFSettingViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-24.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSettingViewController.h"
#import "FFDataInfo.h"
#import "FFSettingCell.h"
#import "FFBarButtonItem.h"
#import "FFTransferViewController.h"

@interface FFSettingViewController ()

@end

@implementation FFSettingViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"Setting";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

#pragma mark function

- (void)loadData
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

- (void)showOrHideEmptyTips
{
    if ([self.dataList count] == 0) {
        if (self.emptyTipsView == nil) {
            self.emptyTipsView = [[FFEmptyTipsView alloc] initWithFrame:CGRectMake(0, 100, GLOBAL_SCREEN_WIDTH, 100) emptyTips:@"您好像很忙，最近没有使用记录喔"];
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

#pragma mark UITableViewDataSource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *identifier = @"TableViewCell";
    FFSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FFSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    FFDataInfo *dataInfo = [self.dataList objectAtIndex:indexPath.row];
    cell.textLabel.text = dataInfo.dataName;
    
    return cell;
}

#pragma mark UITableViewDelegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [GLOBAL_APP_DELEGATE.tabBarController hideFFTabBarView];
    FFBarButtonItem *backBarItem = [[FFBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBarItem;
    FFTransferViewController *transferController = [[FFTransferViewController alloc] init];
    [self.navigationController pushViewController:transferController animated:YES];
}

@end
