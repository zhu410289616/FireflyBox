//
//  FFBluetoothReceiver.m
//  FireflyBox
//
//  Created by pig on 14-5-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothReceiver.h"
#import "FFBluetoothConfig.h"

@implementation FFBluetoothReceiver

- (void)start
{
    /**
     *  初始化后会直接调用代理的
     *  - (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
     */
    self.cbPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (void)stop
{
    [self.cbPeripheralManager stopAdvertising];
}

#pragma mark CBPeripheralManagerDelegate method

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
        {
            PLog(@"CBPeripheralManagerStatePoweredOn...");
            CBUUID *characteristicUUID = [CBUUID UUIDWithString:kTransferCharacteristicUUID];
            self.cbMutableCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyNotify | CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
            
            CBUUID *serviceUUID = [CBUUID UUIDWithString:kTransferServiceUUID];
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

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    if ([request.characteristic.UUID isEqual:self.cbMutableCharacteristic.UUID]) {
        
        request.value = [@"ok" dataUsingEncoding:NSUTF8StringEncoding];
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
        
//        if (request.offset > self.cbMutableCharacteristic.value.length) {
//            [peripheral respondToRequest:request withResult:CBATTErrorInvalidOffset];
//        } else {
//            request.value = [self.cbMutableCharacteristic.value subdataWithRange:NSMakeRange(request.offset, self.cbMutableCharacteristic.value.length - request.offset)];
//            [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
//        }
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    for (CBATTRequest *request in requests) {
        if ([request.characteristic.UUID isEqual:self.cbMutableCharacteristic.UUID]) {
            NSData *data = request.value;
            NSString *receiveData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            PLog(@"peripheralManager receiveData: %@", receiveData);
            
            request.value = [[NSString stringWithFormat:@"receive %@", receiveData] dataUsingEncoding:NSUTF8StringEncoding];
            [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
        }
    }
}

@end
