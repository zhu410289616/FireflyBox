//
//  FFBluetoothDevice.h
//  FireflyBox
//
//  Created by pig on 14-5-31.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface FFBluetoothDevice : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;

@end
