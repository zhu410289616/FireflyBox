//
//  FFBluetoothTransferViewController.h
//  FireflyBox
//
//  Created by pig on 14-5-25.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBaseViewController.h"
#import "FFBluetoothReceiver.h"
#import "FFBluetoothSender.h"

@interface FFBluetoothTransferViewController : FFBaseViewController

@property (nonatomic, strong) FFBluetoothReceiver *bluetoothReceiver;
@property (nonatomic, strong) FFBluetoothSender *bluetoothSender;

@end
