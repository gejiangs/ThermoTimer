//
//  TKAlertView.m
//  aa
//
//  Created by teki on 16/1/4.
//  Copyright © 2016年 ztx. All rights reserved.
//

#import "TKAlertView.h"

@interface TKAlertView()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, copy) void (^sureAction)();

@property (nonatomic, strong) UIView *backgroudView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *sureButton;
@end


@implementation TKAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title
                  buttonTitle:(NSString *)buttonTitle
                   sureAction:(void (^)())block
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.buttonTitle = buttonTitle;
        self.sureAction = block;
        [self initUI];

    }
    return self;

}


- (void)initUI
{

    self.backgroudView = [UIView new];
    self.backgroudView.backgroundColor = [UIColor blackColor];
    self.backgroudView.alpha = 0.5;
    [self addSubview:self.backgroudView];
    [self.backgroudView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.contentView = [UIView new];
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.layer.masksToBounds = YES;
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(40);
        make.right.equalTo(-40);
        make.height.equalTo(102);
        make.centerY.equalTo(self.backgroudView);
    }];
    
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text = self.title?:@"提示";
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = APP_Red_Color;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(60);
    }];
    
    
    UIView *lineView = [UIView new];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = APP_Red_Color;
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(2);
    }];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setTitle:self.buttonTitle?:@"完成" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:RGB(34, 125, 194) forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.sureButton];
    [self.sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(40);
    }];

}

- (void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
}


- (void)hidden
{
    
    [self removeFromSuperview];
}



- (void)buttonPressed:(UIButton *)button
{
    if (self.sureAction) {
        self.sureAction();
        [self hidden];
    }
}
@end
