//
//  FFBluetoothReceiver.m
//  FireflyBox
//
//  Created by pig on 14-5-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothReceiver.h"

static NSString *const kCharacteristicUUID = @"CCE62C0F-1098-4CD0-ADFA-C8FC7EA2EE90";
static NSString *const kServiceUUID = @"50BD367B-6B17-4E81-B6E9-F62016F26E7B";

@implementation FFBluetoothReceiver

- (void)start
{
    /**
     *  初始化后会直接调用代理的
     *  - (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
     */
    self.cbPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

#pragma mark CBPeripheralManagerDelegate method

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
        {
            PLog(@"CBPeripheralManagerStatePoweredOn...");
            CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
            self.cbMutableCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
            
            CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
            self.cbMutableService = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
            [self.cbMutableService setCharacteristics:@[self.cbMutableCharacteristic]];
            
            /**
             *  添加后就会调用代理的
             *  - (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)erro
             */
            [self.cbPeripheralManager addService:self.cbMutableService];
        }
            break;
        case CBPeripheralManagerStatePoweredOff:
        {
            PLog(@"CBPeripheralManagerStatePoweredOff...");
        }
            break;
            
        default:
            break;
    }
}

/**
 *  添加服务后可以在此向外界发出通告
 *
 *  调用完这个方法后会调用代理的
 *  (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
 *
 *  @param peripheral <#peripheral description#>
 *  @param service    <#service description#>
 *  @param error      <#error description#>
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (!error) {
//        [self.cbPeripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey:@"Service", CBAdvertisementDataServiceUUIDsKey:[CBUUID UUIDWithString:kServiceUUID]}];
        [self.cbPeripheralManager startAdvertising:nil];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    PLog(@"peripheralManagerDidStartAdvertising: %@, error: %@", peripheral, error);
}

@end
