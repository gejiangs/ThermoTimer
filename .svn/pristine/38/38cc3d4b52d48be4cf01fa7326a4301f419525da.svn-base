//
//  DeviceStatuView.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/18.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "DeviceStatuView.h"
#import "BluetoothManager.h"

@interface DeviceStatuView ()

@property (nonatomic, strong)   UIImageView *signalView;    //信号
@property (nonatomic, strong)   UIImageView *batteryView;   //电池电量
@property (nonatomic, strong)   NSTimer *timer;

@end

@implementation DeviceStatuView


-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    UIView *signalBgView = [[UIView alloc] init];
    signalBgView.backgroundColor = APP_Red_Color;
    [self addSubview:signalBgView];
    [signalBgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(20);
    }];
    
    
    self.signalView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_signal_3"]];
    [signalBgView addSubview:_signalView];
    
    [_signalView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(signalBgView);
        make.size.mas_equalTo(Size(24, 16));
    }];
    
    UIView *batteryBgView = [[UIView alloc] init];
    batteryBgView.backgroundColor = APP_Red_Color;
    [self addSubview:batteryBgView];
    [batteryBgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(20);
    }];
    
    self.batteryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_battery_4"]];
    [batteryBgView addSubview:_batteryView];
    [_batteryView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(batteryBgView);
        make.size.mas_equalTo(Size(22, 11));
    }];
    
    [self dispatchTimerWithTime:5 block:^{
       [[BluetoothManager shareManager] updateDeviceRssiBlock:^(int rssi) {
           
       }];
    }];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateDeviceSingal) userInfo:nil repeats:YES];
    
}

-(void)updateDeviceSingal
{
    [[BluetoothManager shareManager] updateDeviceRssiBlock:^(int rssi) {
        NSString *imageName = @"icon_signal_2";
        //高强度
        if (rssi >= -90) {
            imageName = @"icon_signal_3";
        }
        //中等强度
        else if (rssi > -100){
            imageName = @"icon_signal_2";
        }
        //底强度
        else{
            imageName = @"icon_signal_1";
        }
        
        [self dispatchAsyncMainQueue:^{
            self.signalView.image = [UIImage imageNamed:imageName];
        }];
        
    }];
    
    //电池电量是否正常
    [[BluetoothManager shareManager] updateDeviceBatteryBlock:^(BOOL normal) {
        if (!normal) {
            self.batteryView.animationImages = [NSArray arrayWithObjects:
                                                [UIImage imageNamed:@"icon_battery_1"],
                                                [UIImage imageNamed:@"icon_battery_2"],nil ];
            
            self.batteryView.animationDuration=1.0;
            self.batteryView.animationRepeatCount=0;
            [self.batteryView startAnimating];
        }else{
            self.batteryView.animationImages = nil;
            self.batteryView.image = [UIImage imageNamed:@"icon_battery_4"];
            [self.batteryView stopAnimating];
        }
    }];
}

-(void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
