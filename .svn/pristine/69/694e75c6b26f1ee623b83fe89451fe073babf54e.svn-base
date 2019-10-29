//
//  FoodSettingViewController.m
//  ThermoTimer
//
//  Created by gejiangs on 15/8/12.
//  Copyright (c) 2015年 gejiangs. All rights reserved.
//

#import "FoodSettingViewController.h"
#import "FoodSettingCell.h"
#import "MultipleDeviceViewController.h"
#import "SingleDeviceViewController.h"

@interface FoodSettingViewController ()

@property (nonatomic, strong) UITextField *currentEditView;

@end

@implementation FoodSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LanguageKey(@"FoodAddTitle");
    
    [self setTableViewStyle:UITableViewStyleGrouped];
    [self.tableView updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
    }];
    
    self.tableView.tableFooterView = [self getFooterView];
    
    [self setMoreViewHidden:YES];
}

-(UIView *)getFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 150)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGB(200, 199, 204);
    [footerView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(-0.5);
        make.height.offset(0.5f);
    }];
    
    
    UIButton *startButton = [footerView addButtonWithTitle:NSLocalizedString(@"StartCooking", nil) target:self action:@selector(startAction:)];
    startButton.backgroundColor = APP_Yellow_Color;
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(Size(120, 40));
        make.center.equalTo(footerView);
    }];
    
    return footerView;
}

#pragma mark Button Action
-(void)startAction:(UIButton *)sender
{
    if (self.currentEditView != nil && self.currentEditView.isEditing) {
        [self.currentEditView resignFirstResponder];
    }
    
    if (self.foodModel.selectedIndex == -1) {
        [self.view showToastText:[self languageKey:@"TipInputTemp"] duration:1.5];
        return;
    }
    if (self.foodModel.selectedIndex == ([self.foodModel.tempTitles count]-1)) {
        NSNumber *number = [self.foodModel.tempValues lastObject];
        if ([number intValue] < 0) {
            [self.view showToastText:[self languageKey:@"TipInputTemp"] duration:1.5];
            return;
        }
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


#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.foodModel.tempTitles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    FoodSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[FoodSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cell setCellInfo:self.foodModel indexRow:indexPath.row];
    
    cell.textFieldBeginEditBlock = ^(UITextField *textField){
        self.currentEditView = textField;
    };
    
    cell.textFieldEndEditBlock = ^(UITextField *textField){
        self.currentEditView = nil;
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.foodModel.selectedIndex = indexPath.row;
    [self.tableView reloadData];
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
