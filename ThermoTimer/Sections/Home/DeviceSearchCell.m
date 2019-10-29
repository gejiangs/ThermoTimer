//
//  DeviceSearchCell.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/17.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "DeviceSearchCell.h"

@interface DeviceSearchCell ()

@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (nonatomic, strong)   NSMutableArray *arrowArray;
@property (nonatomic, strong)   NSTimer *arrowTimer;

@end

@implementation DeviceSearchCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DeviceSearchCell" owner:nil options:nil];
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
    self.connectLabel.textColor = APP_Red_Color;
    self.connectLabel.text = LanguageKey(@"ConnectTitle");
    [self.reSearchButton setTitle:[NSString stringWithFormat:@" %@ ", [self languageKey:@"MoreSearch"]] forState:UIControlStateNormal];
    
    self.arrowArray = [NSMutableArray array];
    UIView *lastView = nil;
    for (int i=0; i<15; i++) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_red"]];
        arrowView.tag = i;
        [self.contentView addSubview:arrowView];
        [arrowView makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(Size(8, 12));
            make.centerY.equalTo(self.contentView).offset(-3);
            make.left.equalTo(lastView == nil ? @20 : lastView.right);
        }];
        lastView = arrowView;
        [self.arrowArray addObject:arrowView];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//开始箭头动画
-(void)startArrowAnimation
{
    if (self.arrowTimer != nil) {
        [self.arrowTimer invalidate];
        self.arrowTimer = nil;
    }
    [self setArrowAllHidden:YES];
    self.arrowTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeArrowHidden) userInfo:nil repeats:YES];
}

-(void)changeArrowHidden
{
    for (UIImageView *view in self.arrowArray) {
        if (view.hidden) {
            view.hidden = NO;
            if (view.tag == 14) {
                [self setArrowAllHidden:YES];
            }
            break;
        }
    }
}

-(void)setArrowAllHidden:(BOOL)hidden
{
    for (UIImageView *view in self.arrowArray) {
        view.hidden = hidden;
    }
}

//停止箭头动画
-(void)stopArrowAnimation
{
    if (self.arrowTimer != nil) {
        [self.arrowTimer invalidate];
        self.arrowTimer = nil;
    }
    
    [self setArrowAllHidden:NO];
}


@end
