//
//  FoodCell.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "FoodCell.h"

@interface FoodCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation FoodCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"FoodCell" owner:nil options:nil];
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
    self.backgroundColor = APP_Yellow_Color;
    self.titleLabel.backgroundColor = APP_Red_Color;
    
    self.delButton.backgroundColor = APP_Yellow_Color;
    self.delButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.delButton.layer.borderWidth = 2.f;
    self.delButton.layer.masksToBounds = YES;
    self.delButton.layer.cornerRadius = 15.f;
}

-(void)setCellInfo:(FoodModel *)model
{
    self.titleLabel.text = model.name;
    self.iconImageView.image = [UIImage imageNamed:model.iconName];
    self.delButton.hidden = model.type != -1;
}

@end
