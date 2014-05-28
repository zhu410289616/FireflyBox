//
//  FFBluetoothTransferViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothTransferViewController.h"
#import "FFBarButtonItem.h"

static NSString *const kCharacteristicUUID = @"CCE62C0F-1098-4CD0-ADFA-C8FC7EA2EE90";

static NSString *const kServiceUUID = @"50BD367B-6B17-4E81-B6E9-F62016F26E7B";

@interface FFBluetoothTransferViewController ()

@end

@implementation FFBluetoothTransferViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"蓝牙传输";
    
    FFBarButtonItem *tempBarButtonItem = [[FFBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    
    //
    self.bluetoothReceiver = [[FFBluetoothReceiver alloc] init];
    [self.bluetoothReceiver start];
    
    self.bluetoothSender = [[FFBluetoothSender alloc] init];
    [self.bluetoothSender start];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    GLOBAL_APP.idleTimerDisabled = YES;//不自动锁屏
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    GLOBAL_APP.idleTimerDisabled = NO;//自动锁屏
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doRightBarButtonItemAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark function

#pragma mark delegate method


@end
