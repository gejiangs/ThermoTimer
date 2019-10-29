//
//  OperationCell.m
//  ThermoTimer
//
//  Created by gejiangs on 15/11/23.
//  Copyright © 2015年 gejiangs. All rights reserved.
//

#import "OperationCell.h"

@interface OperationCell ()

@property (nonatomic, strong)   UIImageView *logoView;

@end

@implementation OperationCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        self = [array firstObject];
        
        [self initUI];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI
{
    self.indexLabel.layer.cornerRadius = 5.f;
    self.indexLabel.layer.masksToBounds = YES;
    
    self.logoView = [[UIImageView alloc] init];
    self.logoView.hidden = YES;
    [self.contentView addSubview:_logoView];
    
    
}

-(void)setLogoImagePosition
{
    self.logoView.hidden = NO;
    self.logoView.image = [UIImage imageNamed:@"AppLogo"];
    CGFloat left = 93.f;
    if ([[self languageKey:@"OperationTitle"] isEqualToString:@"Manual"]) {
        left = 65.f;
    }else if ([[self languageKey:@"OperationTitle"] isEqualToString:@"Mode d'emploi"]){
        left = 170.f;
    }
    [self.logoView remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(20, 20));
        make.top.equalTo(self.detailLabel.top);
        make.left.equalTo(self.detailLabel.left).offset(left);
    }];
}


-(void)setBlueImagePosition
{
//    self.logoView.hidden = NO;
//    self.logoView.image = [[UIImage imageNamed:@"home_icon_blue"] imageWithOverlayColor:RGB(192, 26, 32)];
//    [self.logoView remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(Size(20, 20));
//        make.top.equalTo(self.detailLabel.top).offset(-5);
//        make.left.equalTo(self.detailLabel.left).offset(80);
//    }];
//    
//    [self.detailLabel addAttributesText:@"T2" color:RGB(192, 26, 32)];
}

-(void)setTipImagePosition
{
    self.logoView.hidden = NO;
    self.logoView.image = [UIImage imageNamed:@"home_icon_warn"];
    
    CGFloat left = 70.f;
    if ([[self languageKey:@"OperationTitle"] isEqualToString:@"Mode d'emploi"]){
        left = 85.f;
    }
    
    [self.logoView remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(20, 18));
        make.left.equalTo(self.titleLabel.left).offset(left);
        make.centerY.equalTo(self.titleLabel);
    }];
}

@end
