//
//  FFBluetoothReceiver.h
//  FireflyBox
//
//  Created by pig on 14-5-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/**
 *  服务端（也叫周边设备吧。。脑残的翻译）
 */
@interface FFBluetoothReceiver : NSObject<CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *cbPeripheralManager;
@property (nonatomic, strong) CBMutableCharacteristic *cbMutableCharacteristic;
@property (nonatomic, strong) CBMutableService *cbMutableService;

- (void)start;

@end
