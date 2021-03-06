//
//  FoodModel.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

//实现NSCoding
MJCodingImplementation

//以下属性不进行归档
+ (NSArray *)ignoredCodingPropertyNames
{
    return @[@"tempTitles", @"tempValues", @"tempArray1", @"tempArray2", @"tempArray3", @"tempArray4", @"gCustomValue"];
}

-(id)init
{
    if (self = [super init]) {
        
        self.deviceConnected = NO;
        self.selectedIndex = -1;
        self.countDownTime = -1;
        self.customValue = -1;
        self.type = -1;
        self.tag = 0;
        
        self.tempArray1 = [NSMutableArray array];
        self.tempArray2 = [NSMutableArray array];
        self.tempArray3 = [NSMutableArray array];
        self.tempArray4 = [NSMutableArray array];
    }
    return self;
}

-(NSString *)name
{
    if (_type == -1) {
        return _name;
    }
    NSArray *names = @[NSLocalizedString(@"TempIndoor", nil),
                       NSLocalizedString(@"TempBeef", nil),
                       NSLocalizedString(@"TempLamb", nil),
                       NSLocalizedString(@"TempChicken", nil),
                       NSLocalizedString(@"TempTurkey", nil),
                       NSLocalizedString(@"TempPork", nil),
                       NSLocalizedString(@"TempFish", nil),
                       NSLocalizedString(@"TempHambuge", nil)];
    
    return [names objectAtIndex:_type];
}

-(NSString *)iconName
{
    if (_type == -1) {
        return @"choice_icon_add";
    }
    NSArray *iconNames = @[@"choice_icon_indoor",
                       @"choice_icon_beef",
                       @"choice_icon_lamb",
                       @"choice_icon_chicken",
                       @"choice_icon_turkey",
                       @"choice_icon_pork",
                       @"choice_icon_fish",
                       @"choice_icon_hamburg"];
    
    return [iconNames objectAtIndex:_type];
}

-(NSString *)iconNameRed
{
    if (_type == -1) {
        return @"choice_icon_add_red";
    }
    NSArray *iconNames = @[@"choice_icon_indoor_red",
                           @"choice_icon_beef_red",
                           @"choice_icon_lamb_red",
                           @"choice_icon_chicken_red",
                           @"choice_icon_turkey_red",
                           @"choice_icon_pork_red",
                           @"choice_icon_fish_red",
                           @"choice_icon_hamburg_red"];
    
    return [iconNames objectAtIndex:_type];
}

-(NSArray *)tempTitles
{
    NSArray *v = @[];
    switch (_type) {
        case -1:
            v = @[NSLocalizedString(@"TempWelldone", nil), NSLocalizedString(@"TempSettingTitle", nil)];
            break;
        case 0:
            v = @[NSLocalizedString(@"TempComfortable", nil), NSLocalizedString(@"TempSetting", nil)];
            break;
        case 1:
            v = @[NSLocalizedString(@"TempRare", nil), NSLocalizedString(@"TempMedRare", nil),
                  NSLocalizedString(@"TempMeddium", nil), NSLocalizedString(@"TempMedAll", nil),
                  NSLocalizedString(@"TempSetting", nil)];
            break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            v = @[NSLocalizedString(@"TempWelldone", nil), NSLocalizedString(@"TempSetting", nil)];
            break;
        case 7:
            v = @[NSLocalizedString(@"TempWelldone", nil), NSLocalizedString(@"TempSetting", nil)];
            break;
        default:
            break;
    }
    
    return v;
}

-(NSArray *)tempValues
{
    NSArray *v = @[];
    switch (_type) {
        case -1:
            v = @[@88, @(self.customValue)];
            break;
        case 0:
            v = @[@25, @(self.customValue)];
            break;
        case 1:
            v = @[@60, @68, @75, @81, @(self.customValue)];
            break;
        case 2:
            v = @[@81, @(self.customValue)];
            break;
        case 3:
            v = @[@83, @(self.customValue)];
            break;
        case 4:
            v = @[@83, @(self.customValue)];
            break;
        case 5:
            v = @[@83, @(self.customValue)];
            break;
        case 6:
            v = @[@88, @(self.customValue)];
            break;
        case 7:
            v = @[@85, @(self.customValue)];
            break;
        default:
            break;
    }
    
    return v;
}

-(CGFloat)gCustomValue
{
    if (_customValue < 0) {
        return -1;
    }
    
    return [[SystemManager shareManager] tempConvertFahrenheit:_customValue];
}

-(NSString *)selectedTitle
{
    if (self.selectedIndex == -1) {
        return @"";
    }
    return [self.tempTitles objectAtIndex:self.selectedIndex];
}

-(CGFloat)selectedValue
{
    if (self.selectedIndex == -1) {
        return -1;
    }
    
    NSNumber *number = [self.tempValues objectAtIndex:self.selectedIndex];

    CGFloat temp = [[SystemManager shareManager] tempConvertFahrenheit:[number floatValue]];
    
    return temp;
}

-(CGFloat)deviceTempValue
{
    return [[SystemManager shareManager] tempConvertFahrenheit:_deviceTempValue];
}


@end
