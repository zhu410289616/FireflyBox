//
//  FFBluetoothTransferViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothTransferViewController.h"
#import "FFBluetoothDeviceView.h"
#import "FFBluetoothDevice.h"

#import "FFCAShapeCircularProgressView.h"

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
    
    float searchButtonWidth = 80.0f;
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake((GLOBAL_SCREEN_WIDTH - searchButtonWidth)/2, GLOBAL_SCREEN_HEIGHT - 64 - 30 - searchButtonWidth, searchButtonWidth, searchButtonWidth);
    self.searchButton.tag = 100;
    [self.searchButton styleWithCornerRadius:searchButtonWidth/2];
    [self.searchButton styleWithTitle:@"搜索" titleColor:[UIColor whiteColor]];
    [self.searchButton styleWithBackgroundColor:[UIColor orangeColor]];
    [self.searchButton addTarget:self action:@selector(doSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.searchButton];
    
    //
    FFCAShapeCircularProgressView *progress = [[FFCAShapeCircularProgressView alloc] initWithFrame:CGRectMake(0, 180, 100, 100)];
    [self.view addSubview:progress];
    progress.trackColor = [UIColor blackColor];
    progress.progressColor = [UIColor orangeColor];
    progress.progress = .7;
    progress.progressWidth = 10;
    
    //
    self.peripheralList = [[NSMutableArray alloc] init];
    
    //
    self.bluetoothReceiver = [[FFBluetoothReceiver alloc] init];
    [self.bluetoothReceiver start];
    
    self.bluetoothSender = [[FFBluetoothSender alloc] init];
    self.bluetoothSender.delegate = self;
//    [self.bluetoothSender start];
    
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
    
    [self.bluetoothSender stop];
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

- (void)doSearchAction:(id)sender
{
    UIButton *tempSearchButton = sender;
    if (tempSearchButton.tag == 100) {
        self.bluetoothSender.delegate = self;
        [self.bluetoothSender start];
    } else {
        self.bluetoothSender.delegate = nil;
        [self.bluetoothSender stop];
    }
}

- (void)doBluetoothDeviceAction:(id)sender
{
    FFBluetoothDeviceView *deviceView = sender;
    PLog(@"deviceView.tag: %d", deviceView.tag);
    
    CBPeripheral *peripheral = deviceView.bluetoothDevice.peripheral;
    [self.bluetoothSender connectPeripheral:peripheral];
    
}

#pragma mark FFBluetoothSenderDelegate method

- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral
{
    if (![self.peripheralList containsObject:peripheral]) {
        [self.peripheralList addObject:peripheral];
        
        FFBluetoothDevice *bluetoothDevice = [[FFBluetoothDevice alloc] init];
        bluetoothDevice.peripheral = peripheral;
        
        //生成device icon
        FFBluetoothDeviceView *peripheralView = [FFBluetoothDeviceView buttonWithType:UIButtonTypeCustom];
        peripheralView.frame = CGRectMake(80, 80, 60, 60);
        peripheralView.backgroundColor = [UIColor orangeColor];
        peripheralView.layer.cornerRadius = 30.0f;
        peripheralView.layer.masksToBounds = YES;
        peripheralView.bluetoothDevice = bluetoothDevice;
        [peripheralView addTarget:self action:@selector(doBluetoothDeviceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:peripheralView];
        
    }
}

- (void)didConnectPeripheral:(CBPeripheral *)peripheral
{
}

- (void)didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{}

- (void)didDiscoverService:(CBPeripheral *)peripheral services:(NSArray *)services error:(NSError *)error
{}

- (void)didDiscoverCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic
{
    NSData *data = [NSData dataWithString:@"hello world"];
    [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}

- (void)didUpdateValue:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic
{
    NSData *data = characteristic.value;
    NSString *receiveData = [NSString stringWithData:data];
    PLog(@"didUpdateValue receiveData: %@", receiveData);
    
    NSString *getData = [NSString stringWithFormat:@"%@", receiveData];
    NSData *writeData = [getData dataUsingEncoding:NSUTF8StringEncoding];
    [peripheral writeValue:writeData forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}

@end
