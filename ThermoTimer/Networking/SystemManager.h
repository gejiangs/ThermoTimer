//
//  SystemManager.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/13.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DeviceTypeUnknow = 0,
    DeviceTypeOne,
    DeviceTypeTwo,
    DeviceTypeThree,
    DeviceTypeFour,
    DeviceTypeLcdOne
} DeviceType;

typedef enum : NSUInteger {
    DeviceTempIndexOne = 1,
    DeviceTempIndexTwo,
    DeviceTempIndexThree,
    DeviceTempIndexFour
} DeviceTempIndex;

@interface SystemManager : NSObject

+(SystemManager *)shareManager;

@property (nonatomic, copy)     NSString *tempUnit;         //温度单位（°F/℃）
@property (nonatomic, strong)   NSArray *alarmList;         //铃声名列表
@property (nonatomic, strong)   NSArray *alarmMusicList;    //铃声音乐名列表
@property (nonatomic, assign)   NSInteger timerAlarm;       //时间铃声索引
@property (nonatomic, assign)   NSInteger tempAlarm;        //温度铃声索引

@property (nonatomic, assign)   DeviceType currentDeviceType;    //当前蓝牙设备类型（1，4）
@property (nonatomic, assign)   CGFloat deviceTempOne;          //探头1当前温度
@property (nonatomic, assign)   CGFloat deviceTempTwo;          //探头2当前温度
@property (nonatomic, assign)   CGFloat deviceTempThree;        //探头3当前温度
@property (nonatomic, assign)   CGFloat deviceTempFour;         //探头4当前温度


@property (nonatomic, strong)   NSMutableArray *tempArray1;
@property (nonatomic, strong)   NSMutableArray *tempArray2;
@property (nonatomic, strong)   NSMutableArray *tempArray3;
@property (nonatomic, strong)   NSMutableArray *tempArray4;

@property (nonatomic, assign)   BOOL needShowTempAlert1;        //需要显示温度提示1
@property (nonatomic, assign)   BOOL needShowTempAlert2;        //需要显示温度提示2
@property (nonatomic, assign)   BOOL needShowTempAlert3;        //需要显示温度提示3
@property (nonatomic, assign)   BOOL needShowTempAlert4;        //需要显示温度提示4

//摄氏度转换成华氏度
-(CGFloat)calculateFahrenheitTemperature:(CGFloat)c;

//华氏度转换成摄氏度
-(CGFloat)calculateCentigradeTemperature:(CGFloat)f;

//摄氏度转换成华氏度
-(CGFloat)tempConvertFahrenheit:(CGFloat)c;

//根据蓝牙名称返回类型
-(DeviceType)getDeviceTypeWithBluename:(NSString *)name;

-(NSArray *)getTempArrayWithNumber:(NSInteger)number;

-(void)clearTempArray;


-(void)playTimeAlarm;
-(void)playTempAlarm;
-(void)playAlarmWithIndex:(NSInteger)index;
-(void)pauseMusic;
-(void)playBackgroundMusic;
-(void)pauseBackgroundMusic;

#pragma mark 设置本地推送消息
-(void)sendLocalNotificationWithTitle:(NSString *)title;
-(void)sendLocalNotificationTime;   //时间到
-(void)sendLocalNotificationTemp;   //温度警报
-(void)registerNotificationSetting; //注册通知


//记录日志
-(void)addLogWithA:(int)a b:(int)b c:(int)c d:(int)d e:(int)e;
-(void)saveLogData;

#pragma mark - 设置温度显示
-(BOOL)getNeedTempAlertIndex:(DeviceTempIndex)index;    
-(void)showTempAlertWithIndex:(DeviceTempIndex)index; //显示
-(void)hideTempAlertWithIndex:(DeviceTempIndex)index; //隐藏
-(void)showTempAlertTimerWithIndex:(DeviceTempIndex)index;    //30秒后设置显示
@end
