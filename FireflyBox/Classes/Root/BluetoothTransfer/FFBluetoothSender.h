//
//  FFBluetoothSender.h
//  FireflyBox
//
//  Created by pig on 14-5-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class FFBluetoothSender;

@protocol FFBluetoothSenderDelegate <NSObject>

- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral;
- (void)didConnectPeripheral:(CBPeripheral *)peripheral;
- (void)didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
- (void)didDiscoverService:(CBPeripheral *)peripheral services:(NSArray *)services error:(NSError *)error;
- (void)didDiscoverCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic;
- (void)didUpdateValue:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic;

@end

/**
 *  客户端（也叫中心设备吧）
 */
@interface FFBluetoothSender : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *cbCentralManager;
@property (nonatomic, strong) NSMutableData *mutableData;

@property (nonatomic, weak) id<FFBluetoothSenderDelegate> delegate;

- (void)start;
- (BOOL)connectPeripheral:(CBPeripheral *)peripheral;
- (void)stop;

@end
