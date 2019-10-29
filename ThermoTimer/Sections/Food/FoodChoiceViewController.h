//
//  FoodChoiceViewController.h
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "BaseViewController.h"

@class FoodModel;
@interface FoodChoiceViewController : BaseViewController

-(void)insertFoodModel:(FoodModel *)model;
-(void)replaceFirstFoodModel:(FoodModel *)model;
-(void)removeCustomFoodModel;

@end
