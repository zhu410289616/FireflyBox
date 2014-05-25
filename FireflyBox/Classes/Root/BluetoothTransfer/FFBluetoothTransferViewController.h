//
//  FFBluetoothTransferViewController.h
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface FFBluetoothTransferViewController : FFBaseViewController<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *cbCentralManager;
@property (nonatomic, strong) NSMutableArray *peripheralList;

@end
