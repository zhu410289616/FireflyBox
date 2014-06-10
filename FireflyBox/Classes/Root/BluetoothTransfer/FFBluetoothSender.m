//
//  FFBluetoothSender.m
//  FireflyBox
//
//  Created by pig on 14-5-28.
//  Copyright (c) 2014年 pig. All rights reserved.
//

#import "FFBluetoothSender.h"
#import "FFBluetoothConfig.h"

@implementation FFBluetoothSender

- (void)start
{
    /**
     *  初始化后会调用代理CBCentralManagerDelegate 的 
     *  - (void)centralManagerDidUpdateState:(CBCentralManager *)central
     */
    self.cbCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (BOOL)connectPeripheral:(CBPeripheral *)peripheral
{
    /**
     *  发现设备后即可连接该设备 调用完该方法后会调用代理CBCentralManagerDelegate的
     *  - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral表示连接上了设别
     */
    /**
     *  如果不能连接会调用 - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
     */
    [self.cbCentralManager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
    return YES;
}

- (void)stop
{
    if (self.cbCentralManager.state == CBCentralManagerStatePoweredOn) {
        [self.cbCentralManager stopScan];
    }
}

#pragma mark CBCentralManagerDelegate method

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    /**
     *  判断状态开始扫瞄周围设备 第一个参数为空则会扫瞄所有的可连接设备
     *  你可以指定一个CBUUID对象 从而只扫瞄注册用指定服务的设备
     *
     *  scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
     *  - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI方法
     */
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        {
            FFLog(@"CBCentralManagerStatePoweredOn...");
            //实际测试发现，如果用特定的UUID传参根本找不到任何设备
            [self.cbCentralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
        }
            break;
            
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (peripheral) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDiscoverPeripheral:)]) {
            [self.delegate didDiscoverPeripheral:peripheral];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    FFLog(@"centralManager: %@, didConnectPeripheral: %@", central, peripheral);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didConnectPeripheral:)]) {
        [self.delegate didConnectPeripheral:peripheral];
    }
    
    /**
     *  此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
     *  - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
     */
    peripheral.delegate = self;
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kTransferServiceUUID]]];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    FFLog(@"centralManager: %@, didFailToConnectPeripheral: %@, error: %@", central, peripheral, error);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailToConnectPeripheral:error:)]) {
        [self.delegate didFailToConnectPeripheral:peripheral error:error];
    }
}

#pragma mark CBPeripheralDelegate method

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDiscoverService:services:error:)]) {
        [self.delegate didDiscoverService:peripheral services:peripheral.services error:error];
    }
    if (error) {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
    } else {
        /**
         *  在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
         */
        /**
         *  该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
         *  - (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
         */
        for (CBService *service in peripheral.services) {
            FFLog(@"service.UUID: %@", service.UUID);
            if ([service.UUID isEqual:[CBUUID UUIDWithString:kTransferServiceUUID]]) {
                [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kTransferCharacteristicUUID]] forService:service];
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    FFLog(@"peripheral: %@, didDiscoverCharacteristicsForService: %@, error: %@", peripheral, service, error);
    if (error) {
        //
    } else {
        /**
         *  在这个方法中我们要找到我们所需的服务的特性 然后调用setNotifyValue方法告知我们要监测这个服务特性的状态变化
         */
        /**
         *  当setNotifyValue方法调用后调用代理CBPeripheralDelegate的
         *  - (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
         */
        for (CBCharacteristic *characteristic in service.characteristics) {
            FFLog(@"characteristic.UUID: %@", characteristic.UUID);
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kTransferCharacteristicUUID]]) {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                
                FFLog(@"characteristic.properties: %d", characteristic.properties);
                if (self.delegate && [self.delegate respondsToSelector:@selector(didDiscoverCharacteristic:characteristic:)]) {
                    [self.delegate didDiscoverCharacteristic:peripheral characteristic:characteristic];
                }
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        //
    } else {
        /**
         *  调用下面的方法后 会调用到代理的
         *  - (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
         */
        [peripheral readValueForCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    FFLog(@"peripheral: %@, didUpdateValueForCharacteristic: %@, error: %@", peripheral, characteristic, error);
    if (error) {
        //
    } else {
        
        NSData *data = characteristic.value;
        NSString *receiveData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        FFLog(@"peripheralManager receiveData: %@", receiveData);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didUpdateValue:characteristic:)]) {
            [self.delegate didUpdateValue:peripheral characteristic:characteristic];
        }
    }
}

@end
