//
//  FFBluetoothTransferViewController.m
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothTransferViewController.h"
#import "FFBarButtonItem.h"

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
    
    self.peripheralList = [[NSMutableArray alloc] init];
    
    self.cbCentralManager = [[CBCentralManager alloc] init];
    self.cbCentralManager.delegate = self;
    
    NSDictionary *dicOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@FALSE};
    [self.cbCentralManager scanForPeripheralsWithServices:nil options:dicOptions];
    
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

#pragma mark CBCentralManagerDelegate method

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    PLog(@"central.description: %@", central.description);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    PLog(@"advertisementData: %@", advertisementData);
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    PLog(@"peripheral.description: %@", peripheral.description);
}

#pragma mark CBPeripheralDelegate method

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}

@end
