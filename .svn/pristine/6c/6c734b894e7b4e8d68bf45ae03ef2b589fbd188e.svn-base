//
//  BluetoothManager+Category.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/11.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "BluetoothManager.h"

@interface BluetoothManager (Category)

/**
 *  锁铃
 */
- (void)blockingWithIndex:(DeviceTempIndex)index;

/**
 *  解锁
 */
- (void)deblockingWithIndex:(DeviceTempIndex)index;

//设置手机当前温度类型至硬件
-(void)setCurrentTempType;

//设置温度类型为摄氏度
-(void)setTempTypeC;

//设置温度类型为华摄氏度
-(void)setTempTypeF;

//蓝牙设备连接成功
-(void)didConnectPeripheral;

//反馈给设备
-(void)facebackOrder;

//4个探头温度更新
-(void)fourDeviceTempUpdate:(void(^)(NSInteger number, CGFloat temp))block;

//单探头环境温度更新
-(void)singleDeviceNormalTempUpdate:(void(^)(CGFloat temp))block;

//设置温度
-(void)sendMaxTemp:(CGFloat)temp number:(NSInteger)number;

//接收消息
-(void)receiveWithPeripheral:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic error:(NSError *)error;

//蓝牙断开处理
-(void)blueDisconnectHandler;

@end
