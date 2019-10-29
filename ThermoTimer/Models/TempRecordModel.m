//
//  TempRecordModel.m
//  ThermoTimer
//
//  Created by gejiangs on 15/11/3.
//  Copyright © 2015年 gejiangs. All rights reserved.
//

#import "TempRecordModel.h"

@implementation TempRecordModel

-(NSString *)timeString
{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"mm:ss"];
    
    return [dataFormatter stringFromDate:_date];
    
}

@end
