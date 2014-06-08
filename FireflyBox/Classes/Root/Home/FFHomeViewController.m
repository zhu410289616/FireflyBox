//
//  FFHomeViewController.m
//  FireflyBox
//
//  Created by pig on 14-4-20.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFHomeViewController.h"
#import "FFTransferViewController.h"
#import "FFDataInfo.h"

#import "FFGetDailyRunnable.h"
#import "FFHttpTask.h"

@interface FFHomeViewController ()

@end

@implementation FFHomeViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"首页";
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *webServerPath = [NSString stringWithFormat:@"%@%@", documentsPath, TRANSFER_WEB_SERVER_DIR];
        PLog(@"webServerPath: %@", webServerPath);
        self.fileDir = webServerPath;
        self.parentDataId = TOP_PARENT_DATA_ID;
        
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
    
    FFGetDailyRunnable *runnable = [[FFGetDailyRunnable alloc] init];
    FFHttpTask *httpTask = [[FFHttpTask alloc] initWithRunnable:runnable];
    httpTask.finishBlock = ^(id tTask){
        FFHttpTask *task = tTask;
        PLog(@"task.runnable.dicResult: %@", task.runnable.dicResult);
    };
    httpTask.errorBlock = ^(id task, NSError *error){
    };
//    [httpTask start];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (void)showOrHideEmptyTips
{
    if ([self.dataList count] == 0) {
        if (self.emptyTipsView == nil) {
            self.emptyTipsView = [[FFEmptyTipsView alloc] initWithFrame:CGRectMake(0, 100, GLOBAL_SCREEN_WIDTH, 100) emptyTips:@"您还没有导入文件，快点击我吧" rangeColor:[UIColor blueColor] range:NSMakeRange(10, 3)];
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

@end
