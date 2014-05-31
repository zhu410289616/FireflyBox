//
//  FFBluetoothDeviceView.h
//  FireflyBox
//
//  Created by pig on 14-5-31.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFBluetoothDevice.h"

@interface FFBluetoothDeviceView : UIButton

@property (nonatomic, strong) FFBluetoothDevice *bluetoothDevice;

- (void)updateProgress:(float)progress;

@end
