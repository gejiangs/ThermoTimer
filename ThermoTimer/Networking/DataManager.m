//
//  DataManager.m
//  ThermoTimer
//
//  Created by jiang on 16/11/30.
//  Copyright © 2016年 gejiangs. All rights reserved.
//

#import "DataManager.h"
#import "TMCache.h"

#define FoodmodelCacheSingle        @"FoodmodelCacheSingle"
#define FoodmodelCacheMultiple      @"FoodmodelCacheMultiple"

@implementation DataManager

+ (id)shareManager
{
    static id share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      share = [[self alloc] init];
                  });
    return share;
}

-(void)saveSingleFoodmodel:(FoodModel *)model
{
    if (model == nil) {NSLog(@"清除成功");
        [[TMCache sharedCache] removeObjectForKey:FoodmodelCacheSingle];return;
    }NSLog(@"设置温度");
    [[TMCache sharedCache] setObject:model forKey:FoodmodelCacheSingle];
}

-(FoodModel *)getSingleFoodModel
{
    FoodModel *m = [[TMCache sharedCache] objectForKey:FoodmodelCacheSingle];
    if (m == nil) {
        m = [[FoodModel alloc] init];
        m.deviceConnected = YES;
        m.number = 1;
    }
    
    return m;
}

-(NSString *)multipleKey
{
    return [NSString stringWithFormat:@"%@_%d", FoodmodelCacheMultiple, (int)[SystemManager shareManager].currentDeviceType];;
}

-(void)saveMultipleFoodmodel:(FoodModel *)model
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[TMCache sharedCache] objectForKey:[self multipleKey]]];
    [dict setObject:model forKey:@(model.number)];
    
    [[TMCache sharedCache] setObject:dict forKey:[self multipleKey]];
}

-(NSMutableArray *)getMultipleFoodmodels
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *dict = [[TMCache sharedCache] objectForKey:[self multipleKey]];
    NSInteger count = [SystemManager shareManager].currentDeviceType;
    for (int i=1; i<=count; i++) {
        FoodModel *m = (FoodModel *)[dict objectForKey:@(i)];
        m.number = i;
        if (m == nil) {
            m = [[FoodModel alloc] init];
            m.name = @"";
            m.type = -1;
        }
        [array addObject:m];
    }
    
    return array;
}

-(void)clearCurrentMultipleFoodmodel
{
    [[TMCache sharedCache] removeObjectForKey:[self multipleKey]];
}



@end
