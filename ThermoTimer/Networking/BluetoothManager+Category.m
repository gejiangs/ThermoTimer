//
//  BluetoothManager+Category.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/11.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "BluetoothManager+Category.h"
#import "ByteUtil.h"
#import "AppDelegate.h"
#import "TKAlertView.h"
#import "SingleDeviceViewController.h"
#import "MultipleDeviceViewController.h"
#import "TempRecordModel.h"
#import "DataManager.h"

@implementation BluetoothManager (Category)


-(void)didConnectPeripheral
{
    NSLog(@"设备连接成功");
}

/**
 *  锁铃
 */
- (void)blockingWithIndex:(DeviceTempIndex)index
{
    Byte mode[6];
    mode[0] = 0x60;
    mode[1] = 0xbe;
    mode[2] = 0x01;
    mode[3] = index-1;
    mode[4] = 0x00;
    mode[5] = 0x00;
    
    NSData *modeData = [NSData dataWithBytes:mode length:6];
    
    [self sendOrderData:modeData];
}

/**
 *  解锁
 */
- (void)deblockingWithIndex:(DeviceTempIndex)index
{
    Byte mode[6];
    mode[0] = 0x60;
    mode[1] = 0xbe;
    mode[2] = 0x00;
    mode[3] = index-1;
    mode[4] = 0x00;
    mode[5] = 0x00;
    
    NSData *modeData = [NSData dataWithBytes:mode length:6];
    
    [self sendOrderData:modeData];
}


//设置手机当前温度类型至硬件
-(void)setCurrentTempType
{
    if ([[SystemManager shareManager].tempUnit isEqualToString:@"℃"]) {
        [self setTempTypeC];
    }else{
        [self setTempTypeF];
    }
}

//设置温度类型为摄氏度
-(void)setTempTypeC
{
    Byte mode[6];
    mode[0] = 0xCF;
    mode[1] = 0x12;
    mode[2] = 0x00;
    mode[3] = 0x00;
    mode[4] = 0x00;
    mode[5] = 0x00;
    
    NSData *modeData = [NSData dataWithBytes:mode length:6];
    
    [self sendOrderData:modeData];
}

//设置温度类型为华摄氏度
-(void)setTempTypeF
{
    Byte mode[6];
    mode[0] = 0xCF;
    mode[1] = 0x12;
    mode[2] = 0x01;
    mode[3] = 0x00;
    mode[4] = 0x00;
    mode[5] = 0x00;
    
    NSData *modeData = [NSData dataWithBytes:mode length:6];
    
    [self sendOrderData:modeData];
}



-(void)facebackOrder
{
    Byte mode[6];
    mode[0] = 0xC0;
    mode[1] = 0x86;
    mode[2] = 0x00;
    mode[3] = 0x00;
    mode[4] = 0x00;
    mode[5] = 0x00;
    
    NSData *modeData = [NSData dataWithBytes:mode length:6];
    
    [self sendOrderData:modeData];
}


-(void)sendMaxTemp:(CGFloat)temp number:(NSInteger)number
{
    Byte mode[6];
    mode[0] = 0xD7;
    mode[1] = number;
    mode[2] = 0x00;
    if (temp - 255 > 0) {
        mode[3] = temp - 255;
        mode[4] = 0xff;
    }else{
        mode[3] = 0x00;
        mode[4] = temp;
    }
    mode[5] = 0x00;
    
    NSData *modeData = [NSData dataWithBytes:mode length:6];
    
    [self sendOrderData:modeData];
}


//发送数据
-(void)sendOrderData:(NSData *)data
{
    NSLog(@"发送数据:%@", data);
    for(CBService *service in self.peripheral.services){
        for(CBCharacteristic *characteristic in service.characteristics){
            if (characteristic.properties == CBCharacteristicPropertyWrite) {
                [self.peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                break;
            }
        }
    }
}

-(void)fourDeviceTempUpdate:(void (^)(NSInteger, CGFloat))block
{
    self.fourDeviceTempBlock = block;
}

-(void)singleDeviceNormalTempUpdate:(void(^)(CGFloat temp))block
{
    self.singleDeviceNormalTempBlock = block;
}

-(void)receiveWithPeripheral:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"receive error:%@", error);
        return;
    }
    
//    NSLog(@"收到的数据：%@",characteristic.value);
    NSString *receiveString = [characteristic.value hexToString];
    receiveString = [receiveString stringByReplacingOccurrencesOfString:@" " withString:@""];
    receiveString = [receiveString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    receiveString = [receiveString stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    Byte data[255];
    [characteristic.value getBytes:data range:NSMakeRange(0, characteristic.value.length)];
    
    //连接成功后，设备返回指令
    if ([receiveString hasPrefix:@"a0"]) {
        //正常连接，反馈指令
        [self facebackOrder];
    }
    //收到设备返回的温度信息
    else if ([receiveString hasPrefix:@"08"] && [receiveString length] == 12){
        
        int number  = [[[receiveString substringWithRange:NSMakeRange(2, 2)] turn16to10] intValue];
        BOOL isPlus = [[[receiveString substringWithRange:NSMakeRange(4, 2)] turn16to10] intValue] == 0;
        int height  = [[[receiveString substringWithRange:NSMakeRange(6, 2)] turn16to10] intValue];
        int low     = [[[receiveString substringWithRange:NSMakeRange(8, 2)] turn16to10] intValue];
        int decimal = [[[receiveString substringWithRange:NSMakeRange(10, 2)] turn16to10] intValue];
        
        //080100ff ffff(后三位为ff的情况为断开)
        if (height == 255 && low == 255 && decimal == 255) {
            height = 0;
            low = 0;
            decimal = 0;
        }
        height      = height * 255;//0x01 0x01表示256，所以高位需要*255
        CGFloat temp = [[NSString stringWithFormat:@"%d.%d", height+low, decimal] floatValue];
        temp = isPlus ? temp : -temp;   //正负
        
        
        if ([SystemManager shareManager].currentDeviceType == DeviceTypeOne){
            
            //常温
            if (number == 0) {
                if (self.singleDeviceNormalTempBlock) {
                    self.singleDeviceNormalTempBlock(temp);
                }
                return;
            }
            
            [SystemManager shareManager].deviceTempOne = temp;
            
            TempRecordModel *record = [[TempRecordModel alloc] init];
            record.temp = temp;
            record.date= [NSDate date];
            
            //更新探头温度
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSingleTemp object:record];
            
        }else{
            if (number == 0) {
                return;
            }
            
            if (self.fourDeviceTempBlock) {
                self.fourDeviceTempBlock(number, temp);
            }
            
            switch (number) {
                    case 1:
                    [SystemManager shareManager].deviceTempOne = temp;
                    break;
                    case 2:
                    [SystemManager shareManager].deviceTempTwo = temp;
                    break;
                    case 3:
                    [SystemManager shareManager].deviceTempThree = temp;
                    break;
                    case 4:
                    [SystemManager shareManager].deviceTempFour = temp;
                    break;
                default:
                    break;
            }
        }
    }
    //单通道
    else if([receiveString hasPrefix:@"20"]){
        
        BOOL isNormal = YES;
        //低电量
        if (data[1] == 0xba && data[2] == 0x01) {
            isNormal = NO;
        }
        //正常电量
        else if (data[1] == 0xba && data[2] == 0x00) {
            isNormal = YES;
        }
        if (self.updateDeviceBatteryBlock) {
            self.updateDeviceBatteryBlock(isNormal);
        }
        
        //设置当前设备类型
        [self setCurrentTempType];
    }
    //硬件切换成摄氏度
    else if ([receiveString isEqualToString:@"cf1200000000"]){
        [SystemManager shareManager].tempUnit = @"℃";
    }
    //硬件切换成华摄氏度
    else if ([receiveString isEqualToString:@"cf1201000000"]){
        [SystemManager shareManager].tempUnit = @"°F";
    }
}


//蓝牙断开处理
-(void)blueDisconnectHandler
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *navi = (UINavigationController *)appDelegate.window.rootViewController;
    if ([[navi viewControllers] count] <= 2) {
        return;
    }
    
    static int show;
    if (show) {
        return;
    }
    show = YES;
    TKAlertView *alert = [[TKAlertView alloc] initWithTitle:[self languageKey:@"blueDisconnect"]
                                                buttonTitle:[self languageKey:@"Search again"]
                                                 sureAction:^{
                                                     show = NO;
                                                     [self searchAgainBlue];
                                                 }];
    [alert show];
}

-(void)searchAgainBlue
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *navi = (UINavigationController *)appDelegate.window.rootViewController;
    if ([[navi viewControllers] count] <= 2) {
        return;
    }
    UIViewController *vc = [navi.viewControllers objectAtIndex:1];
    
    [WINDOW showActivityView:@""];
    [self startScanBlock:^(NSArray *peripheralArray) {
        
    } finally:^{
        [WINDOW hiddenActivityView];
        if ([self.peripheralArray count] == 1) {
            CBPeripheral *peripheral = [self.peripheralArray firstObject];
            DeviceType type = [[SystemManager shareManager] getDeviceTypeWithBluename:peripheral.name];
            BOOL isSame = type == [SystemManager shareManager].currentDeviceType;
            [self connect:peripheral block:^(BOOL success) {
                if (success) {
                    [WINDOW showActivityView:[Language key:@"ConnectSuccess"] hideAfterDelay:1];
                    if (!isSame) {
                        NSMutableArray *topVCS = [NSMutableArray array];
                        [topVCS addObject:[navi.viewControllers objectAtIndex:0]];
                        [topVCS addObject:[navi.viewControllers objectAtIndex:1]];
                        
                        if (type == DeviceTypeOne) {
                            SingleDeviceViewController *singleVC = [[SingleDeviceViewController alloc] init];
                            [topVCS addObject:singleVC];
                        }else{
                            MultipleDeviceViewController *multipleVC = [[MultipleDeviceViewController alloc] init];
                            multipleVC.deviceType = type;
                            [topVCS addObject:multipleVC];
                        }
                        [navi setViewControllers:topVCS];
                    }
                }else{
                    [WINDOW showActivityView:[Language key:@"ConnectFailure"] hideAfterDelay:1.5];
                }
            }];
            
        }else{
            [navi popToViewController:vc animated:YES];
        }
    }];
}


@end
