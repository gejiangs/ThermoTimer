//
//  AddFoodViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "AddFoodViewController.h"
#import "FoodSettingCell.h"
#import "FoodChoiceViewController.h"
#import "MultipleDeviceViewController.h"
#import "SingleDeviceViewController.h"
#import "TMCache.h"

@interface AddFoodViewController ()<UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)   UITextField *currentEditView;
@property (nonatomic, assign)   BOOL isAdd;

@end

@implementation AddFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LanguageKey(@"FoodAddTitle");
    
    [self setTableViewStyle:UITableViewStyleGrouped];
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
    }];
    self.tableView.tableFooterView = [self getFooterView];
    [self setMoreViewHidden:YES];
    
    //是否为新增
    self.isAdd = self.foodModel == nil;
    
    NSMutableArray *tags = [@[@"1", @"2", @"3", @"4"] mutableCopy];
    NSArray *models = [self getCustomModels];
    for (FoodModel *model in models) {
        NSString *tagString = [NSString stringWithFormat:@"%d", (int)model.tag];
        if ([tags containsObject:tagString]) {
            [tags removeObject:tagString];
        }
    }
    
    if (self.foodModel == nil) {
        self.foodModel = [[FoodModel alloc] init];
        _foodModel.type = -1;
        _foodModel.selectedIndex = 1;
        _foodModel.tag = [[tags firstObject] integerValue];
    }
    
}

-(NSMutableArray *)getCustomModels
{
    return [NSMutableArray arrayWithArray:[[TMCache sharedCache] objectForKey:CustomFoodModel]];
}

-(UIView *)getFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftButton = [footerView addButtonWithTitle:NSLocalizedString(@"OK", nil) target:self action:@selector(leftAction:)];
    leftButton.backgroundColor = APP_Yellow_Color;
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(55);
        make.size.mas_equalTo(Size(120, 40));
    }];
    
    UIButton *rightButton = [footerView addButtonWithTitle:NSLocalizedString(@"Delete", nil) target:self action:@selector(rightAction:)];
    rightButton.backgroundColor = APP_Yellow_Color;
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(55);
        make.size.mas_equalTo(Size(120, 40));
    }];
    
    [footerView distributeSpacingHorizontallyWith:@[leftButton, rightButton]];
    
    return footerView;
}

#pragma mark Button Action
-(void)leftAction:(UIButton *)sender
{
    if (self.currentEditView != nil && self.currentEditView.isEditing) {
        [self.currentEditView resignFirstResponder];
    }
    
    if (self.foodModel.name == nil || [self.foodModel.name length] == 0) {
        [self.view showToastText:[self languageKey:@"TipInputName"] duration:1.5];
        return;
    }
    
    if (self.foodModel.selectedIndex == ([self.foodModel.tempValues count]-1)) {
        NSNumber *number = [self.foodModel.tempValues lastObject];
        if ([number intValue] < 0) {
            [self.view showToastText:[self languageKey:@"TipInputTemp"] duration:1.5];
            return;
        }
    }
    
    if (self.isAdd) {
        [self.foodChoiceViewController insertFoodModel:self.foodModel];
    }else{
        [self.foodChoiceViewController replaceFirstFoodModel:self.foodModel];
    }
    
    UIViewController *rootVC = [self.navigationController.viewControllers objectAtIndex:2];
    if ([rootVC isKindOfClass:[MultipleDeviceViewController class]]) {
        MultipleDeviceViewController *multiple = (MultipleDeviceViewController *)rootVC;
        [multiple replaceFoodInfo:self.foodModel];
        [self.navigationController popToViewController:rootVC animated:YES];
    }else if ([rootVC isKindOfClass:[SingleDeviceViewController class]]){
        SingleDeviceViewController *multiple = (SingleDeviceViewController *)rootVC;
        [multiple replaceFoodInfo:self.foodModel];
        [self.navigationController popToViewController:rootVC animated:YES];
    }
    
}

-(void)rightAction:(UIButton *)sender
{
    if (!self.isAdd) {
        [self.foodChoiceViewController removeCustomFoodModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return [self getFoodSettingCell:tableView cellForRowAtIndexPath:indexPath];
    }
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view removeFromSuperview];
        }
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = LanguageKey(@"FoodTipTitle");
        cell.textLabel.textColor = APP_Red_Color;
    }else if (indexPath.row == 1){
        UITextField *textField = [cell.contentView addTextFieldWithDelegate:self font:[UIFont systemFontOfSize:17]];
        textField.placeholder = LanguageKey(@"FoodPlaceTitle");
        textField.text = self.foodModel.name;
        textField.delegate = self;
        textField.textColor = APP_Yellow_Color;
        [textField makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.left.offset(18);
            make.right.offset(-15);
        }];
    }
    
    return cell;
}

-(FoodSettingCell *)getFoodSettingCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"food_cell";
    FoodSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[FoodSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cell setCellInfo:self.foodModel indexRow:1];
    
    cell.textFieldBeginEditBlock = ^(UITextField *textField){
        self.currentEditView = textField;
    };
    
    cell.textFieldEndEditBlock = ^(UITextField *textField){
        
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 60.f;
    }
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITextField Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentEditView = textField;
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.foodModel.name = textField.text;
    
    return YES;
}

#pragma mark UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.currentEditView != nil && self.currentEditView.isEditing) {
        [self.currentEditView resignFirstResponder];
    }
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
