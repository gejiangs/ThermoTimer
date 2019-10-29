//
//  ProductViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 16/1/8.
//  Copyright © 2016年 gejiangs. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setMoreViewHidden:YES];
    self.topImageView.hidden = NO;
    [self initUI];
    
    
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 40, 40);
    leftBarButton.alpha = 0.5f;
    [leftBarButton setImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [leftBarButton addTarget:self action:@selector(viewWillBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBarButton];
    [leftBarButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(30);
    }];
}

-(void)viewWillBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)initUI
{
    [self.view addSubview:self.scrollView];
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(100);
    }];
    
    
    UIView* contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    
    NSString *imageName = @"image_two_name";
    if (self.deviceType == DeviceTypeOne) {
        imageName = @"image_one_name";
    }else if (self.deviceType == DeviceTypeLcdOne){
        imageName = @"image_one_lcd_name";
    }
    UIImage *image = [UIImage imageNamed:[self languageKey:imageName]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.height.equalTo(self.view.width).multipliedBy(0.5);
        make.width.equalTo(imageView.height).multipliedBy(860/344.f);
    }];
    /// 显示文字
    UILabel *textLabel = [imageView addLabelWithText:[self languageKey:@"textLabel"]];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:8.0f];
    [imageView addSubview:textLabel];
    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.right).equalTo(-5);
        make.bottom.equalTo(-5);
    }];
    
    UIView *descView = [UIView new];
    descView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:descView];
    [descView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(imageView.bottom).offset(20);
    }];
    
    NSString *text = @"";
    if (self.deviceType == DeviceTypeOne) {
        text = [self languageKey:@"MiniGrill"];
    }else if (self.deviceType == DeviceTypeTwo){
        text = [self languageKey:@"2ProbGrill"];
    }else if (self.deviceType == DeviceTypeThree){
        text = [self languageKey:@"3ProbGrill"];
    }else if (self.deviceType == DeviceTypeFour){
        text = [self languageKey:@"4ProbGrill"];
    }else if (self.deviceType == DeviceTypeLcdOne){
        text = [self languageKey:@"1ProbGrillLCD"];
    }
    UILabel *titleLabel = [descView addLabelWithText:text font:[UIFont systemFontOfSize:18] color:APP_Red_Color];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.centerX.equalTo(descView);
    }];
    
    NSString *desc = @"";
    if (self.deviceType == DeviceTypeOne) {
        desc = [self languageKey:@"ProductDesc1"];
    }else if (self.deviceType == DeviceTypeTwo){
        desc = [self languageKey:@"ProductDesc2"];
    }else if (self.deviceType == DeviceTypeThree){
        desc = [self languageKey:@"ProductDesc3"];
    }else if (self.deviceType == DeviceTypeFour){
        desc = [self languageKey:@"ProductDesc4"];
    }else if (self.deviceType == DeviceTypeLcdOne){
        desc = [self languageKey:@"ProductDescLcd1"];
    }
    UILabel *descLabel = [descView addLabelWithText:desc font:[UIFont systemFontOfSize:14]];
    descLabel.textColor = [UIColor grayColor];
    descLabel.numberOfLines = 0;
    [descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.bottom).offset(15);
        make.left.offset(10);
        make.right.offset(-15);
    }];
    
    
    UIView *rowView1 = [UIView new];
    [descView addSubview:rowView1];
    [rowView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(descLabel.bottom).offset(20);
        make.height.offset(70);
    }];
    NSMutableArray *views1 = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        UIView *itemView = [self getItemViewWithIndex:i];
        [rowView1 addSubview:itemView];
        [itemView makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.bottom.offset(0);
            make.width.offset(80);
        }];
        [views1 addObject:itemView];
    }
    [rowView1 distributeSpacingHorizontallyWith:views1];
    
    
    UIView *rowView2 = [UIView new];
    [descView addSubview:rowView2];
    [rowView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(rowView1.bottom).offset(10);
        make.height.offset(70);
    }];
    NSMutableArray *views2 = [NSMutableArray array];
    for (int i=3; i<6; i++) {
        UIView *itemView = [self getItemViewWithIndex:i];
        [rowView2 addSubview:itemView];
        [itemView makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.bottom.offset(0);
            make.width.offset(80);
        }];
        [views2 addObject:itemView];
    }
    [rowView2 distributeSpacingHorizontallyWith:views2];
    
    [descView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(rowView2.bottom).offset(20);
    }];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(descView.bottom).offset(20);
    }];
}

-(UIScrollView *)scrollView
{
    if (_scrollView != nil) {
        return _scrollView;
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.bounces = YES;
    _scrollView.alwaysBounceHorizontal = NO;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    return _scrollView;
}

#pragma makr - ItemView
-(UIView *)getItemViewWithIndex:(NSInteger)index
{
    NSArray *images = @[@"icon_bluetooth", @"icon_battery", @"icon_temp", @"icon_alarm", @"icon_cruve", @"icon_time"];
    NSArray *titles = @[[self languageKey:@"ProductIcon1"], [self languageKey:@"ProductIcon2"], [self languageKey:@"ProductIcon3"],
                        [self languageKey:@"ProductIcon4"], [self languageKey:@"ProductIcon5"], [self languageKey:@"ProductIcon6"]];
    
    UIView *itemView = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[images objectAtIndex:index]]];
    [itemView addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.size.mas_equalTo(Size(40, 40));
        make.centerX.equalTo(itemView);
    }];
    
    UILabel *descLabel = [itemView addLabelWithText:[titles objectAtIndex:index] font:[UIFont systemFontOfSize:12]];
    descLabel.textColor = [UIColor grayColor];
    [descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.bottom).offset(5);
        make.centerX.equalTo(itemView);
    }];
    descLabel.adjustsFontSizeToFitWidth = YES;
    
    return itemView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
