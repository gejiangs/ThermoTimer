//
//  TempRecordModel.h
//  ThermoTimer
//
//  Created by gejiangs on 15/11/3.
//  Copyright © 2015年 gejiangs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempRecordModel : NSObject

@property (nonatomic, assign)   CGFloat temp;
@property (nonatomic, strong)   NSDate *date;
@property (nonatomic, copy)     NSString *timeString;

@end
