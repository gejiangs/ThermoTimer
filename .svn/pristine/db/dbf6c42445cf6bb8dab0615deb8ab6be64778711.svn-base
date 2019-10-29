//
//  BluetoothManager.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/10.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface BluetoothManager : NSObject

@property (nonatomic, strong)   CBPeripheral *peripheral;    //当前连接蓝牙设备
@property (nonatomic, strong)   NSMutableArray *peripheralArray;            //扫描设备列表
@property (nonatomic, copy)     void(^blueConnectBlock)(BOOL success);                        //蓝牙连接block
@property (nonatomic, copy)     void(^fourDeviceTempBlock)(NSInteger number, CGFloat temp);   //4个探头的设备温度更新
@property (nonatomic, copy)     void(^singleDeviceNormalTempBlock)(CGFloat temp);             //单一探头的环境温度更新
@property (nonatomic, copy)     void(^updateDeviceBatteryBlock)(BOOL normal);                 //更新电池设备信息(是否正常)
@property (nonatomic, copy)     void(^autoDisconnectBlock)();                                  //蓝牙自动断开



+(BluetoothManager *)shareManager;

-(void)initCentral;

/**
 *  系统是否支持蓝牙
 *
 *  @return 返回系统是否支持蓝牙
 */
-(BOOL)supportHardware;


/**
 *  开始扫描蓝牙设备
 */
-(void)startScan;

/**
 *  开始扫描蓝牙设备
 *
 *  @param block 扫描到的设备列表
 */
-(void)startScanBlock:(void (^)(NSArray *peripheralArray))block finally:(void(^)())finally;

/**
 *  停止扫描蓝牙设备
 */
-(void)stopScan;


/**
 *  连接蓝牙设备
 *
 *  @param peripheral 蓝牙设备对象
 *  @param block 蓝牙连接是否成功
 */
-(void)connect:(CBPeripheral *)peripheral block:(void(^)(BOOL success))block;

//断开蓝牙连接
-(void)disConnect;


//更新rssi信息
-(void)updateDeviceRssiBlock:(void(^)(int rssi))block;

//更新设备电池信息
-(void)updateDeviceBatteryBlock:(void (^)(BOOL normal))block;

//自动断开
-(void)autoDisconnect:(void(^)())block;

@end
