//
//  FFBluetoothSender.h
//  FireflyBox
//
//  Created by pig on 14-5-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/**
 *  客户端（也叫中心设备吧）
 */
@interface FFBluetoothSender : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *cbCentralManager;
@property (nonatomic, strong) NSMutableData *mutableData;
@property (nonatomic, strong) CBPeripheral *cbPeripheral;

- (void)start;

@end
