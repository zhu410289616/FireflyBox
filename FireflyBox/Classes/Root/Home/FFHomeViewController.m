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

@interface FFHomeViewController ()

@end

@implementation FFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"Home";
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    self.dataTableView = [[UITableView alloc] init];
    self.dataTableView.frame = CGRectMake(0, 0, GLOBAL_SCREEN_WIDTH, GLOBAL_SCREEN_HEIGHT);
    self.dataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.dataTableView];
    
    //
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [GLOBAL_APP_DELEGATE.tabBarController showFFTabBarView];
    
    if ([self shouldUpdateFileInfo]) {
        
    }
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
    //
    self.dataList = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        FFDataInfo *dataInfo = [[FFDataInfo alloc] init];
        dataInfo.dataId = i;
        dataInfo.dataName = [NSString stringWithFormat:@"FFDataInfo: %d", i];
        [self.dataList addObject:dataInfo];
    }
    [self.dataTableView reloadData];
    [self showOrHideEmptyTips];
}

- (BOOL)shouldUpdateFileInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SHOULD_UPDATE_FILE_INFO];
}

- (void)updateFileInfoBySearchDir
{
    
}

- (void)showOrHideEmptyTips
{
    if ([self.dataList count] == 0) {
        if (_emptyTipsView == nil) {
            _emptyTipsView = [[FFEmptyTipsView alloc] initWithFrame:CGRectMake(0, 180, GLOBAL_SCREEN_WIDTH, 100) emptyTips:@"您还没有导入文件，快点击我吧"];
            [_emptyTipsView.emptyTipsActionButton addTarget:self action:@selector(doEmptyTipsAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_emptyTipsView];
        }
        _emptyTipsView.hidden = NO;
        [self.view bringSubviewToFront:_emptyTipsView];
    } else {
        _emptyTipsView.hidden = YES;
        [self.view sendSubviewToBack:_emptyTipsView];
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
