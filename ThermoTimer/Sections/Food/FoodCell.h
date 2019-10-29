//
//  FoodCell.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"

@interface FoodCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *delButton;

-(void)setCellInfo:(FoodModel *)model;

@end
