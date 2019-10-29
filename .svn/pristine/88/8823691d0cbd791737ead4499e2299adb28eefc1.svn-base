//
//  NSObject+Utils.m
//  Framework
//
//  Created by gejiangs on 15/4/7.
//  Copyright (c) 2015年 guojiang. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)

-(void)dispatchTimerWithTime:(CGFloat)time block:(void (^)(void))block
{
    dispatch_time_t time_t = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(time * NSEC_PER_SEC));
    
    dispatch_after(time_t, dispatch_get_main_queue(), ^{ block(); });
}

-(void)dispatchAsyncMainQueue:(void (^)(void))block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

-(void)dispatchAsyncGlobalQueue:(void (^)(void))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}


-(NSString *)languageKey:(NSString *)key
{
    return NSLocalizedString(key, nil);
}


@end
