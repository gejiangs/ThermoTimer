//
//  OperationCell.h
//  ThermoTimer
//
//  Created by gejiangs on 15/11/23.
//  Copyright © 2015年 gejiangs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(void)setLogoImagePosition;
-(void)setBlueImagePosition;
-(void)setTipImagePosition;

@end
