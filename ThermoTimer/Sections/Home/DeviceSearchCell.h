//
//  DeviceSearchCell.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/17.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *reSearchButton;

//开始箭头动画
-(void)startArrowAnimation;

//停止箭头动画
-(void)stopArrowAnimation;

@end
