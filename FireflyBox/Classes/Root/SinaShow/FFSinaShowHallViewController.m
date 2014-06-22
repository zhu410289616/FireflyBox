//
//  FFSinaShowHallViewController.m
//  FireflyBox
//
//  Created by pig on 14-6-22.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFSinaShowHallViewController.h"

#import "FFGetSinaShowRoomListRunnable.h"
#import "FFHttpTask.h"

@interface FFSinaShowHallViewController ()

@end

@implementation FFSinaShowHallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    //
    FFGetSinaShowRoomListRunnable *runnable = [[FFGetSinaShowRoomListRunnable alloc] init];
    FFHttpTask *httpTask = [[FFHttpTask alloc] initWithRunnable:runnable];
    httpTask.finishBlock = ^(id tTask){
        FFHttpTask *task = tTask;
        FFLOG_FORMAT(@"task.runnable.dicResult: %@", task.runnable.dicResult);
    };
    httpTask.errorBlock = ^(id task, NSError *error){
    };
    [httpTask start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doRightBarButtonItemAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
