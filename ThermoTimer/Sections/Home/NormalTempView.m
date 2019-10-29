//
//  NormalTempView.m
//  ThermoTimer
//
//  Created by gejiangs on 15/11/23.
//  Copyright © 2015年 gejiangs. All rights reserved.
//

#import "NormalTempView.h"
#import "BluetoothManager.h"
#import "BluetoothManager+Category.h"

@interface NormalTempView ()

@property (nonatomic, strong)   UILabel *valueLabel;

@end

@implementation NormalTempView

-(id)init
{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    NSString *unit = [SystemManager shareManager].tempUnit;
    NSString *value = [NSString stringWithFormat:@"%@%@", @"0",unit];
    
    self.valueLabel = [self addLabelWithText:value font:[UIFont boldSystemFontOfSize:25] color:APP_Red_Color];
    [_valueLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
    }];
    
    [_valueLabel addAttributesText:unit fontSize:13];
    
    UILabel *normalLabel = [self addLabelWithText:[self languageKey:@"NormalTemp"] font:[UIFont systemFontOfSize:12] color:APP_Red_Color];
    [normalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
    }];
        
    [self updateNormalTemp];
}

-(void)setLabelValue:(CGFloat)temp
{
    temp = [[SystemManager shareManager] tempConvertFahrenheit:temp];
    
    NSString *unit = [SystemManager shareManager].tempUnit;
    NSString *value = [NSString stringWithFormat:@"%0.1f%@", temp, unit];
    self.valueLabel.text = value;
    
    [_valueLabel addAttributesText:unit fontSize:13];
    if (temp == 0.f) {
        self.valueLabel.text = @"--";
    }
}

-(void)updateNormalTemp
{
    [[BluetoothManager shareManager] setSingleDeviceNormalTempBlock:^(CGFloat temp) {
        [self setLabelValue:temp];
    }];
}

@end
