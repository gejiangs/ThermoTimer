//
//  AlarmSettingViewController.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/13.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "BaseTableViewController.h"

@interface AlarmSettingViewController : BaseTableViewController

@property (nonatomic, assign)   NSInteger alarmType;        //铃声类型（1：时间，2：温度）

@end
