//
//  FoodSettingCell.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "FoodSettingCell.h"

@interface FoodSettingCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *lineView;
@property (weak, nonatomic) IBOutlet UILabel *tempUnitLabel;
@property (weak, nonatomic) IBOutlet UIButton *bgButton;

@property (nonatomic, strong)   FoodModel *foodModel;


@end

@implementation FoodSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"FoodSettingCell" owner:nil options:nil];
        self = [array firstObject];
        
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)initUI
{
    self.titleLabel.textColor = APP_Yellow_Color;
    self.tempUnitLabel.text = [SystemManager shareManager].tempUnit;
    
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellInfo:(FoodModel *)model indexRow:(NSInteger)row
{
    self.foodModel = model;
    
    self.titleLabel.text = [model.tempTitles objectAtIndex:row];
    NSNumber *number = [model.tempValues objectAtIndex:row];
    NSInteger tempValue = [number integerValue];
    if (tempValue == -1 || row == [model.tempValues count]-1) {
        self.lineView.hidden = NO;
        self.textField.enabled = YES;
        self.textField.text = @"";
        if (tempValue > 0) {
            self.textField.text = [NSString stringWithFormat:@"%d", (int)model.gCustomValue];
        }
        self.titleLabel.textColor = APP_Yellow_Color;
        self.bgButton.hidden = NO;
        self.textField.textColor = [UIColor whiteColor];
        self.tempUnitLabel.textColor = [UIColor whiteColor];
    }else{
        tempValue = [[SystemManager shareManager] tempConvertFahrenheit:tempValue];
        self.lineView.hidden = YES;
        self.textField.enabled = NO;
        self.textField.text = [NSString stringWithFormat:@"%d", (int)tempValue];
        self.titleLabel.textColor = APP_Red_Color;
        self.bgButton.hidden = YES;
        self.textField.textColor = APP_Red_Color;
        self.tempUnitLabel.textColor = APP_Red_Color;
    }
    
    if (model.selectedIndex == row) {
        self.iconView.image = [UIImage imageNamed:@"setting_btn_marquee_yellow_pre"];
    }else{
        self.iconView.image = [UIImage imageNamed:@"setting_btn_marquee_yellow"];
    }
}

- (IBAction)buttonClicked:(UIButton *)sender
{
    
}

#pragma mark UITextField Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.textFieldBeginEditBlock) {
        self.textFieldBeginEditBlock(self.textField);
    }
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    CGFloat customValue = [textField.text floatValue];
    NSArray *units = @[@"°F", @"℃"];
    NSInteger tempIndex = [units indexOfObject:[SystemManager shareManager].tempUnit];
    
    //华摄氏度
    if (tempIndex == 0) {
        customValue = [[SystemManager shareManager] calculateCentigradeTemperature:customValue];
    }
    
    self.foodModel.customValue = customValue;
    
    if (self.textFieldEndEditBlock) {
        self.textFieldEndEditBlock(self.textField);
    }
    
    return YES;
}

@end
